// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:core';

BankDbModel BankDbModelFromJson(String str) =>
   BankDbModel.fromJson(json.decode(str));
String BankDbModelToJson(BankDbModel data) => json.encode(data.toJson());

class BankDbModel{
  BankDbModel({
    required this.id,
    required this.Fav
  });

  String id;
  String Fav;

  factory BankDbModel.fromJson(Map<String, dynamic> json) =>
      BankDbModel(
          id: json['id'].toString(),
          Fav: json['Fav']
      );

  get length => null;

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'Fav':jsonEncode(Fav)
      };
}