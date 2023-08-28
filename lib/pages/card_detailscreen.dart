// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, unused_field, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, unrelated_type_equality_checks

import 'package:codersqund_bankmaster/pages/update_card_detail.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../LocalDatabase/SQl_database.dart';
import '../LocalDatabase/card_model.dart';
import '../Screens/home_screen.dart';
import 'delete_card_detail.dart';

// ignore: must_be_immutable
class CardDetails extends StatefulWidget {
  SqfliteDbModel1? data1;
  CardDetails (this.data1, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CardDetailsState createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {

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
        title: const Text('CARD DETAILS'),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
          },
          icon: const Icon(
            Icons.arrow_back
          ),
        ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 60,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18.0)), //here
                  color: Theme.of(context).primaryColor,
                ),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                  children:[
                    const Text('Card Details',
                      style: TextStyle(color: Colors.white,
                          fontSize: 25,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                    PopupMenuButton<int>(
                      onSelected: (item) => onSelected1(context,item,data1),
                      itemBuilder: (context) => [
                        const PopupMenuItem<int>(
                          value: 0,
                          child: Row(
                            children: [
                              Icon(Icons.edit,),
                              Padding(padding: EdgeInsets.only(left: 12.0),
                                child: Text('update'),
                              ),
                            ],
                          ),
                        ),
                        const PopupMenuItem<int>(
                          value: 1,
                          child: Row(
                            children: [
                              Icon(Icons.share,color: Colors.black,),
                              Padding(padding: EdgeInsets.only(left: 12.0),
                                child: Text('Share'),
                              ),
                            ],
                          ),
                        ),
                        const PopupMenuItem<int>(
                          value: 2,
                          child: Row(
                            children: [
                              Icon(Icons.delete_forever),
                              Padding(padding: EdgeInsets.only(left: 12.0),
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        ),
                      ],
                      child: const Icon(Icons.more_vert_sharp, color: Colors.white,size: 35,),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 9,),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12,),
                    Text('Account Type :-   ${cardtypeSelected.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 35),
                    Text('Company Type :-   ${card1Selected.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 35),
                    Text('Bank Name :-   ${_BName.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 35),
                    Text('Card Numbers :-   ${_Cno.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 35),
                    Text('Expiry Date :-   ${_Exdate.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 35),
                    Text('Cvv :-   ${_Cvv.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 35),
                    Text('Pin :-   ${_Pin.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 35),
                    Text('Card Holder Name :-   ${_CardHolderName.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 35),
                    Text('Nick Name :-   ${_Nickname.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 35),
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
      body: SingleChildScrollView(child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 170),child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black,width: 2,),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40,),
                    Text('User Id :-   ${_NetId.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 40),
                    Text('Password :-   ${_NetPass.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 40),
                    Text('Transaction Password :-   ${_NetTPass.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  ]),),
            const SizedBox(height: 40,)
          ],
        ),
      ),
      ),
      ),
    );
  }

  //third card page
  Widget _buildThirdCardPage(SqfliteDbModel1 data1) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 140),child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black,width: 2,),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text('User Id :-   ${_MobId.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 40),
                  Text('Pin :-   ${_MobPin.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 40),
                  Text('Password :-   ${_MobPass.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 40),
                  Text('Transaction Password :-   ${_MobTPass.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            const SizedBox(height: 40,)
          ],
        ),
      ),
      ),
      ),
    );
  }

  //fourth card page
  Widget _buildFourthCardPage(SqfliteDbModel1 data1) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 120),child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black,width: 2,),
        ),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Text('HelpLine1 :-   ${_HelpLine1.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40),
                      Text('HelpLine2 :-   ${_HelpLine2.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40),
                      Text('HelpLine3 :-   ${_HelpLine3.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40),
                      Text('HelpLine Email :-   ${_HelpLineEmail.text}',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40),
                    ]
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
  void animateToSlide(int index) => _controller.animateToPage(index, duration: const Duration(milliseconds: 1), curve: Curves.bounceIn);

  onSelected1(context, int item,SqfliteDbModel1 data1) {
    switch(item) {
      case 0: Navigator.push(context, MaterialPageRoute(
          builder: (context) =>  UpdateCardDetails(data1)));
      break;
      case 1: Share.share('CardType: ${data1.cardtypeSelected}\n\nBank Name: ${data1.BName}\n\nCard Number: ${data1.Cno}\n\nCardHolder Name: ${data1.CardHolderName}\n\nExpiry Date: ${data1.Exdate}');
      break;
      case 2: var response = SqfliteDatabase().deleteCardRecord("${data1.id}");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MyHomePage()),(route) => false);
      if(response != 0) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Delete Successfully")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("something Wrong While Deleting.")));
      }
      break;
    }
  }
}



















