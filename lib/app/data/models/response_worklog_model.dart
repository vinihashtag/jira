// To parse this JSON data, do
//
//     final responseWorklogIssueModel = responseWorklogIssueModelFromMap(jsonString);

import 'dart:convert';

class ResponseWorklogModel {
  final int startAt;
  final int maxResults;
  final int total;
  final List<WorklogModel> worklogs;
  ResponseWorklogModel({
    required this.startAt,
    required this.maxResults,
    required this.total,
    required this.worklogs,
  });

  factory ResponseWorklogModel.fromJson(String str) =>
      ResponseWorklogModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResponseWorklogModel.fromMap(Map<String, dynamic> json) =>
      ResponseWorklogModel(
        startAt: json['startAt'] ?? 0,
        maxResults: json['maxResults'] ?? 50,
        total: json['total'] ?? 0,
        worklogs: List<WorklogModel>.from(
            (json['worklogs']?.map((x) => WorklogModel.fromMap(x))) ?? []),
      );

  Map<String, dynamic> toMap() => {
        'startAt': startAt,
        'maxResults': maxResults,
        'total': total,
        'worklogs': List<dynamic>.from(worklogs.map((x) => x.toMap())),
      };
}

class WorklogModel {
  final String self;
  final AuthorModel author;
  final String created;
  final String updated;
  final String started;
  final String timeSpent;
  final int timeSpentSeconds;
  final String id;
  final String issueId;
  final String comment;

  WorklogModel({
    required this.self,
    required this.author,
    required this.created,
    required this.updated,
    required this.started,
    required this.timeSpent,
    required this.timeSpentSeconds,
    required this.id,
    required this.issueId,
    required this.comment,
  });

  factory WorklogModel.fromJson(String str) =>
      WorklogModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WorklogModel.fromMap(Map<String, dynamic> json) => WorklogModel(
        self: json['self'] ?? '',
        author: AuthorModel.fromMap(json['author']),
        created: json['created'] ?? '',
        updated: json['updated'] ?? '',
        started: json['started'] ?? '',
        timeSpent: json['timeSpent'] ?? '',
        timeSpentSeconds: json['timeSpentSeconds'] ?? 0,
        id: json['id'] ?? '',
        issueId: json['issueId'] ?? '',
        comment: json['comment'] ?? '',
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
        'comment': comment,
      };
}

class AuthorModel {
  AuthorModel({
    required this.self,
    required this.accountId,
    required this.displayName,
    required this.active,
    required this.timeZone,
    required this.accountType,
  });

  final String self;
  final String accountId;
  final String displayName;
  final bool active;
  final String timeZone;
  final String accountType;

  factory AuthorModel.fromJson(String str) =>
      AuthorModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthorModel.fromMap(Map<String, dynamic> json) => AuthorModel(
        self: json['self'],
        accountId: json['accountId'],
        displayName: json['displayName'],
        active: json['active'],
        timeZone: json['timeZone'],
        accountType: json['accountType'],
      );

  Map<String, dynamic> toMap() => {
        'self': self,
        'accountId': accountId,
        'displayName': displayName,
        'active': active,
        'timeZone': timeZone,
        'accountType': accountType,
      };
}
