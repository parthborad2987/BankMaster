// ignore_for_file: non_constant_identifier_names, must_be_immutable, unrelated_type_equality_checks, use_build_context_synchronously, prefer_typing_uninitialized_variables, avoid_print, avoid_types_as_parameter_names


import 'package:codersqund_bankmaster/LocalDatabase/settingscreen_model.dart';
import 'package:flutter/material.dart';
import '../LocalDatabase/SQl_database.dart';
import '../screenlock/change_pin.dart';

//SettingPage
class SettingScreen extends StatefulWidget {
  static var routeName = '/Settingscreen';
  SqfliteDbModel3? data;
      SettingScreen({Key? key,}) : super(key: key);
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SqfliteDbModel3? data;

@override
  void initState() {
    super.initState();
    if(widget.data != null) {
      widget.data!.Type;
      widget.data!.pin;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Setting',style: TextStyle(color: Colors.white),),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: SqfliteDatabase().fetchdata3(),
          builder: (BuildContext context,AsyncSnapshot<List<SqfliteDbModel3>> snapshot) {
            if(snapshot.hasData) {
                  return buildSetting(snapshot.data!.first);
            } else {
              return const Center(
                child: Text('No Data Found'),
              );
            }
          },
        ),),
    );
  }

Widget buildSetting(SqfliteDbModel3 data) {
  String selectedValue = data.Type;
  return SingleChildScrollView(
      child:Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children:  [
      const SizedBox(height: 20,),
      const Center(child: Text('Manage Security',
        style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 22
        ),),),
      const SizedBox(height: 10,),
             // print(snapshot.data);
          Column(
            children: [
              RadioListTile(
                  value: '0',
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue=data.Type;
                    });
                    _UpdateSetting(
                        "0"
                    );
                  },
                  title: const Text('None',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  // selected: true
              ),
              RadioListTile(
                value: '1',
                groupValue: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue=data.Type;
                  });
                  _UpdateSetting(
                      "1"
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePin()));
                },
                title: const Text('Pin',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              ),
              /*RadioListTile(
                value: '2',
                groupValue: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue=data.Type;
                  });
                  _UpdateSetting(
                      "2"
                  );
                },
                title: const Text('FingerPrint',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              ),*/
            ],),
         ],
      ),
  );
}
_UpdateSetting(
    String Type,
   ) async {
   SqfliteDbModel3 data3 = SqfliteDbModel3(id: 'id', Type:Type, pin: '0');
   await SqfliteDatabase().updateSetting(data3);
}
}


