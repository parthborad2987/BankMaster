// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, unused_field, unnecessary_brace_in_string_interps

import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../LocalDatabase/SQl_database.dart';
import '../LocalDatabase/card_model.dart';
import '../Validator/card_data_validator.dart';
import '../Validator/card_number_validator.dart';

// ignore: must_be_immutable
class DeleteCardDetails extends StatefulWidget {
  SqfliteDbModel1? data1;
  DeleteCardDetails (this.data1, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DeleteCardDetailsState createState() => _DeleteCardDetailsState();
}

class _DeleteCardDetailsState extends State<DeleteCardDetails> {

  @override
  void initState() {
    super.initState();
    if(widget.data1 != null) {
      cardtypeSelected.text = widget.data1!.cardtypeSelected;
      card1Selected.text = widget.data1!.card1Selected;
      _BName.text = widget.data1!.BName;
      _Cno.text = widget.data1!.Cno;
      _Exdate.text = widget.data1!.Exdate;
      _Cvv.text = widget.data1!.Cvv;
      _Pin.text = widget.data1!.Pin;
      _CardHolderName.text = widget.data1!.CardHolderName;
      _Nickname.text = widget.data1!.Nickname;
      _NetId.text = widget.data1!.NetId;
      _NetPass.text = widget.data1!.NetPass;
      _NetTPass.text = widget.data1!.NetTPass;
      _MobId.text = widget.data1!.MobId;
      _MobPin.text = widget.data1!.MobPin;
      _MobPass.text = widget.data1!.MobPass;
      _MobTPass.text = widget.data1!.MobTPass;
      _HelpLine1.text = widget.data1!.HelpLine1;
      _HelpLine2.text = widget.data1!.HelpLine2;
      _HelpLine3.text = widget.data1!.HelpLine3;
      _HelpLineEmail.text = widget.data1!.HelpLineEmail;
    }
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
        title: const Text('UPDATE CARD DETAILS'),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: SqfliteDatabase().fetchdata1(),
            builder: (BuildContext context,AsyncSnapshot<List<SqfliteDbModel1>> snapshot) {
              if(snapshot.hasData) {
                return PageView(
                  controller: _controller,
                  children:    [
                    _buildFirstCardPage(snapshot.data!.first),
                    _buildSecondCardPage(snapshot.data!.first),
                    _buildThirdCardPage(snapshot.data!.first),
                    _buildFourthCardPage(snapshot.data!.first),
                  ],
                );
              }else {
                return Container();
              }
            }
        ),
      ),
    );
  }

  //first card page
  Widget _buildFirstCardPage(SqfliteDbModel1 data1) {
    return Scaffold(backgroundColor: Colors.white,
      body:SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),child: Container(
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
                    const Text('Select Card Type',style: TextStyle(fontWeight: FontWeight.bold),),
                    Padding(padding: const EdgeInsets.all(1.0),
                      child: DropDownField(
                        controller: cardtypeSelected,
                        enabled: true,
                        labelText: "Select Card",
                        items: cardtype,
                      ),),
                    const SizedBox(height: 9,),
                    Padding(padding:  const EdgeInsets.all(1.0),
                      child: DropDownField(
                        controller: card1Selected,
                        enabled: true,
                        labelText: "Select Card",
                        items: card1,
                      ),),
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
                      decoration: InputDecoration(labelText: 'Card Holder name',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
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
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      ),
      ),
    );
  }

  //second card page
  Widget _buildSecondCardPage(SqfliteDbModel1 data1) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 170),child: Container(
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
                      maxLength: 8,
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      controller: _NetTPass,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),
                      decoration: InputDecoration(
                        labelText: 'Transction PASSWORD',border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                        counterText: '',
                      ),
                      maxLength: 8,
                    ),
                  ]),),
          ],
        ),
      ),
      ),
    );
  }

  //third card page
  Widget _buildThirdCardPage(SqfliteDbModel1 data1) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 140),child: Container(
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
                    maxLength: 6,
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
                    maxLength: 8,
                  ),
                  const SizedBox(height: 30,),
                  TextField(
                    controller: _MobTPass,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),
                    decoration: InputDecoration(
                      labelText: 'Transction PASSWORD',border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                      counterText: '',
                    ),
                    maxLength: 8,
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
  Widget _buildFourthCardPage(SqfliteDbModel1 data1) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 120),child: Container(
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
                        maxLength: 10,
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
                        maxLength: 10,
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
                        maxLength: 10,
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

}



















