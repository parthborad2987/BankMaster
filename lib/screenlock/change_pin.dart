// ignore_for_file: prefer_final_fields, non_constant_identifier_names, must_be_immutable, no_leading_underscores_for_local_identifiers, library_private_types_in_public_api, use_build_context_synchronously, unnecessary_brace_in_string_interps, unused_field, avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../LocalDatabase/SQl_database.dart';
import '../LocalDatabase/settingscreen_model.dart';

class ChangePin extends StatefulWidget {
  SqfliteDbModel3? data;
       ChangePin({Key? key}) : super(key: key);

  @override
  _ChangePinState createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {
  String _button = "update";

  @override
  void initState() {
    if(widget.data != null) {
      print(widget.data);
       widget.data!.Type;
      _pinone.text = widget.data!.pin;
      _pinTwo.text = widget.data!.pin;
      _pinThree.text = widget.data!.pin;
      _pinFour.text = widget.data!.pin;
      setState(() {
        _button = "Update";
      });
    }
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  var _value = "-1";
  TextEditingController _pinone = TextEditingController();
  TextEditingController _pinTwo = TextEditingController();
  TextEditingController _pinThree = TextEditingController();
  TextEditingController _pinFour = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Change pin'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: SqfliteDatabase().fetchdata3(),
          builder: (BuildContext context,AsyncSnapshot<List<SqfliteDbModel3>> snapshot) {
             // print(snapshot.hasData);
            return Form(
              key: _formKey,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                             height: 68,
                          width: 64,
                          child: TextFormField(
                            onChanged: (value) {
                              if(value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            controller: _pinone,
                            decoration: const InputDecoration(hintText: "0"),
                            style: Theme.of(context).textTheme.headline6,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 68,
                          width: 64,
                          child: TextFormField(
                            onChanged: (value) {
                              if(value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            controller: _pinTwo,
                            decoration: const InputDecoration(hintText: "0"),
                            style: Theme.of(context).textTheme.headline6,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 68,
                          width: 64,
                          child: TextFormField(
                            onChanged: (value) {
                              if(value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            controller: _pinThree,
                            decoration: const InputDecoration(hintText: "0"),
                            style: Theme.of(context).textTheme.headline6,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 68,
                          width: 64,
                          child: TextFormField(
                            onChanged: (value) {
                              if(value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            controller: _pinFour,
                            decoration: const InputDecoration(hintText: "0"),
                            style: Theme.of(context).textTheme.headline6,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ],
                    ),),
                  ElevatedButton(
                    child:  Text(_button),
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        Navigator.pop(context);
                        List<String> strlist = [_pinone.text,_pinTwo.text,_pinThree.text,_pinFour.text];
                        String str2 = strlist.join();
                        UpdatePinData(
                            "1",str2
                        );
                      }
                    },),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  UpdatePinData(
      String Type,
      String pin
      ) async {
    SqfliteDbModel3 data3 = SqfliteDbModel3(
      id: '1',
      Type: Type,
      pin: pin,
    );
     await SqfliteDatabase().updateSettingData(data3);
  }
}


