// ignore_for_file: non_constant_identifier_names, prefer_final_fields, use_build_context_synchronously, unnecessary_brace_in_string_interps

import 'dart:developer';

import 'package:codersqund_bankmaster/Screens/home_screen.dart';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../LocalDatabase/SQl_database.dart';
import '../LocalDatabase/bank_model.dart';

// ignore: must_be_immutable
class AddBankDetails extends StatefulWidget {
  static var routeName = '/AddNewBankPage';

  const AddBankDetails ({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddBankDetailsState createState() => _AddBankDetailsState();
}

class _AddBankDetailsState extends State<AddBankDetails> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var db = SqfliteDatabase().initDb();
    inspect(db);
  }

  final _formKey = GlobalKey<FormState>();
  var _value = "-1";
  TextEditingController _BankName = TextEditingController();
  TextEditingController _AcNo = TextEditingController();
  TextEditingController _AcHolderName = TextEditingController();
  TextEditingController _IFSC = TextEditingController();
  TextEditingController _MICR = TextEditingController();
  TextEditingController _CustomerId = TextEditingController();
  TextEditingController _BName = TextEditingController();
  TextEditingController _BCode = TextEditingController();
  TextEditingController _BAddress = TextEditingController();
  TextEditingController _UserId = TextEditingController();
  TextEditingController _Password = TextEditingController();
  TextEditingController _TPassword = TextEditingController();
  TextEditingController _MUserId = TextEditingController();
  TextEditingController _MPin = TextEditingController();
  TextEditingController _MPassword = TextEditingController();
  TextEditingController _MTPassword = TextEditingController();
  TextEditingController _HelpLine1 = TextEditingController();
  TextEditingController _HelpLine2 = TextEditingController();
  TextEditingController _HelpLine3 = TextEditingController();
  TextEditingController _HelpLineEmail = TextEditingController();
  final _controller=PageController();
  final AcTypeSelected = TextEditingController();
  List<String> AcType = [
    'Saving Account',
    'Regular Account',
    'Current Account',
    'Recurring Deposite Account',
    'Fixed Deposite Account',
    'Demat Account',
    'NRI Account'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("ADD BANK DETAILS"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            SizedBox(height: 670,
              child: PageView(
                controller: _controller,
                children: [
                  FirstBankPage(),
                  SecondBankPage(),
                  _buildThirdBankPage(context),
                  _buildFourthBankPage(context),
                  _buildFifthBankPage(context),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          // heroTag: 'heroTag2',
                          child: const Icon(Icons.arrow_back,),onPressed: () {
                          _controller.previousPage(
                              duration: const Duration(milliseconds: 1),
                              curve: Curves.easeInExpo);
                        },),
                        SmoothPageIndicator(
                          onDotClicked: animateToSlide,
                          controller: _controller,
                          count: 5,
                          effect: JumpingDotEffect(jumpScale: 3,
                            activeDotColor: Colors.deepPurple,
                            dotColor: Colors.deepPurple.shade100,
                          ),
                        ),
                        ElevatedButton(
                          child: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            if(_controller.page == 0){
                              if (_formKey.currentState!.validate())  {
                                String BankName = _BankName.text.trim();
                                String AccountNumber = _AcNo.text.trim();
                                String AcHolderName = _AcHolderName.text.trim();
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
                          },),
                      ],
                    ),
            ),

          ],
        ),
      ),
    );
  }

  //First page
  Widget FirstBankPage() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 25),
        child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 2,),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(height: 60,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18.0)), //here
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
                child: const Center(
                  child: Text('Bank Details',
                      style: TextStyle(color: Colors.white,
                          fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
              ),
              const SizedBox(height: 20,),
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Padding(padding: const EdgeInsets.all(1.0),
                      child:  DropDownField(
                        controller: AcTypeSelected,
                        enabled: true,
                        hintText: "Select Account Type",
                        items: AcType,
                      ),),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: _BankName,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 15),
                      decoration: InputDecoration(labelText: 'Enter Bank Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'Bank name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      controller: _AcHolderName,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 15),
                      decoration: InputDecoration(labelText: 'Enter A/c Holder Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'Enter A/c Holder Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      controller: _AcNo,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 15,),
                      decoration: InputDecoration(labelText: 'Enter Account Number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        counterText: '',
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'Please Enter a Account number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        debugPrint('Cardnumber: $value');
                      },
                    ),
                    const SizedBox(height: 15,),
                    TextFormField(
                      controller: _IFSC,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 15,),
                      decoration: InputDecoration(labelText: 'Enter IFSC Code',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _MICR,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 15),
                      decoration: InputDecoration(labelText: 'Enter MICR Code',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _CustomerId,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 15),
                      decoration: InputDecoration(labelText: 'Enter Customer Id',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(height: 10),
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

  //second page
  Widget SecondBankPage() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 135),child: Container(
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
                child: Text('Branch Details',
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
                      controller: _BName,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                      decoration: InputDecoration(labelText: 'Enter Branch Name',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      controller: _BCode,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                      decoration: InputDecoration(labelText: 'Enter Branch Code',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      controller: _BAddress,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),
                      decoration: InputDecoration(labelText: 'Enter Branch Address',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ]),),
          ],
        ),
      ),
      ),
    );
  }

  //third page
  Widget _buildThirdBankPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 135), child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 2,),
        ),
        child: Column(
          children: [
            Container(height: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18.0)), //here
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
              child: const Center(
                child: Text('Net Banking Details',
                    style: TextStyle(color: Colors.white,
                        fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  children: [
                    const SizedBox(height: 50,),
                    TextField(
                      controller: _UserId,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                      decoration: InputDecoration(labelText: 'Enter User Id',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      controller: _Password,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                      decoration: InputDecoration(labelText: 'Enter Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        counterText: '',
                      ),
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      controller: _TPassword,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15,),
                      decoration: InputDecoration(
                        labelText: 'Enter Transaction Password',
                        border: OutlineInputBorder(
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

  //fourth page
  Widget _buildFourthBankPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 95),
        child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 2,),
        ),
        child: Column(
          children: [
            Container(height: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18.0)), //here
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
              child: const Center(
                child: Text('Mobile App Details',
                    style: TextStyle(color: Colors.white,
                        fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  children: [
                    const SizedBox(height: 50,),
                    TextField(
                      controller: _MUserId,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                      decoration: InputDecoration(labelText: 'Enter User Id',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      controller: _MPin,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                      decoration: InputDecoration(labelText: 'Enter Pin',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        counterText: '',
                      ),
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      controller: _MPassword,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                      decoration: InputDecoration(
                        labelText: 'Enter Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        counterText: '',
                      ),
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      controller: _MTPassword,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15,),
                      decoration: InputDecoration(
                        labelText: 'Enter Transction Password',
                        border: OutlineInputBorder(
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

  //fifth page
  Widget _buildFifthBankPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 60),child: Container(
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
                      labelText: 'Enter HelpLine Number 1',border: OutlineInputBorder(
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
                      labelText: 'Enter HelpLine Number 2',border: OutlineInputBorder(
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
                      labelText: 'Enter HelpLine Number 3',border: OutlineInputBorder(
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
                    decoration: InputDecoration(labelText: 'Enter HelpLine Email',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                    onPressed:() {
                      _insertData(
                          _value,
                        AcTypeSelected.text,
                        _BankName.text,
                        _AcNo.text,
                        _AcHolderName.text,
                        _IFSC.text,
                        _MICR.text,
                        _CustomerId.text,
                        _BName.text,
                        _BCode.text,
                        _BAddress.text,
                        _UserId.text,
                        _Password.text,
                        _TPassword.text,
                        _MUserId.text,
                        _MPin.text,
                        _MPassword.text,
                        _MTPassword.text,
                        _HelpLine1.text,
                        _HelpLine2.text,
                        _HelpLine3.text,
                        _HelpLineEmail.text,
                      );
                         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MyHomePage()),(route) => false);
                    },
                    child:  const Text('Save',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
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

  void animateToSlide(int index) => _controller.animateToPage(index, duration: const Duration(milliseconds: 1), curve: Curves.bounceIn);

  _insertData(
      String id,
      String AcTypeSelected,
      String BankName,
      String AcNo,
      String AcHolderName,
      String IFSC,
      String MICR,
      String CustomerId,
      String BName,
      String BCode,
      String BAddress,
      String UserId,
      String Password,
      String TPassword,
      String MUserId,
      String MPin,
      String MPassword,
      String MTPassword,
      String HelpLine1,
      String HelpLine2,
      String HelpLine3,
      String HelpLineEmail,) async {
    SqfliteDbModel data = SqfliteDbModel(
        id: id,
        AcTypeSelected: AcTypeSelected,
        BankName: BankName,
        AcNo:AcNo,
        AcHolderName: AcHolderName,
        IFSC: IFSC,
        MICR: MICR,
        CustomerId:
        CustomerId,
        BName: BName,
        BCode: BCode,
        BAddress: BAddress,
        UserId: UserId,
        Password: Password,
        TPassword: TPassword,
        MUserId: MUserId,
        MPin: MPin,
        MPassword: MPassword,
        MTPassword: MTPassword,
        HelpLine1: HelpLine1,
        HelpLine2: HelpLine2,
        HelpLine3: HelpLine3,
        HelpLineEmail: HelpLineEmail, Fav: '');
    await SqfliteDatabase().insertRecord(data);
    _clearAll;
  }

  _clearAll() {
    _BankName.clear();
    _AcNo.clear();
    _AcHolderName.clear();
    _IFSC.clear();
    _MICR.clear();
    _CustomerId.clear();
    _BName.clear();
    _BCode.clear();
    _BAddress.clear();
    _UserId.clear();
    _Password.clear();
    _TPassword.clear();
    _MUserId.clear();
    _MPin.clear();
    _MPassword.clear();
    _MTPassword.clear();
    _HelpLine1.clear();
    _HelpLine2.clear();
    _HelpLine3.clear();
    _HelpLineEmail.clear();
  }
}











