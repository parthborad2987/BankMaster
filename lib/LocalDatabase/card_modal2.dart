// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:core';

CardDbModel sqfliteDbModelFromJson(String str) =>
    CardDbModel.fromJson(json.decode(str));
String sqfliteDbModelToJson(CardDbModel data) => json.encode(data.toJson());

class CardDbModel{
  CardDbModel({
    required this.id,
    required this.Fav1,
  });
  String id;
  String Fav1;

  factory CardDbModel.fromJson(Map<String, dynamic> json) =>
      CardDbModel(
        id: json['id'].toString(),
        Fav1: json['Fav1']
      );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'Fav1': jsonEncode(Fav1)
      };
}