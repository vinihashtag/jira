import 'package:flutter_test/flutter_test.dart';
import 'package:jira_matic/app/data/models/response_dashboard.dart';
import 'package:jira_matic/app/data/repositories/jira/jira_repository.dart';
import 'package:jira_matic/app/shared/adapters/rest_client/rest_client_adapter.dart';
import 'package:mocktail/mocktail.dart';

class MockRequestClient extends Mock implements RestClientAdapter {}

void main() {
  late RestClientAdapter _request;
  late IJiraRepository _jiraRepository;

  setUp(() {
    _request = RestClientAdapterImpl();
    _jiraRepository = JiraRepository(_request);
  });

  group('Worklogs 1', () {
    test('Should return ResponseDashboardModel when pass all parameters',
        () async {
      //arrange

      //act
      final response = await _jiraRepository.getWorklogs1(
        worklogInitial: '2021-05-01',
        worklogEnd: '2021-05-31',
        worklogAuthor: 'Ricardo Farias',
        project: 'BLZ',
      );

      //assert
      print(
          'Total de horas logadas no projeto no range de data e o usuário: ${response.totalSpent}');
      expect(response, isA<ResponseDashboard>());
      // expect(response > 0, true);
    });

    test('Should return ResponseDashboardModel when pass only user', () async {
      //arrange

      //act
      final response =
          await _jiraRepository.getWorklogs1(worklogAuthor: 'Ricardo Farias');

      //assert
      print('Total de horas logadas no mês do usuário: ${response.totalSpent}');
      expect(response, isA<ResponseDashboard>());
      // expect(response > 0, true);
    });

    test('Should return ResponseDashboardModel when pass only project',
        () async {
      //arrange

      //act
      final response = await _jiraRepository.getWorklogs1(project: 'BLZ');

      //assert
      print('Total de horas logadas no projeto: ${response.totalSpent}');
      expect(response, isA<ResponseDashboard>());
      // expect(response > 0, true);
    });

    test('Should return ResponseDashboardModel when pass only initial date',
        () async {
      //arrange

      //act
      final response =
          await _jiraRepository.getWorklogs1(worklogInitial: '2021-05-01');

      //assert
      print(
          'Total de horas logadas apartir de uma data: ${response.totalSpent}');
      expect(response, isA<ResponseDashboard>());
      // expect(response > 0, true);
    });

    test('Should return ResponseDashboardModel when pass only end date',
        () async {
      //arrange

      //act
      final response =
          await _jiraRepository.getWorklogs1(worklogEnd: '2021-06-30');

      //assert
      print(
          'Total de horas logadas até uma data final: ${response.totalSpent}');
      expect(response, isA<ResponseDashboard>());
      // expect(response > 0, true);
    });

    test('Should return ResponseDashboardModel when pass only range of dates',
        () async {
      //arrange

      //act
      final response = await _jiraRepository.getWorklogs1(
        worklogInitial: '2021-06-01',
        worklogEnd: '2021-06-30',
      );

      //assert
      print(
          'Total de horas logadas em um determinado periodo: ${response.totalSpent}');
      expect(response, isA<ResponseDashboard>());
      // expect(response > 0, true);
    });

    test(
        'Should return ResponseDashboardModel when pass parameters range of dates and user',
        () async {
      //arrange

      //act
      final response = await _jiraRepository.getWorklogs1(
        worklogInitial: '2021-06-01',
        worklogEnd: '2021-06-30',
        worklogAuthor: 'Ricardo Farias',
      );

      //assert
      print(
          'Total de horas logadas de um usuário em um determinado periodo: ${response.totalSpent}');
      expect(response, isA<ResponseDashboard>());
      // expect(response > 0, true);
    });

    test(
        'Should return ResponseDashboardModel when pass parameters range of dates and project',
        () async {
      //arrange

      //act
      final response = await _jiraRepository.getWorklogs1(
        worklogInitial: '2021-05-01',
        worklogEnd: '2021-05-31',
        project: 'BLZ',
      );

      //assert
      print(
          'Total de horas logadas de um usuário em um determinado periodo: ${response.totalSpent}');
      expect(response, isA<ResponseDashboard>());
      // expect(response > 0, true);
    });

    test(
        'Should return ResponseDashboardModel when pass parameters user and project',
        () async {
      //arrange

      //act
      final response = await _jiraRepository.getWorklogs1(
        worklogAuthor: 'Ricardo Farias',
        project: 'BLZ',
      );

      //assert
      print(
          'Total de horas logadas de um usuário em um determinado periodo: ${response.totalSpent}');
      expect(response, isA<ResponseDashboard>());
      // expect(response > 0, true);
    });
  });

  group('Worklogs 2', () {
    test('Should return ResponseDashboardModel when pass parameter date',
        () async {
      //arrange

      //act
      final response =
          await _jiraRepository.getWorklogs2(dateInitial: '2021-06-01');

      //assert
      print(
          'Total de horas logadas apartir de uma data inicial: ${response.totalSpent}');
      expect(response, isA<ResponseDashboard>());
    });
    test(
        'Should return ResponseDashboardModel when pass parameter date and user',
        () async {
      //arrange

      //act
      final response = await _jiraRepository.getWorklogs2(
        dateInitial: '2021-06-01',
        worklogAuthorId: '5fb2c70dd670b8006e5cd2da',
      );

      //assert
      print(
          'Total de horas logadas apartir de uma data inicial e usuário : ${response.totalSpent}');
      expect(response, isA<ResponseDashboard>());
    });
  });
}
