// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:core';

SqfliteDbModel1 sqfliteDbModelFromJson(String str) =>
    SqfliteDbModel1.fromJson(json.decode(str));
String sqfliteDbModelToJson(SqfliteDbModel1 data) => json.encode(data.toJson());

class SqfliteDbModel1{
  SqfliteDbModel1({
    required this.id,
    required this.cardtypeSelected,
    required this.card1Selected,
    required this.BName,
    required this.Cno,
    required this.Exdate,
    required this.Cvv,
    required this.Pin,
    required this.CardHolderName,
    required this.Nickname,
    required this.NetId,
    required this.NetPass,
    required this.NetTPass,
    required this.MobId,
    required this.MobPin,
    required this.MobPass,
    required this.MobTPass,
    required this.HelpLine1,
    required this.HelpLine2,
    required this.HelpLine3,
    required this.HelpLineEmail,
    required this.Fav1,
  });
  String id;
  String cardtypeSelected;
  String card1Selected;
  String BName;
  String Cno;
  String Exdate;
  String Cvv;
  String Pin;
  String CardHolderName;
  String Nickname;
  String NetId;
  String NetPass;
  String NetTPass;
  String MobId;
  String MobPin;
  String MobPass;
  String MobTPass;
  String HelpLine1;
  String HelpLine2;
  String HelpLine3;
  String HelpLineEmail;
  String Fav1;

  factory SqfliteDbModel1.fromJson(Map<String, dynamic> json) =>
      SqfliteDbModel1(
        id: json['id'].toString(),
        cardtypeSelected: json['cardtypeSelected'],
        card1Selected:json['card1Selected'],
        BName: json['BName'],
        Cno: json['Cno'],
        Exdate: json['Exdate'],
        Cvv: json['Cvv'],
        Pin: json['Pin'],
        CardHolderName: json['CardHolderName'],
        Nickname: json['Nickname'],
        NetId: json['NetId'],
        NetPass: json['NetPass'],
        NetTPass: json['NetTPass'],
        MobId: json['MobId'],
        MobPin: json['MobPin'],
        MobPass: json['MobPass'],
        MobTPass: json['MobTPass'],
        HelpLine1: json['HelpLine1'],
        HelpLine2: json['HelpLine2'],
        HelpLine3: json['HelpLine3'],
        HelpLineEmail: json['HelpLineEmail'],
        Fav1: json['Fav1'],
      );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'cardtypeSelected': jsonEncode(cardtypeSelected),
        'card1Selected': jsonEncode(card1Selected),
        'BName': jsonEncode(BName),
        'Cno': jsonEncode(Cno),
        'Exdate': jsonEncode(Exdate),
        'Cvv': jsonEncode(Cvv),
        'Pin': jsonEncode(Pin),
        'CardHolderName': jsonEncode(CardHolderName),
        'Nickname': jsonEncode(Nickname),
        'NetId': jsonEncode(NetId),
        'NetPass': jsonEncode(NetPass),
        'NetTPass': jsonEncode(NetTPass),
        'MobId': jsonEncode(MobId),
        'MobPin': jsonEncode(MobPin),
        'MobPass': jsonEncode(MobPass),
        'MobTPass': jsonEncode(MobTPass),
        'HelpLine1': jsonEncode(HelpLine1),
        'HelpLine2': jsonEncode(HelpLine2),
        'HelpLine3': jsonEncode(HelpLine3),
        'HelpLineEmail': jsonEncode(HelpLineEmail),
        'Fav1': jsonEncode(Fav1)
      };
}