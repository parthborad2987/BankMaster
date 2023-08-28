// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, unused_field, unnecessary_brace_in_string_interps

import 'dart:developer';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../LocalDatabase/SQl_database.dart';
import '../LocalDatabase/card_model.dart';
import '../Screens/home_screen.dart';
import '../Validator/card_data_validator.dart';
import '../Validator/card_number_validator.dart';

// ignore: must_be_immutable
class AddCardDetails extends StatefulWidget {
  const AddCardDetails ({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddCardDetailsState createState() => _AddCardDetailsState();
}

class _AddCardDetailsState extends State<AddCardDetails> {
  Object? data1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var db = SqfliteDatabase().initDb();
    inspect(db);
  }
  final _formKey = GlobalKey<FormState>();
  var _value = "-1";
  TextEditingController _BName = TextEditingController();
  TextEditingController _Cno = TextEditingController();
  TextEditingController _Exdate = TextEditingController();
  TextEditingController _Cvv = TextEditingController();
  TextEditingController _Pin = TextEditingController();
  TextEditingController _CardHolderName = TextEditingController();
  TextEditingController _Nickname = TextEditingController();
  TextEditingController _NetId = TextEditingController();
  TextEditingController _NetPass = TextEditingController();
  TextEditingController _NetTPass = TextEditingController();
  TextEditingController _MobId = TextEditingController();
  TextEditingController _MobPin = TextEditingController();
  TextEditingController _MobPass = TextEditingController();
  TextEditingController _MobTPass = TextEditingController();
  TextEditingController _HelpLine1 = TextEditingController();
  TextEditingController _HelpLine2 = TextEditingController();
  TextEditingController _HelpLine3 = TextEditingController();
  TextEditingController _HelpLineEmail = TextEditingController();
  final _controller=PageController();
  final cardtypeSelected = TextEditingController();
  List<String> cardtype = [
    "Credit Card",
    "Debit Card",
  ];
  final card1Selected = TextEditingController();
  List<String> card1 = [
    "Visa",
    "Master Card",
    "Discover",
    "American Express"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('ADD CARD DETAILS'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            SizedBox(height: 680,
              child: PageView(
                controller: _controller,
                children:    [
                  _buildFirstCardPage(context),
                  _buildSecondCardPage(context),
                  _buildThirdCardPage(context),
                  _buildFourthCardPage(context),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(20),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(child: const Icon(Icons.arrow_back,),onPressed: () {
                  _controller.previousPage(
                      duration: const Duration(milliseconds: 3),
                      curve: Curves.easeInExpo);
                },),
                SmoothPageIndicator(
                  onDotClicked: animateToSlide,
                  controller: _controller,
                  count: 4,
                  effect: JumpingDotEffect(jumpScale: 3,
                    activeDotColor: Colors.deepPurple,
                    dotColor: Colors.deepPurple.shade100,
                  ),
                ),
                ElevatedButton(
                    child: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      if(_controller.page == 0){
                        if (_formKey.currentState!.validate()) {
                          String BankName = _BName.text.trim();
                          String AccountNumber = _Cno.text.trim();
                          String AcHolderName = _CardHolderName.text.trim();
                          if(BankName.isEmpty && AccountNumber.isEmpty && AcHolderName.isEmpty) {
                          }
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 3),
                              curve: Curves.easeInExpo);
                        }
                      }else{
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 3),
                            curve: Curves.easeInExpo);
                      }
                    }
                ),
              ],
            ),
            ),
          ],
        ),
      ),
    );
  }

  //first card page
  Widget _buildFirstCardPage(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: SingleChildScrollView(
    child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black,width: 2,),
        ),
        child:Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(height: 60,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18.0)), //here
                  color: Theme.of(context).primaryColor,
                ),
                child:const Center(
                  child: Text('Card Details',
                      style: TextStyle(color: Colors.white,
                          fontSize: 25,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
              ),
              const SizedBox(height: 9,),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Padding(padding: const EdgeInsets.all(1.0),
                      child: DropDownField(
                        controller: cardtypeSelected,
                        enabled: true,
                        labelText: "Select Account Type",
                        items: cardtype,
                      ),),
                      const SizedBox(height: 9,),
                        DropDownField(
                            controller: card1Selected,
                            enabled: true,
                            labelText: "Select Company  Type",
                            items: card1,
                          ),
                    const SizedBox(height: 9,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _BName,
                      style:   const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                      decoration: InputDecoration(labelText: 'Bank Name',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'Bank name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 9,),
                    TextFormField(
                      controller: _Cno,
                      keyboardType: TextInputType.number,
                      style:  const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                      decoration: InputDecoration(
                        prefix: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        labelText: 'Card Numbers',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),),
                        counterText: '',
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'Please Enter a Valid Card Number';
                        }
                        return null;
                      },
                      maxLength: 19,
                      onChanged: (value) {
                        debugPrint('Cardnumber: $value');
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(19),
                        CardNumberFormattor(),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: _Exdate,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                            decoration: InputDecoration(
                              labelText: 'Expiry Date',border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),),
                              counterText: '',
                            ),
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return 'Please Enter a Expiry Date';
                              }
                              return null;
                            },
                            maxLength: 5,
                            textInputAction: TextInputAction.done,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(5),
                              CardDateFormatter(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: _Cvv,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                            decoration: InputDecoration(
                              labelText: 'Cvv',border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),),
                              counterText: '',
                            ),
                            maxLength: 6,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    TextFormField(
                      controller: _Pin,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),
                      decoration: InputDecoration(
                        labelText: 'Pin',border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),),
                        counterText: '',
                      ),
                      maxLength: 6,
                    ),
                    const SizedBox(height: 9),
                    TextFormField(
                      controller: _CardHolderName,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                      decoration: InputDecoration(labelText: 'Card Holder name',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'Please Enter a Card Holder name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 9),
                    TextFormField(
                      controller: _Nickname,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                      decoration: InputDecoration(
                        labelText: 'Nick Name',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,)
            ],
          ),
        ),
      ),
      ),
      ),
    );
  }

  //second card page
  Widget _buildSecondCardPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 145),
        child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black,width: 2,),
        ),
        child: Column(
          children: [
            Container(height: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18.0)), //here
                color: Theme.of(context).primaryColor,
              ),
              child:const Center(
                child: Text('Net Banking Details',
                    style: TextStyle(color: Colors.white,
                        fontSize: 25,fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  children: [
                    const SizedBox(height: 50,),
                    TextField(
                      controller: _NetId,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                      decoration: InputDecoration(
                        labelText: 'User Id',border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      controller: _NetPass,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                      decoration: InputDecoration(
                        labelText: 'Password',border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                        counterText: '',
                      ),
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      controller: _NetTPass,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),
                      decoration: InputDecoration(
                        labelText: 'Transction Password',border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                        counterText: '',
                      ),
                    ),
                  ]),),
          ],
        ),
      ),
      ),
    );
  }

  //third card page
  Widget _buildThirdCardPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 100),child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black,width: 2,),
        ),
        child: Column(
          children: [
            Container(height: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18.0)), //here
                color: Theme.of(context).primaryColor,
              ),
              child:const Center(
                child: Text('Mobile App Details',
                    style: TextStyle(color: Colors.white,
                        fontSize: 25,fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(height: 50,),
                  TextField(
                    controller: _MobId,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                    decoration: InputDecoration(
                      labelText: 'User Id',border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                      counterText: '',
                    ),
                  ),
                  const SizedBox(height: 30,),
                  TextField(
                    controller: _MobPin,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                    decoration: InputDecoration(
                      labelText: 'Pin',border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                      counterText: '',
                    ),
                  ),
                  const SizedBox(height: 30,),
                  TextField(
                    controller: _MobPass,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                    decoration: InputDecoration(
                      labelText: 'Password',border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                      counterText: '',
                    ),
                  ),
                  const SizedBox(height: 30,),
                  TextField(
                    controller: _MobTPass,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),
                    decoration: InputDecoration(
                      labelText: 'Transction Password',border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                      counterText: '',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  //fourth card page
  Widget _buildFourthCardPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 65),child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black,width: 2,),
        ),
        child: Form(
          child: Column(
            children: [
              Container(height: 60,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18.0)), //here
                  color: Theme.of(context).primaryColor,
                ),
                child:const Center(
                  child: Text('Help Line Number',
                      style: TextStyle(color: Colors.white,
                          fontSize: 25,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                    children: [
                      const SizedBox(height: 50,),
                      TextField(
                        controller: _HelpLine1,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        decoration: InputDecoration(
                          labelText: 'HelpLine1',border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                          counterText: '',
                        ),
                      ),
                      const SizedBox(height: 30,),
                      TextField(
                        controller: _HelpLine2,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        decoration: InputDecoration(
                          labelText: 'HelpLine2',border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                          counterText: '',
                        ),
                      ),
                      const SizedBox(height: 30,),
                      TextField(
                        controller: _HelpLine3,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),
                        decoration: InputDecoration(
                          labelText: 'HelpLine3',border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                          counterText: '',
                        ),
                      ),
                      const SizedBox(height: 30,),
                      TextField(
                        controller: _HelpLineEmail,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),
                        decoration: InputDecoration(
                          labelText: 'HelpLine Email',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      const SizedBox(height: 30,),
                      ElevatedButton(
                        onPressed:() {
                          _insertData(
                              _value,
                              cardtypeSelected.text,
                              card1Selected.text,
                              _BName.text,
                              _Cno.text,
                              _Exdate.text,
                              _Cvv.text,
                              _Pin.text,
                              _CardHolderName.text,
                              _Nickname.text,
                              _NetId.text,
                              _NetPass.text,
                              _NetTPass.text,
                              _MobId.text,
                              _MobPin.text,
                              _MobPass.text,
                              _MobTPass.text,
                              _HelpLine1.text,
                              _HelpLine2.text,
                              _HelpLine3.text,
                              _HelpLineEmail.text);
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MyHomePage()),(route) => false);
                        },
                        child:  const Text('Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      // ),
                    ]
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
  void animateToSlide(int index) => _controller.animateToPage(index, duration: const Duration(milliseconds: 1), curve: Curves.bounceIn);
  _insertData(
      String id,
      String cardtypeSelected,
      String card1Selected,
      String BName,
      String Cno,
      String Exdate,
      String Cvv,
      String Pin,
      String AcHolderName,
      String Nickname,
      String NetId,
      String NetPass,
      String NetTPass,
      String MobId,
      String MobPin,
      String MobPass,
      String MobTPass,
      String HelpLine1,
      String HelpLine2,
      String HelpLine3,
      String HelpLineEmail) async {
    SqfliteDbModel1 data1 = SqfliteDbModel1(
      id: id,
      cardtypeSelected: cardtypeSelected,
      card1Selected:card1Selected,
      BName: BName,
      Cno: Cno,
      Exdate: Exdate,
      Cvv: Cvv,
      Pin: Pin,
      CardHolderName: AcHolderName,
      Nickname:Nickname,
      NetId:NetId,
      NetPass:NetPass,
      NetTPass:NetTPass,
      MobId:MobId,
      MobPin:MobPin,
      MobPass:MobPass,
      MobTPass:MobTPass,
      HelpLine1:HelpLine1,
      HelpLine2:HelpLine2,
      HelpLine3:HelpLine3,
      HelpLineEmail:HelpLineEmail, Fav1: '', );
    await SqfliteDatabase().insertintocard(data1);
    _clearAll();
  }

  _clearAll() {
    cardtypeSelected.clear();
    card1Selected.clear();
    _BName.clear();
    _Cno.clear();
    _Exdate.clear();
    _Cvv.clear();
    _Pin.clear();
    _CardHolderName.clear();
    _Nickname.clear();
    _NetId.clear();
    _NetPass.clear();
    _NetTPass.clear();
    _MobId.clear();
    _MobPin.clear();
    _MobPass.clear();
    _MobTPass.clear();
    _HelpLine1.clear();
    _HelpLine2.clear();
    _HelpLine3.clear();
    _HelpLineEmail.clear();
  }

}



















