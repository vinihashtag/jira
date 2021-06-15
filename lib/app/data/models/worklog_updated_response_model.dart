import 'dart:convert';

class WorklogUpdatedResponseModel {
  WorklogUpdatedResponseModel({
    required this.values,
    required this.since,
    required this.until,
    required this.self,
    required this.lastPage,
  });

  final List<Value> values;
  final int since;
  final int until;
  final String self;
  final bool lastPage;

  factory WorklogUpdatedResponseModel.fromJson(String str) =>
      WorklogUpdatedResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WorklogUpdatedResponseModel.fromMap(Map<String, dynamic> json) =>
      WorklogUpdatedResponseModel(
        values: List<Value>.from(json['values'].map((x) => Value.fromMap(x))),
        since: json['since'] ?? 0,
        until: json['until'] ?? 0,
        self: json['self'] ?? '',
        lastPage: json['lastPage'] ?? true,
      );

  Map<String, dynamic> toMap() => {
        'values': List<dynamic>.from(values.map((x) => x.toMap())),
        'since': since,
        'until': until,
        'self': self,
        'lastPage': lastPage,
      };
}

class Value {
  Value({
    required this.worklogId,
    required this.updatedTime,
    required this.properties,
  });

  final int worklogId;
  final int updatedTime;
  final List<dynamic> properties;

  factory Value.fromJson(String str) => Value.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Value.fromMap(Map<String, dynamic> json) => Value(
        worklogId: json['worklogId'] ?? 0,
        updatedTime: json['updatedTime'] ?? 0,
        properties: List<dynamic>.from(json['properties']?.map((x) => x) ?? []),
      );

  Map<String, dynamic> toMap() => {
        'worklogId': worklogId,
        'updatedTime': updatedTime,
        'properties': List<dynamic>.from(properties.map((x) => x)),
      };
}
