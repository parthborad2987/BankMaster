// ignore_for_file: must_be_immutable, use_build_context_synchronously, non_constant_identifier_names, deprecated_member_use, unrelated_type_equality_checks, unnecessary_null_comparison, avoid_print, unused_local_variable, avoid_types_as_parameter_names

import 'dart:async';
import 'dart:core';
import 'dart:developer';
import 'package:codersqund_bankmaster/LocalDatabase/settingscreen_model.dart';
import 'package:codersqund_bankmaster/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'LocalDatabase/SQl_database.dart';
import 'provider/tab_provider.dart';
import 'screenlock/setpinpage.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => TabProvider(),
  child: MyApp(),));
}

class MyApp extends StatefulWidget {
  SqfliteDbModel3? data;
    MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  void initState() {
      super.initState();
      var db = SqfliteDatabase().initDb();
      inspect(db);
      if(widget.data != null) {
        widget.data!.id;
        widget.data!.Type;
        widget.data!.pin;
      } else {
        _insertSettingData(
            "0"
        );
      }
     }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       primarySwatch: Colors.indigo
      ),
      home: SafeArea(
        child: FutureBuilder(
          future: SqfliteDatabase().fetchdata3(),
          builder: (BuildContext context,AsyncSnapshot<List<SqfliteDbModel3>> snapshot) {
            if(snapshot.hasData) {
              return SplashPage(snapshot.data!.first,context);
            }
            else {
              return Container();
            }
          },
        ),),
    );
  }
}

  Widget SplashPage(SqfliteDbModel3 data,context) {
        Timer(const Duration(seconds: 1), () {
          String Type = data.Type;
          if (Type == '0') {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const MyHomePage()));
          } else if (Type == '1') {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SetPinPage()));
          } else if (Type == '2') {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SetPinPage()));
          }
        });return Container();
           }

  _insertSettingData(String Type,) async {
    SqfliteDbModel3 data = SqfliteDbModel3(id: 'id', Type: Type, pin: '0');
      await SqfliteDatabase().insertintoSetting(data);
   }
