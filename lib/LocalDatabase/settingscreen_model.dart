// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:core';

SqfliteDbModel3 sqfliteDbModelFromJson(String str) =>
    SqfliteDbModel3.fromJson(json.decode(str));
String sqfliteDbModelToJson(SqfliteDbModel3 data) => json.encode(data.toJson());

class SqfliteDbModel3{
  SqfliteDbModel3({
    required this.id,
    required this.Type,
    required this.pin,

  });
  String id;
  String Type;
  String pin;


  factory SqfliteDbModel3.fromJson(Map<String, dynamic> json) =>
      SqfliteDbModel3(
        id: json['id'].toString(),
        Type: json['Type'].toString(),
        pin: json['pin'],
      );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'Type': jsonEncode(Type),
        'pin': jsonEncode(pin),
      };
}