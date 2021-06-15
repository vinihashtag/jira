// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';

class UserModel {
  final String self;
  final String accountId;
  final String accountType;
  final String emailAddress;
  final AvatarUrls avatarUrls;
  final String displayName;
  final bool active;
  final String timeZone;
  final String locale;

  UserModel({
    required this.self,
    required this.accountId,
    required this.accountType,
    required this.emailAddress,
    required this.avatarUrls,
    required this.displayName,
    required this.active,
    required this.timeZone,
    required this.locale,
  });

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        self: json['self'],
        accountId: json['accountId'],
        accountType: json['accountType'],
        emailAddress: json['emailAddress'],
        avatarUrls: AvatarUrls.fromMap(json['avatarUrls']),
        displayName: json['displayName'],
        active: json['active'],
        timeZone: json['timeZone'],
        locale: json['locale'],
      );

  Map<String, dynamic> toMap() => {
        'self': self,
        'accountId': accountId,
        'accountType': accountType,
        'emailAddress': emailAddress,
        'avatarUrls': avatarUrls.toMap(),
        'displayName': displayName,
        'active': active,
        'timeZone': timeZone,
        'locale': locale,
      };

  @override
  String toString() {
    return '''UserModel(self: $self, accountId: $accountId, accountType: $accountType, 
            emailAddress: $emailAddress, avatarUrls: $avatarUrls, displayName: $displayName, 
            active: $active, timeZone: $timeZone, locale: $locale)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel && other.accountId == accountId;
  }

  @override
  int get hashCode {
    return accountId.hashCode;
  }
}

class AvatarUrls {
  final String the16X16;
  final String the24X24;
  final String the32X32;
  final String the48X48;

  AvatarUrls({
    required this.the16X16,
    required this.the24X24,
    required this.the32X32,
    required this.the48X48,
  });

  factory AvatarUrls.fromJson(String str) =>
      AvatarUrls.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AvatarUrls.fromMap(Map<String, dynamic> json) => AvatarUrls(
        the16X16: json['16x16'],
        the24X24: json['24x24'],
        the32X32: json['32x32'],
        the48X48: json['48x48'],
      );

  Map<String, dynamic> toMap() => {
        '16x16': the16X16,
        '24x24': the24X24,
        '32x32': the32X32,
        '48x48': the48X48,
      };

  @override
  String toString() {
    return '''AvatarUrls(the16X16: $the16X16, the24X24: $the24X24, the32X32: $the32X32, 
            the48X48: $the48X48)''';
  }
}
