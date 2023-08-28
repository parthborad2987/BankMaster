// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:core';

SqfliteDbModel BankDbModelFromJson(String str) =>
    SqfliteDbModel.fromJson(json.decode(str));
String BankDbModelToJson(SqfliteDbModel data) => json.encode(data.toJson());

class SqfliteDbModel{
  SqfliteDbModel({
    required this.id,
    required this.AcTypeSelected,
    required this.BankName,
    required this.AcHolderName,
    required this.AcNo,
    required this.IFSC,
    required this.MICR,
    required this.CustomerId,
    required this.BName,
    required this.BCode,
    required this.BAddress,
    required this.UserId,
    required this.Password,
    required this.TPassword,
    required this.MUserId,
    required this.MPin,
    required this.MPassword,
    required this.MTPassword,
    required this.HelpLine1,
    required this.HelpLine2,
    required this.HelpLine3,
    required this.HelpLineEmail,
    required this.Fav
  });

  String id;
  String AcTypeSelected;
  String BankName;
  String AcHolderName;
  String AcNo;
  String IFSC;
  String MICR;
  String CustomerId;
  String BName;
  String BCode;
  String BAddress;
  String UserId;
  String Password;
  String TPassword;
  String MUserId;
  String MPin;
  String MPassword;
  String MTPassword;
  String HelpLine1;
  String HelpLine2;
  String HelpLine3;
  String HelpLineEmail;
  String Fav;

  factory SqfliteDbModel.fromJson(Map<String, dynamic> json) =>
      SqfliteDbModel(
          id: json['id'].toString(),
          AcTypeSelected:json['AcTypeSelected'],
          BankName: json['BankName'],
          AcHolderName: json['AcHolderName'],
          AcNo: json['AcNo'],
          IFSC: json['IFSC'],
          MICR: json['MICR'],
          CustomerId: json['CustomerId'],
          BName: json['BName'],
          BCode: json['BCode'],
          BAddress: json['BAddress'],
          UserId: json['UserId'],
          Password: json['Password'],
          TPassword: json['TPassword'],
          MUserId: json['MUserId'],
          MPin: json['MPin'],
          MPassword: json['MPassword'],
          MTPassword: json['MTPassword'],
          HelpLine1: json['HelpLine1'],
          HelpLine2: json['HelpLine2'],
          HelpLine3: json['HelpLine3'],
          HelpLineEmail: json['HelpLineEmail'],
          Fav: json['Fav']
      );

  get length => null;

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'AcTypeSelected':AcTypeSelected,
        'BankName': jsonEncode(BankName),
        'AcHolderName': jsonEncode(AcHolderName),
        'AcNo': jsonEncode(AcNo),
        'IFSC': jsonEncode(IFSC),
        'MICR': jsonEncode(MICR),
        'CustomerId': jsonEncode(CustomerId),
        'BName': jsonEncode(BName),
        'BCode': jsonEncode(BCode),
        'BAddress': jsonEncode(BAddress),
        'UserId': jsonEncode(UserId),
        'Password': jsonEncode(Password),
        'TPassword': jsonEncode(TPassword),
        'MUserId': jsonEncode(MUserId),
        'MPin': jsonEncode(MPin),
        'MPassword': jsonEncode(MPassword),
        'MTPassword': jsonEncode(MTPassword),
        'HelpLine1': jsonEncode(HelpLine1),
        'HelpLine2': jsonEncode(HelpLine2),
        'HelpLine3': jsonEncode(HelpLine3),
        'HelpLineEmail': jsonEncode(HelpLineEmail),
        'Fav':jsonEncode(Fav)
      };
}