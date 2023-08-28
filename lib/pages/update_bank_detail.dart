// ignore_for_file: non_constant_identifier_names, prefer_final_fields, use_build_context_synchronously, unnecessary_brace_in_string_interps, unnecessary_string_interpolations
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import '../LocalDatabase/SQl_database.dart';
import '../LocalDatabase/bank_model.dart';
import '../Screens/home_screen.dart';

// ignore: must_be_immutable
class UpDateBankDetail extends StatefulWidget {
  static var routeName = '/UpdateBankPage';
  SqfliteDbModel? data;
   UpDateBankDetail(this.data,{Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UpDateBankDetailState createState() => _UpDateBankDetailState();
}

class _UpDateBankDetailState extends State<UpDateBankDetail> {

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
  List<String> AcType = [
    'Saving Account',
    'Regular Account',
    'Current Account',
    'Recurring Deposite Account',
    'Fixed Deposite Account',
    'Demat Account',
    'NRI Account'
  ];

  String _button = "insertRecord";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.data != null) {
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
      setState(() {
        _button = "Update";
      });
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('UPDATE BANK DETAILS'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: SqfliteDatabase().fetchData(),
          builder: (BuildContext context, AsyncSnapshot<List<SqfliteDbModel>> snapshot) {
            if(snapshot.hasData) {
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
            }else {
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
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
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
                const Text('Select Account Type',
                  style: TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Padding(padding: const EdgeInsets.all(1.0),
                        child: DropDownField(
                          controller: AcTypeSelected,
                          enabled: true,
                          hintText: "Select Card",
                          items: AcType,
                        ),),
                      const SizedBox(height: 10,),
                      TextFormField(
                        controller: _BankName,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 15),
                        decoration: InputDecoration(labelText: "Enter Bank Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
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
                          if (value == null || value.isEmpty) {
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
                        decoration: InputDecoration(labelText: 'Enter Account number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          counterText: '',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter a Account number';
                          }
                          return null;
                        },
                        maxLength: 16,
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
                        decoration: InputDecoration(labelText: 'Enter IFSC',
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
                        decoration: InputDecoration(labelText: 'Enter MICR',
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
  Widget SecondBankPage(SqfliteDbModel data) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 180),
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
                  child: Text('Branch Details',
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
                        controller: _BName,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        decoration: InputDecoration(
                          labelText: 'Enter Branch Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      const SizedBox(height: 30,),
                      TextField(
                        controller: _BCode,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        decoration: InputDecoration(
                          labelText: 'Enter Branch Code',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      const SizedBox(height: 30,),
                      TextField(
                        controller: _BAddress,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15,),
                        decoration: InputDecoration(
                          labelText: 'Enter Branch Address',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
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
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 180),
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
                  child: Text('Net Banking Details',
                      style: TextStyle(color: Colors.white,
                          fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 10,),
                child: Column(
                    children: [
                      const SizedBox(height: 50,),
                      TextField(
                        controller: _UserId,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        decoration: InputDecoration(
                          labelText: 'Enter User Id',
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
                        decoration: InputDecoration(
                            labelText: 'Enter Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          counterText: '',
                        ),
                        maxLength: 8,
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
                        maxLength: 8,
                      ),
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
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 150),
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
                        decoration: InputDecoration(
                          labelText: 'Enter User Id',
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
                        decoration: InputDecoration(
                          labelText: 'Enter Pin',
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
                          labelText: 'Enter Transaction Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          counterText: '',
                        ),
                      ),
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
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 120),
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
                  child: Text('Help Line Number',
                      style: TextStyle(color: Colors.white,
                          fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(child: Column(
                  children: [
                    const SizedBox(height: 50,),
                    TextField(
                      controller: _HelpLine1,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                      decoration: InputDecoration(
                        labelText: 'Enter HelpLine Number 1',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        counterText: '',
                      ),
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      controller: _HelpLine2,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                      decoration: InputDecoration(
                          labelText: 'Enter HelpLine Number 2',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        counterText: '',
                      ),
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      controller: _HelpLine3,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15,),
                      decoration: InputDecoration(
                        labelText: 'Enter HelpLine Number 3',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        counterText: '',
                      ),
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      controller: _HelpLineEmail,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15,),
                      decoration: InputDecoration(
                        labelText: 'Enter HelpLine Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    ElevatedButton(
                      onPressed: () {
                          _updateData(
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
                          _HelpLineEmail.text
                        );
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const MyHomePage()),(route) => false);
                      },
                      child: Text("${_button}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 40,)
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

  _updateData(String id,
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
      String HelpLineEmail
      ) async {
    SqfliteDbModel data = SqfliteDbModel(
        id: widget.data!.id,
        AcTypeSelected: AcTypeSelected,
        BankName: BankName,
        AcNo: AcNo,
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
        HelpLineEmail: HelpLineEmail, Fav: 'Fav',);
   await SqfliteDatabase().updateData(data);
  }
}