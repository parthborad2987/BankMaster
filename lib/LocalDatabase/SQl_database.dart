// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers, avoid_print, unnecessary_brace_in_string_interps, dead_code, non_constant_identifier_names

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'bank_model.dart';
import 'bank_model2.dart';
import 'card_modal2.dart';
import 'card_model.dart';
import 'settingscreen_model.dart';

class SqfliteDatabase {
  final _dbName = "bank_master.db";
  final _tableName = "bank";
  final _cardtableName = "card";
  final _createsettingTable = 'setting';

  Future<Database> initDb() async {
    String path = await getDatabasesPath();
    String createTable = "CREATE TABLE ${_tableName} (id INTEGER PRIMARY KEY AUTOINCREMENT,AcTypeSelected TEXT,BankName TEXT ,AcHolderName TEXT ,AcNo TEXT ,IFSC TEXT ,MICR TEXT ,CustomerId TEXT ,BName TEXT ,BCode TEXT ,BAddress TEXT,UserId TEXT,Password TEXT ,TPassword TEXT ,MUserId TEXT,MPin TEXT ,MPassword TEXT,MTPassword TEXT ,HelpLine1 TEXT,HelpLine2 TEXT,HelpLine3 TEXT,HelpLineEmail TEXT,Fav TEXT)";
    String createcardTable = "CREATE TABLE ${_cardtableName} (id INTEGER PRIMARY KEY AUTOINCREMENT,cardtypeSelected TEXT,card1Selected Text,BName TEXT,Cno TEXT,Exdate TEXT,Cvv TEXT,Pin TEXT,CardHolderName TEXT,Nickname TEXT,NetId TEXT,NetPass TEXT,NetTPass TEXT,MobId TEXT,MobPin TEXT,MobPass TEXT,MobTPass TEXT,HelpLine1 TEXT,HelpLine2 TEXT,HelpLine3 TEXT,HelpLineEmail TEXT,Fav1 TEXT)";
    String createsettingTable = "CREATE TABLE ${_createsettingTable} (id INTEGER PRIMARY KEY AUTOINCREMENT,Type TEXT,pin TEXT)";

    return openDatabase(
      join(path, _dbName),
      onCreate: (database, int? version) async {
        await database.execute(createTable);
        await database.execute(createcardTable);
        await database.execute(createsettingTable);
      },
      version: 1,
    );
  }

