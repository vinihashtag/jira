import 'package:collection/collection.dart';
import 'package:jira_matic/app/data/models/response_dashboard.dart';
import 'package:jira_matic/app/data/models/response_issue_model.dart';
import 'package:jira_matic/app/data/models/response_worklog_detail_model.dart';
import 'package:jira_matic/app/data/models/response_worklog_model.dart';
import 'package:jira_matic/app/data/models/user_model.dart';
import 'package:jira_matic/app/data/models/worklog_updated_response_model.dart';
import 'package:jira_matic/app/shared/adapters/rest_client/rest_client_adapter.dart';
import 'package:jira_matic/app/shared/utils/constants.dart';
import 'package:jira_matic/app/shared/utils/exceptions.dart';

import '../../../shared/utils/enums.dart';

abstract class IJiraRepository {
  Future<List<UserModel>> getAllUsers();
  Future<ResponseDashboard> getWorklogs1({
    String? worklogAuthor,
    String? worklogInitial,
    String? worklogEnd,
    String? project,
  });
  Future<ResponseDashboard> getWorklogs2({
    required String dateInitial,
    String? worklogAuthorId,
  });
}

class JiraRepository implements IJiraRepository {
  final RestClientAdapter _restClient;

  JiraRepository(this._restClient);

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await _restClient.instanceAuth
          .request(url: Constants.getUsers, method: 'GET');

