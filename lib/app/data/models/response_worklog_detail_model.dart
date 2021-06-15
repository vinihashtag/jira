import 'dart:convert';

import 'package:jira_matic/app/data/models/response_worklog_model.dart';

class WorklogDetailModel {
  final String self;
  final AuthorModel author;
  final String created;
  final String updated;
  final String started;
  final String timeSpent;
  final int timeSpentSeconds;
  final String id;
  final String issueId;

  WorklogDetailModel({
    required this.self,
    required this.author,
    required this.created,
    required this.updated,
    required this.started,
    required this.timeSpent,
    required this.timeSpentSeconds,
    required this.id,
    required this.issueId,
  });

  factory WorklogDetailModel.fromJson(String str) =>
      WorklogDetailModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WorklogDetailModel.fromMap(Map<String, dynamic> json) =>
      WorklogDetailModel(
        self: json['self'] ?? '',
        author: AuthorModel.fromMap(json['author']),
        created: json['created'] ?? '',
        updated: json['updated'] ?? '',
        started: json['started'] ?? '',
        timeSpent: json['timeSpent'] ?? '',
        timeSpentSeconds: json['timeSpentSeconds'] ?? 0,
        id: json['id'] ?? '',
        issueId: json['issueId'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'self': self,
        'author': author.toMap(),
        'created': created,
        'updated': updated,
        'started': started,
        'timeSpent': timeSpent,
        'timeSpentSeconds': timeSpentSeconds,
        'id': id,
        'issueId': issueId,
      };
}
