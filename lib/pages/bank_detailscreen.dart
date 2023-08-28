// ignore_for_file: non_constant_identifier_names, prefer_final_fields, use_build_context_synchronously, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, unused_field
import 'package:codersqund_bankmaster/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../LocalDatabase/SQl_database.dart';
import '../LocalDatabase/bank_model.dart';
import '../Screens/bankscreen.dart';

// ignore: must_be_immutable
class BankDetail extends StatefulWidget {
  static var routeName = '/UpdateBankPage';
  SqfliteDbModel? data;
  BankDetail(this.data,{Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BankDetailState createState() => _BankDetailState();
}

class _BankDetailState extends State<BankDetail> {

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
  final _controller = PageController();
  final AcTypeSelected = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.data != null) {
      AcTypeSelected.text = widget.data!.AcTypeSelected;
      _BankName.text = widget.data!.BankName;
      _AcHolderName.text = widget.data!.AcHolderName;
      _AcNo.text = widget.data!.AcNo;
      _IFSC.text = widget.data!.IFSC;
      _MICR.text = widget.data!.MICR;
      _CustomerId.text = widget.data!.CustomerId;
      _BName.text = widget.data!.BName;
      _BCode.text = widget.data!.BCode;
      _BAddress.text = widget.data!.BAddress;
      _UserId.text = widget.data!.UserId;
      _Password.text = widget.data!.Password;
      _TPassword.text = widget.data!.TPassword;
      _MUserId.text = widget.data!.MUserId;
      _MPin.text = widget.data!.MPin;
      _MPassword.text = widget.data!.MPassword;
      _MTPassword.text = widget.data!.MTPassword;
      _HelpLine1.text = widget.data!.HelpLine1;
      _HelpLine2.text = widget.data!.HelpLine2;
      _HelpLine3.text = widget.data!.HelpLine3;
      _HelpLineEmail.text = widget.data!.HelpLineEmail;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const MyHomePage()));
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('BANK DETAILS'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: SqfliteDatabase().fetchData(),
          builder: (BuildContext context,
              AsyncSnapshot<List<SqfliteDbModel>> snapshot) {
            if (snapshot.hasData) {
              return PageView(
                controller: _controller,
                children: [
                  FirstBankPage(snapshot.data!.first),
                  SecondBankPage(snapshot.data!.first),
                  ThirdBankPage(snapshot.data!.first),
                  FourthBankPage(snapshot.data!.first),
                  FifthBankPage(snapshot.data!.first),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  //First page
  Widget FirstBankPage(SqfliteDbModel data) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 2,),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 60,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(18.0)), //here
                    color: Theme
                        .of(context)
                        .primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text('Bank Details',
                        style: TextStyle(color: Colors.white,
                            fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                      PopupMenuButton<int>(
                        onSelected: (item) =>
                            onSelected(context, item, data),
                        itemBuilder: (context) =>
                        [
                          const PopupMenuItem<int>(
                            value: 0,
                            child: Row(
                              children: [
                                Icon(Icons.edit,
                                  color: Colors.black,),
                                Padding(padding: EdgeInsets.only(
                                    left: 12.0),
                                  child: Text('update'),
                                ),
                              ],
                            ),
                          ),
                          const PopupMenuItem<int>(
                            value: 1,
                            child: Row(
                              children: [
                                Icon(Icons.share,
                                  color: Colors.black,),
                                Padding(padding: EdgeInsets.only(
                                    left: 12.0),
                                  child: Text('Share'),
                                ),
                              ],
                            ),
                          ),
                          const PopupMenuItem<int>(
                            value: 2,
                            child: Row(
                              children: [
                                Icon(Icons.delete_forever,
                                  color: Colors.black,),
                                Padding(padding: EdgeInsets.only(
                                    left: 12.0),
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          ),
                        ],
                        child: const Icon(Icons.more_vert_sharp,
                          color: Colors.white, size: 25,),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Account Type:-  ${AcTypeSelected.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40,),
                      Text('Bank Name:-   ${_BankName.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40,),
                      Text('Account Holder Name:-   ${_AcHolderName.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40,),
                      Text('Account Number:-   ${_AcNo.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40,),
                      Text('IFSC Code:-   ${_IFSC.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40,),
                      Text('MICR Code:-   ${_MICR.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40,),
                      Text('Customer Id:-   ${_CustomerId.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40,),
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
  Widget SecondBankPage(SqfliteDbModel data) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 180),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 2,),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Text('Branch Details',
                      style: TextStyle(color: Colors.white,
                          fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40,),
                      Text('Branch Name:-   ${_BName.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40,),
                      Text('Branch Code:-   ${_BCode.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40,),
                      Text('Branch Address:-   ${_BAddress.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40,)
                    ]),),
            ],
          ),
        ),
      ),
      ),
    );
  }

  //third page
  Widget ThirdBankPage(SqfliteDbModel data) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 180),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 2,),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Padding(padding: const EdgeInsets.symmetric(horizontal: 10,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40,),
                      Text('User Id:-   ${_UserId.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40,),
                      Text('Password:-   ${_Password.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40,),
                      Text('Transaction Password:-   ${_TPassword.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40,)
                    ]),),
            ],
          ),
        ),
      ),
      ),
    );
  }

  //fourth page
  Widget FourthBankPage(SqfliteDbModel data) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 150),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 2,),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40,),
                      Text('User Id:-   ${_MUserId.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40,),
                      Text('Pin:-   ${_MPin.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40,),
                      Text('Password:-   ${_MPassword.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40,),
                      Text('Transaction Password:-   ${_MTPassword.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 40,)
                    ]),),
            ],
          ),
        ),
      ),
      ),
    );
  }

  //fifth page
  Widget FifthBankPage(SqfliteDbModel data) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 120),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 2,),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Text('Help Line Number',
                      style: TextStyle(color: Colors.white,
                          fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40,),
                    Text('HelpLineNumber1:-   ${_HelpLine1.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 40,),
                    Text('HelpLineNumber2:-   ${_HelpLine2.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 40,),
                    Text('HelpLineNumber3:-   ${_HelpLine3.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 40,),
                    Text('HelpLine Email:-   ${_HelpLineEmail.text}', style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 40,),
                  ],
                ),
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