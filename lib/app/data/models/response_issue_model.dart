import 'dart:convert';

class ResponseIssueModel {
  ResponseIssueModel({
    required this.expand,
    required this.startAt,
    required this.maxResults,
    required this.total,
    required this.issues,
  });

  final String expand;
  final int startAt;
  final int maxResults;
  final int total;
  final List<Issue> issues;

  factory ResponseIssueModel.fromJson(String str) =>
      ResponseIssueModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResponseIssueModel.fromMap(Map<String, dynamic> json) =>
      ResponseIssueModel(
        expand: json['expand'] ?? '',
        startAt: json['startAt'],
        maxResults: json['maxResults'],
        total: json['total'],
        issues: List<Issue>.from(
            json['issues']?.map((x) => Issue.fromMap(x)) ?? []),
      );

  Map<String, dynamic> toMap() => {
        'expand': expand,
        'startAt': startAt,
        'maxResults': maxResults,
        'total': total,
        'issues': List<dynamic>.from(issues.map((x) => x.toMap())),
      };

  @override
  String toString() {
    return 'ResponseIssueModel(expand: $expand, startAt: $startAt, maxResults: $maxResults, total: $total, issues: $issues)';
  }
}

class Issue {
  Issue({
    required this.expand,
    required this.id,
    required this.self,
    required this.key,
    required this.fields,
  });

  final String expand;
  final String id;
  final String self;
  final String key;
  final Fields fields;

  factory Issue.fromJson(String str) => Issue.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Issue.fromMap(Map<String, dynamic> json) => Issue(
        expand: json['expand'] ?? '',
        id: json['id'] ?? '',
        self: json['self'] ?? '',
        key: json['key'] ?? '',
        fields: Fields.fromMap(json['fields'] ?? {}),
      );

  Map<String, dynamic> toMap() => {
        'expand': expand,
        'id': id,
        'self': self,
        'key': key,
      };

  @override
  String toString() {
    return 'Issue(expand: $expand, id: $id, self: $self, key: $key, fields: $fields)';
  }
}

class Fields {
  Fields({
    required this.project,
  });

  final Project project;

  factory Fields.fromJson(String str) => Fields.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Fields.fromMap(Map<String, dynamic> json) => Fields(
        project: Project.fromMap(json['project'] ?? {}),
      );

  Map<String, dynamic> toMap() => {
        'project': project.toMap(),
      };

  @override
  String toString() => 'Fields(project: $project)';
}

class Project {
  Project({
    required this.self,
    required this.id,
    required this.key,
    required this.name,
    required this.projectTypeKey,
    required this.simplified,
  });

  final String self;
  final String id;
  final String key;
  final String name;
  final String projectTypeKey;
  final bool simplified;

  factory Project.fromJson(String str) => Project.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Project.fromMap(Map<String, dynamic> json) => Project(
        self: json['self'] ?? '',
        id: json['id'] ?? '',
        key: json['key'] ?? '',
        name: json['name'] ?? '',
        projectTypeKey: json['projectTypeKey'] ?? '',
        simplified: json['simplified'] ?? false,
      );

  Map<String, dynamic> toMap() => {
        'self': self,
        'id': id,
        'key': key,
        'name': name,
        'projectTypeKey': projectTypeKey,
        'simplified': simplified,
      };

  @override
  String toString() {
    return 'Project(self: $self, id: $id, key: $key, name: $name, projectTypeKey: $projectTypeKey, simplified: $simplified)';
  }
}