  Future<int> insertRecord(SqfliteDbModel data) async {
    final Database db = await initDb();
    var result = await db.rawInsert(
        "INSERT INTO ${_tableName} (`AcTypeSelected`,`BankName`,`AcHolderName`,`AcNo`,`IFSC`,`MICR`,`CustomerId`,`BName`,`BCode`,`BAddress`,`UserId`,`Password`,`TPassword`,`MUserId`,`MPin`,`MPassword`,`MTPassword`,`HelpLine1`,`HelpLine2`,`HelpLine3`,`HelpLineEmail`,`Fav`)  VALUES ('${data
            .AcTypeSelected}','${data.BankName}','${data.AcHolderName}','${data
            .AcNo}','${data.IFSC}','${data.MICR}','${data.CustomerId}','${data
            .BName}','${data.BCode}','${data.BAddress}','${data.UserId}','${data
            .Password}','${data.TPassword}','${data.MUserId}','${data
            .MPin}','${data.MPassword}','${data.MTPassword}','${data
            .HelpLine1}','${data.HelpLine2}','${data.HelpLine3}','${data
            .HelpLineEmail}','${data.Fav}')"
    );
    return result;
  }

  Future<int> insertintocard(SqfliteDbModel1 data1) async {
    final Database db = await initDb();
    var result = await db.rawInsert(
        "INSERT INTO ${_cardtableName} (`cardtypeSelected`,`card1Selected`,`BName`,`Cno`,`Exdate`,`Cvv`,`Pin`,`CardHolderName`,`Nickname`,`NetId`,`NetPass`,`NetTPass`,`MobId`,`MobPin`,`MobPass`,`MobTPass`,`HelpLine1`,`HelpLine2`,`HelpLine3`,`HelpLineEmail`,`Fav1`)  VALUES ('${data1
            .cardtypeSelected}','${data1.card1Selected}','${data1.BName}','${data1
            .Cno}','${data1.Exdate}','${data1.Cvv}','${data1.Pin}','${data1
            .CardHolderName}','${data1.Nickname}','${data1.NetId}','${data1
            .NetPass}','${data1.NetTPass}','${data1.MobId}','${data1
            .MobPin}','${data1.MobPass}','${data1.MobTPass}','${data1
            .HelpLine1}','${data1.HelpLine2}','${data1.HelpLine3}','${data1
            .HelpLineEmail}','${data1.Fav1}')"
    );
    return result;
  }

  Future<int> insertintoSetting(SqfliteDbModel3 data3) async {
    final Database db = await initDb();
    var result = await db.rawInsert(
        "INSERT INTO ${_createsettingTable} (`Type`,`pin`)  VALUES ('${data3.Type}','${data3.pin}')"
    );
    return result;
  }

  Future<List<SqfliteDbModel>> fetchData() async {
    final Database db = await initDb();
    final List<Map<String, dynamic>> queryResult = await db.query(_tableName);
    return queryResult.map((e) => SqfliteDbModel.fromJson(e)).toList();
  }

  Future<List<SqfliteDbModel1>> fetchdata1() async {
    final Database db = await initDb();
    final List<Map<String, dynamic>> queryResult = await db.query(
        _cardtableName);
    return queryResult.map((e) => SqfliteDbModel1.fromJson(e)).toList();
  }

  Future<List<SqfliteDbModel3>> fetchdata3() async {
    final Database db = await initDb();
    final List<Map<String, dynamic>> queryResult = await db.query(_createsettingTable);
    return queryResult.map((e) => SqfliteDbModel3.fromJson(e)).toList();
  }

  Future<int> updateData(SqfliteDbModel data) async {
    final Database db = await initDb();
    var result = await db.rawUpdate(
        "UPDATE ${_tableName} SET AcTypeSelected='${data
            .AcTypeSelected}',BankName='${data.BankName}',AcHolderName='${data
            .AcHolderName}',AcNo='${data.AcNo}',IFSC='${data.IFSC}',MICR='${data
            .MICR}',CustomerId='${data.CustomerId}',BName='${data
            .BName}',BCode='${data.BCode}',BAddress='${data
            .BAddress}',UserId='${data.UserId}',Password='${data
            .Password}',TPassword='${data.TPassword}',MUserId='${data
            .MUserId}',MPin='${data.MPin}',MPassword='${data
            .MPassword}',MTPassword='${data.MTPassword}',HelpLine1='${data
            .HelpLine1}',HelpLine2='${data.HelpLine2}',HelpLine3='${data
            .HelpLine3}',HelpLineEmail='${data.HelpLineEmail}',Fav='${data.Fav}' WHERE id=${data
            .id}");
    return result;
  }

  Future<int> updateDataBank(BankDbModel data) async {
    final Database db = await initDb();
    var result = await db.rawUpdate(
        "UPDATE ${_tableName} SET Fav='${data.Fav}' WHERE id=${data.id}");
    return result;
  }

  Future<int> updateCardData(SqfliteDbModel1 data1) async {
    final Database db = await initDb();
    var result = await db.rawUpdate(
        "UPDATE ${_cardtableName} SET cardtypeSelected='${data1.cardtypeSelected}',card1Selected='${data1.card1Selected}',BName='${data1.BName}',Cno='${data1.Cno}',Exdate='${data1.Exdate}',Cvv='${data1.Cvv}',Pin='${data1.Pin}',BName='${data1.BName}',CardHolderName='${data1.CardHolderName}',Nickname='${data1.Nickname}',NetId='${data1.NetId}',NetPass='${data1.NetPass}',NetTPass='${data1.NetTPass}',MobId='${data1.MobId}',MobPin='${data1.MobPin}',MobPass='${data1.MobPass}',MobTPass='${data1.MobTPass}',HelpLine1='${data1.HelpLine1}',HelpLine2='${data1.HelpLine2}',HelpLine3='${data1.HelpLine3}',HelpLineEmail='${data1.HelpLineEmail}' WHERE id=${data1.id}");
    return result;
  }

  Future<int> updateDataCard(CardDbModel data1) async {
    final Database db = await initDb();
    var result = await db.rawUpdate(
        "UPDATE ${_cardtableName} SET Fav1='${data1.Fav1}' WHERE id=${data1.id}");
    return result;
  }

  Future<int> updateSettingData(SqfliteDbModel3 data3) async {
    final Database db = await initDb();
    var result = await db.rawUpdate(
        "UPDATE ${_createsettingTable} SET Type='${data3.Type}',pin='${data3.pin}' WHERE id=${data3.id}");
    return result;
  }

  Future<int> updateSetting(SqfliteDbModel3 data3) async {
    final Database db = await initDb();
    var result = await db.rawUpdate(
        "UPDATE ${_createsettingTable} SET Type='${data3.
        Type}' WHERE id=${data3.id}");
    return result;
  }

  Future<int> deleteRecord(String deleteId) async {
    final Database db = await initDb();
    var result = await db.delete(_tableName, where: 'id=${deleteId}');
    return result;
  }

  Future<int> deleteCardRecord(String deleteId) async {
    final Database db = await initDb();
    var result = await db.delete(_cardtableName, where: 'id=${deleteId}');
    return result;
  }
}