      return (response.data as List).map((e) => UserModel.fromMap(e)).toList();
    } catch (e) {
      throw CustomException(message: 'Erro ao buscar todos os usuários');
    }
  }

  @override
  Future<ResponseDashboard> getWorklogs1({
    String? worklogAuthor,
    String? worklogInitial,
    String? worklogEnd,
    String? project,
  }) async {
    var filter = '/search?jql=';

    final today = DateTime.now();
    var startDate = today;
    var endDate = today;

    // ? Valida data inicial
    if (worklogInitial == null || worklogInitial.isEmpty) {
      final date = DateTime(today.year, today.month, 1)
          .onlyDate
          .split('/')
          .reversed
          .join('-');

      filter += 'updated>=$date and ';
      startDate = DateTime.parse(date);
    } else {
      filter += 'updated>=$worklogInitial and ';
      startDate = DateTime.parse(worklogInitial);
    }

    // ? Valida data final
    if ((worklogEnd == null || worklogEnd.isEmpty)) {
      final date = DateTime(startDate.year, startDate.month + 1, 1)
          .subtract(const Duration(days: 1))
          .onlyDate
          .split('/')
          .reversed
          .join('-');
      filter += 'updated<=$date';
      final newDate = DateTime.parse(date);
      endDate = DateTime(newDate.year, newDate.month, newDate.day, 23, 59, 59);
    } else {
      filter += 'updated<=$worklogEnd';
      final newDate = DateTime.parse(worklogEnd);
      endDate = DateTime(newDate.year, newDate.month, newDate.day, 23, 59, 59);
    }

    // ? Adiciona o usuário solicitado no filtro
    if (worklogAuthor != null && worklogAuthor.isNotEmpty) {
      filter += ' and worklogAuthor="$worklogAuthor"';
    }

    // ? Adiciona o projeto solicitado no filtro
    if (project != null && project.isNotEmpty) {
      filter += ' and project="$project"';
    }

    final issueIds = <String>{};
    final projects = <ProjectDetails>[];

    // * Retorna a lista de issues alterados no periodo solicitado
    try {
      final response = await _restClient.instanceAuth
          .request(
              url: '$filter&maxResults=100&startAt=0&fields=key,project',
              method: 'GET')
          .then((value) => ResponseIssueModel.fromMap(value.data!));

      final issues = response.issues;
      var total = response.total;
      var startAt = response.startAt + 100;

      if (response.total > response.startAt) {
        do {
          final response = await _restClient.instanceAuth
              .request(
                  url:
                      '$filter&maxResults=100&startAt=$startAt&fields=key,project',
                  method: 'GET')
              .then((value) => ResponseIssueModel.fromMap(value.data!));
          issues.addAll(response.issues);
          startAt += 100;
        } while (total >= startAt);
      }

      issues.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));

      for (var issue in issues) {
        final project =
            projects.firstWhereOrNull((p) => p.id == issue.fields.project.id);
        if (project != null) {
          project.issueIds.add(issue.id);
        } else {
          final newProject = ProjectDetails(
            id: issue.fields.project.id,
            name: issue.fields.project.name,
            duration: const Duration(),
            totalSpend: '',
            totalSpendSeconds: 0,
            issueIds: {issue.id},
          );

          newProject.issueIds.add(issue.id);

          projects.add(newProject);
        }
      }

      issueIds.addAll(issues.map((e) => e.id).toList());
    } catch (e) {
      print(e);
      throw CustomException(message: 'Erro ao filtrar id das issues');
    }

    final requests = <Future>[];

    // * Cria as multthreads das requisições
    for (var issueId in issueIds) {
      final response = _restClient.instanceAuth
          .request(url: '${Constants.issue}/$issueId/worklog', method: 'GET');
      requests.add(response);
    }

    try {
      // * Executa requisições simultaneamente
      final futures = await Future.wait(requests);

      var sumTimer = 0;
      var worklogs = <int>[];
      for (var future in futures) {
        final response = ResponseWorklogModel.fromMap(future.data);

        for (var worklog in response.worklogs) {
          final date = DateTime.parse(worklog.updated);
          // * Soma o tempo gasto das tarefas dentro do periodo filtrado
          if (date.isAfter(startDate) && date.isBefore(endDate)) {
            worklogs.add(int.parse(worklog.id));
            sumTimer += worklog.timeSpentSeconds;
            final project = projects.firstWhere(
                (element) => element.issueIds.contains(worklog.issueId));

            project.totalSpendSeconds += worklog.timeSpentSeconds;
            project.duration += Duration(seconds: worklog.timeSpentSeconds);
            project.totalSpend = project.duration.toString();
          }
        }
      }

      worklogs.sort((a, b) => a.compareTo(b));
      print(worklogs);
      print(worklogs.length);

      final timer = today.add(Duration(seconds: sumTimer));

      final totalSpent = timer.difference(today).toString();

      return ResponseDashboard(
        totalSpent: totalSpent,
        projects: projects,
      );
    } catch (e) {
      print(e);
      throw CustomException(message: 'Erro ao worklogs');
    }
  }

  @override
  Future<ResponseDashboard> getWorklogs2({
    required String dateInitial,
    String? worklogAuthorId,
  }) async {
    final issueIds = <int>{};
    final projects = <ProjectDetails>[];

    final dateFormatted = DateTime.parse(dateInitial).millisecondsSinceEpoch;
    try {
      // * Retorna a lista de issues alterados no periodo solicitado
      try {
        final response = await _restClient.instanceAuth
            .request(url: Constants.worklog, method: 'GET', queryParameters: {
          'since': dateFormatted
        }).then((value) => WorklogUpdatedResponseModel.fromMap(value.data!));

        issueIds.addAll(response.values.map((e) => e.worklogId).toList());
        print(issueIds);
        print(issueIds.length);
      } catch (e) {
        print(e);
        throw CustomException(message: 'Erro ao filtrar id dos worklogs');
      }
    } catch (e) {
      throw CustomException(message: 'Erro ao worklogs 2.');
    }

    // * Retorna a lista de issues alterados no periodo solicitado
    try {
      final data = {'ids': issueIds.toList()};

      final response = await _restClient.instanceAuth
          .request(url: Constants.worklogList, method: 'POST', data: data);

      final responseData = (response.data as List)
          .map((e) => WorklogDetailModel.fromMap(e))
          .toList();

      if (worklogAuthorId != null && worklogAuthorId.isNotEmpty) {
        responseData.removeWhere(
            (element) => element.author.accountId != worklogAuthorId);
      }

      final total = responseData.fold(
          0,
          (int previousValue, element) =>
              previousValue + element.timeSpentSeconds);

      final today = DateTime.now();

      final timer = today.add(Duration(seconds: total));

      final totalSpent = timer.difference(today).toString();

      return ResponseDashboard(
        totalSpent: totalSpent,
        projects: projects,
      );
    } catch (e) {
      print(e);
      throw CustomException(message: 'Erro ao filtrar id dos worklogs');
    }
  }
}
