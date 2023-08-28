// ignore_for_file: library_private_types_in_public_api, prefer_final_fields, must_be_immutable, deprecated_member_use, non_constant_identifier_names, avoid_print, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../LocalDatabase/SQl_database.dart';
import '../LocalDatabase/settingscreen_model.dart';
import '../Screens/home_screen.dart';
import '../halpers/biometric_halper.dart';

class SetPinPage extends StatefulWidget {
  const SetPinPage ({Key? key}) : super(key: key);

  @override
  _SetPinPageState createState() => _SetPinPageState();
}

class _SetPinPageState extends State<SetPinPage> {
  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width;
    MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context,constraints) {
            if(constraints.maxWidth < 768) {
             return Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.indigo
                    ),
                    child: OtpScreen(),
                  ),
                  Positioned(
                    top: 130,left: 90,height: 100,width: 230,
                    child: Image.asset(
                      "assets/codersquad.png",scale: 1,height: double.maxFinite,
                    ),
                  ),
                ],
              );
            } else {
          return Stack(
            children: [
            Container(
            decoration: const BoxDecoration(
            color: Colors.indigo
            ),
            child: OtpScreen(),
            ),],
            );}
          },
        ),
      ),
    );
  }
}

class OtpScreen extends StatefulWidget {
  SqfliteDbModel3? data;
   OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool showBiometrics = false;
  bool isAuthenticated = false;

  String? str2;

  SqfliteDbModel3? data;

  @override
  void initState() {
    super.initState();
    if(widget.data != null) {
     str2 = widget.data!.pin;
    }
    isBiometricAvailable();
  }

  isBiometricAvailable() async {
    showBiometrics = await BiometricHelper().hasEnrolledBiometrics();
    setState(() {

    });
  }

  final _formKey = GlobalKey<FormState>();
  List<String> currentPin = ["","","",""];
  TextEditingController _pinOne = TextEditingController();
  TextEditingController _pinTwo = TextEditingController();
  TextEditingController _pinThree = TextEditingController();
  TextEditingController _pinFour = TextEditingController();

  var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Colors.transparent)
  );

  int pinIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 200),
        child: SafeArea(
      child:FutureBuilder(
        future: SqfliteDatabase().fetchdata3(),
        builder:(BuildContext context,AsyncSnapshot<List<SqfliteDbModel3>> snapshot) {
           // print(snapshot.data?[0].pin);
          if(snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                          const SizedBox(height: 100),
                          const Text("Bank Master",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 35),),
                          const SizedBox(height: 80),
                          // buildSecurityText(),
                          buildPinRow(snapshot.data!.first),
                          const SizedBox(height: 30),
                          buildNumberPad(snapshot.data!.first),
                        ],
              ),
            );
          } return Container();
        },
      ),
    ));
  }

  buildNumberPad(SqfliteDbModel3 data) {
    return  Column(
            children: <Widget>[
              SizedBox(
                width: 50,
                child: MaterialButton(color: Colors.transparent,
                  height: 60.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      final str2 = data.pin;
                      List<String> strlist = [_pinOne.text,_pinTwo.text,_pinThree.text,_pinFour.text];
                      String str1 = strlist.join();
                      if(str1 == str2) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MyHomePage(),
                          ),);
                      } else {
                        ScaffoldMessenger.of(context).
                        showSnackBar(const SnackBar(content: Text("Please Enter valid pin.")));
                      }
                    }
                  },
                  child: const Icon(Icons.arrow_forward,color: Colors.white,),
                ),
              ),
              const SizedBox(height:  30,),
              const Text("Or",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 21),),
              const SizedBox(height:  30,),
              if (showBiometrics)
                ElevatedButton(style: ElevatedButton.styleFrom(
                    primary: Colors.transparent),
                    onPressed: () async {
                      isAuthenticated = await BiometricHelper().authenticate();
                      setState(() {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const MyHomePage()));
                      });
                    }, child: const Icon(Icons.fingerprint_sharp,size: 80,color: Colors.white,)),
              const SizedBox(height: 50),
            ],
     );
          }

  insertPinData(
      String Type,
      String pin
      ) async {
    SqfliteDbModel3 data3 = SqfliteDbModel3(
      id: '1', Type: Type, pin: pin
    );
     await SqfliteDatabase().updateSettingData(data3);
  }

  buildPinRow(SqfliteDbModel3 data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          height: 68,
          width: 64,
          child: TextFormField(
            onChanged: (value) {
              if(value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            controller: _pinOne,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "0"),
            style: Theme.of(context).textTheme.headline6,
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
            keyboardType: TextInputType.number,
            style: Theme.of(context).textTheme.headline6,
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
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "0"),
            style: Theme.of(context).textTheme.headline6,
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
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: "0"),
            style: Theme.of(context).textTheme.headline6,
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
    );
  }

  buildSecurityText() {
    return const Text("Enter PIN",
      style: TextStyle(
        color: Colors.white70,
        fontSize: 21.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
