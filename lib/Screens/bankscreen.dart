// ignore_for_file: avoid_web_libraries_in_flutter, unnecessary_string_interpolations, non_constant_identifier_names, use_build_context_synchronously, avoid_unnecessary_containers, sized_box_for_whitespace, unnecessary_this, prefer_const_constructors, avoid_print, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables, must_be_immutable, unused_local_variable, unnecessary_null_comparison, unnecessary_brace_in_string_interps, unrelated_type_equality_checks, annotate_overrides, void_checks, dead_code

import 'package:codersqund_bankmaster/pages/add_bank_detail.dart';
import 'package:codersqund_bankmaster/pages/bank_detailscreen.dart';
import 'package:codersqund_bankmaster/pages/update_bank_detail.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:styled_divider/styled_divider.dart';
import '../LocalDatabase/SQl_database.dart';
import '../LocalDatabase/bank_model.dart';
import '../LocalDatabase/bank_model2.dart';
import 'home_screen.dart';

class BankScreen extends StatefulWidget {
  SqfliteDbModel? data;
   BankScreen({super.key});

  @override
  State<BankScreen> createState() => _BankScreenState();
}

class _BankScreenState extends State<BankScreen> with WidgetsBindingObserver {
  SqfliteDbModel? data;

   var BankName;

   var value;

  var Fav;

  var id;

  @override
  void initState() {
    super.initState();
    SqfliteDatabase().fetchData();
    if(widget.data != null) {
      value = widget.data!.AcTypeSelected;
      BankName = widget.data!.BankName;
      Fav = widget.data!.Fav;
     id = widget.data!.id;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('TEST');
  }

 String checkType = '0';

  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Bank",style: TextStyle(color: Colors.white),),
        elevation: 5,
        actions: [
          IconButton(
              onPressed: () => showSearch(context: context, delegate: Search(BankName)),
              icon: Icon(Icons.search,color: Colors.white,),
          ),
            PopupMenuButton(
              iconColor: Colors.white,
              color: Colors.white,
              onSelected: (value) {
                if(value == 0) {
                  setState(() {
                    checkType = '0';
                  });
                } else if(value == 1) {
                  setState(() {
                    checkType = '1';
                  });
                }else if(value == 2) {
                  setState(() {
                    checkType = '2';
                  });
                }else if(value == 3) {
                  setState(() {
                    checkType = '3';
                  });
                }else if(value == 4) {
                  setState(() {
                    checkType = '4';
                  });
                }else if(value == 5) {
                  setState(() {
                    checkType = '5';
                  });
                }else if(value == 6) {
                  setState(() {
                    checkType = '6';
                  });
                }else if(value == 7) {
                  setState(() {
                    checkType = '7';
                  });
                }
              },
              itemBuilder: (context) =>
              [
                PopupMenuItem(
                  value: 0,
                  child: Text('All',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text('Saving Account',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text('Regular Account',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Text('Current Account',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                PopupMenuItem(
                  value: 4,
                  child: Text('Recurring Deposite Account',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                PopupMenuItem(
                  value: 5,
                  child: Text('Fixed Deposite Account',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                PopupMenuItem(
                  value: 6,
                  child: Text('Demat Account',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                PopupMenuItem(
                  value: 7,
                  child: Text('NRI Account',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
        ],
      ),
      body: Center(
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5,),
        child: _bankList(context,checkType),),),
      floatingActionButton: FloatingActionButton(
        elevation: 12,
        heroTag: 1,
        onPressed: ()  {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddBankDetails()));
        },
        child: const Icon(Icons.add),
      ),
    );}

   _bankList(BuildContext context,String checkType) {
     return Scaffold(
       backgroundColor: Colors.white,
       body: SafeArea(
         child: FutureBuilder(
           future: SqfliteDatabase().fetchData(),
           builder: (BuildContext context,AsyncSnapshot<List<SqfliteDbModel>> snapshot) {
             if(snapshot.hasData) {
               return  ListView.builder(
                 padding: const EdgeInsets.all(5),
                 itemCount: snapshot.data!.length,
                 itemBuilder: (ctx,index) {
                   if(checkType == '0'){
                     return _ListItem(snapshot.data![index],context,checkType);
                   }else if(checkType == '1'){
                     if(snapshot.data![index].AcTypeSelected == 'Saving Account') {
                       return _ListItem(snapshot.data![index],context,checkType);
                     }
                   }
                   else if(checkType == '2') {
                     if(snapshot.data![index].AcTypeSelected == 'Regular Account') {
                       return _ListItem(snapshot.data![index],context,checkType);
                     }
                   }
                   else if(checkType == '3') {
                     if(snapshot.data![index].AcTypeSelected == 'Current Account') {
                       return _ListItem(snapshot.data![index],context,checkType);
                     }
                   }else if(checkType == '4') {
                     if(snapshot.data![index].AcTypeSelected == 'Recurring Deposite Account') {
                       return _ListItem(snapshot.data![index],context,checkType);
                     }
                   }else if(checkType == '5') {
                     if(snapshot.data![index].AcTypeSelected == 'Fixed Deposite Account') {
                       return _ListItem(snapshot.data![index],context,checkType);
                     }
                   }else if(checkType == '6') {
                     if(snapshot.data![index].AcTypeSelected == 'Demat Account') {
                       return _ListItem(snapshot.data![index],context,checkType);
                     }
                   }else if(checkType == '7') {
                     if(snapshot.data![index].AcTypeSelected == 'NRI Account') {
                       return _ListItem(snapshot.data![index],context,checkType);
                     }
                   }
                   return Container();
                  //  return Column(
                  //    children: [
                  // Center(child: _ListItem(snapshot.data![index],context,checkType),) ,
                  //    ],
                  //  );
                 },
               );
             } else {
               return const Center(
                 child: Text('No Data Found'),
               );
             }
           },
         ),),
     );
   }

  _ListItem(SqfliteDbModel data,context,String checkType) {
      bool FavIconType = false;

      try {
        // Trim whitespace and then parse the value
        int favValue = int.parse(data.Fav.trim());

        // Check if the parsed value is 1
        if (favValue == 1) {
          FavIconType = true;
        }
      } on FormatException {
        // Handle the case where parsing fails
        // This could be due to an invalid number format
        // Set a default value or perform other error handling
      }

      // if(int.parse(data.Fav) == 1){
      //   FavIconType = true;
      // }
    return SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 768) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 5),
                child: Stack(
                  children: [
                    Image.asset('assets/passbook.png'),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      "${data.BankName}",
                                      style: const TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo),
                                    ),
                                    Text(
                                      "${data.AcTypeSelected}",
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(top: 5),
                                    child: Text("${data.AcHolderName}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )),
                                StyledDivider(
                                  color: Colors.black,
                                  height: 50,
                                  thickness: 2,
                                  lineStyle: DividerLineStyle.dashed,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text("A/c : ${data.AcNo}",
                                      style: const TextStyle(fontSize: 18,
                                          fontWeight: FontWeight.bold),),
                                    FavoriteButton(iconSize: 45, isFavorite : FavIconType,
                                        valueChanged:(isSelected) {
                                              String isSelected = data.Fav;
                                              String id = data.id;
                                              String Fav = data.Fav;
                                                setState(() {
                                                  if(Fav == '1') {
                                                    Fav = '0';
                                                    isSelected = data.Fav;
                                                    _updateData(id,Fav);
                                                  }else {
                                                    Fav = '1';
                                                    isSelected = data.Fav;
                                                    _updateData(id,Fav);
                                                  }print(Fav);
                                                });
                                        }),
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
                                        PopupMenuItem<int>(
                                          value: 1,
                                          child: Row(
                                            children: const [
                                              Icon(Icons.share,
                                                color: Colors.black,),
                                              Padding(padding: EdgeInsets.only(
                                                  left: 12.0),
                                                child: Text('Share'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem<int>(
                                          value: 2,
                                          child: Row(
                                            children: const [
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
                                        color: Colors.black, size: 25,),
                                    ),
                                  ],),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>  BankDetail(data)),(route) => false);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Stack(
                children: [
                  Padding(padding: EdgeInsets.all(80),
                    child: Image.asset('assets/passbook.png'),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(90),
                          child: Column(
                            children: [
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    "${data.BankName}",
                                    style: const TextStyle(fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo),
                                  ),
                                  Text(
                                    "${data.AcTypeSelected}",
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 55,),
                              Padding(padding: EdgeInsets.only(top: 5),
                                  child: Text("${data.AcHolderName}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )),
                              StyledDivider(
                                color: Colors.black,
                                height: 50,
                                thickness: 2,
                                lineStyle: DividerLineStyle.dashed,
                              ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text("A/c : ${data.AcNo}",
                                    style: const TextStyle(fontSize: 22,
                                        fontWeight: FontWeight.bold),),
                                  SizedBox(height: 50,),
                                  FavoriteButton(iconSize: 60,
                                      valueChanged:(isSelected) {
                                        String isSelected = data.Fav;
                                        String id = data.id;
                                        String Fav = data.Fav;

                                        setState(() {
                                          if(Fav == '1') {
                                            Fav = '0';
                                            isSelected = data.Fav;
                                            _updateData(id,Fav);
                                          }else {
                                            Fav = '1';
                                            isSelected = data.Fav;
                                            _updateData(id,Fav);
                                          }print(Fav);
                                        });
                                      }),
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
                                      PopupMenuItem<int>(
                                        value: 1,
                                        child: Row(
                                          children: const [
                                            Icon(Icons.share,
                                              color: Colors.black,),
                                            Padding(padding: EdgeInsets.only(
                                                left: 12.0),
                                              child: Text('Share'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem<int>(
                                        value: 2,
                                        child: Row(
                                          children: const [
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
                                      color: Colors.black, size: 25,),
                                  ),
                                ],),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>  BankDetail(data)),(route) => false);
                        },
                      ),
                    ],
                  ),
                ],
              );
            }
          },),);
  }
}

void _updateData(String id,String Fav) async {
  BankDbModel data = BankDbModel(id: id, Fav: Fav);
  await SqfliteDatabase().updateDataBank(data);print(data);
}

_ListItem(SqfliteDbModel data,context,String checkType,toggleSelection,isSelected) {
  return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 768) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Stack(
                children: [
                  Image.asset('assets/passbook.png'),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    "${data.BankName}",
                                    style: const TextStyle(fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo),
                                  ),
                                  Text(
                                    "${data.AcTypeSelected}",
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Padding(padding: EdgeInsets.only(top: 5),
                                  child: Text("${data.AcHolderName}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                              StyledDivider(
                                color: Colors.black,
                                height: 50,
                                thickness: 2,
                                lineStyle: DividerLineStyle.dashed,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text("A/c : ${data.AcNo}",
                                    style: const TextStyle(fontSize: 18,
                                        fontWeight: FontWeight.bold),),
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
                                      PopupMenuItem<int>(
                                        value: 1,
                                        child: Row(
                                          children: const [
                                            Icon(Icons.share,
                                              color: Colors.black,),
                                            Padding(padding: EdgeInsets.only(
                                                left: 12.0),
                                              child: Text('Share'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem<int>(
                                        value: 2,
                                        child: Row(
                                          children: const [
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
                                      color: Colors.black, size: 25,),
                                  ),
                                ],),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Stack(
              children: [
                Padding(padding: EdgeInsets.all(80),
                  child: Image.asset('assets/passbook.png'),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(90),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text(
                                  "${data.BankName}",
                                  style: const TextStyle(fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo),
                                ),
                                Text(
                                  "${data.AcTypeSelected}",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 55,),
                            Padding(padding: EdgeInsets.only(top: 5),
                                child: Text("${data.AcHolderName}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                )),
                            StyledDivider(
                              color: Colors.black,
                              height: 50,
                              thickness: 2,
                              lineStyle: DividerLineStyle.dashed,
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text("A/c : ${data.AcNo}",
                                  style: const TextStyle(fontSize: 22,
                                      fontWeight: FontWeight.bold),),
                                SizedBox(height: 50,),
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
                                    PopupMenuItem<int>(
                                      value: 1,
                                      child: Row(
                                        children: const [
                                          Icon(Icons.share,
                                            color: Colors.black,),
                                          Padding(padding: EdgeInsets.only(
                                              left: 12.0),
                                            child: Text('Share'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem<int>(
                                      value: 2,
                                      child: Row(
                                        children: const [
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
                                    color: Colors.black, size: 25,),
                                ),
                              ],),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },));
}

onSelected(BuildContext context, int item, SqfliteDbModel data) {
switch(item) {
  case 0: Navigator.push(context, MaterialPageRoute(builder: (context) =>  UpDateBankDetail(data)));
  break;
  case 1: Share.share('Bank Name: ${data.BankName}\n\n BranchName:${data.BName}\n\n Ac Holder Name: ${data.AcHolderName}\n\n Account number: ${data.AcNo}\n\n IFSC Code: ${data.IFSC}\n\n');
  break;
  case 2: var response = SqfliteDatabase().deleteRecord("${data.id}");
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

class Search extends  SearchDelegate {
  String checkType = '0';
  SqfliteDbModel? data;
  final BankName;

  Search(this.BankName);

  bool isSelected = false;

  void toggleSelection() {
    isSelected = !isSelected;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(onPressed: () {
        query = "";
      }, icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: SqfliteDatabase().fetchData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<SqfliteDbModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                if(query == ""){
                  return _ListItem(snapshot.data![index], context, checkType,
                      toggleSelection,isSelected);
                }else if(snapshot.data![index].BankName.toLowerCase().contains(query.toLowerCase())) {
                  return _ListItem(snapshot.data![index], context, checkType,toggleSelection,isSelected);
                } else {
                  return Container();
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: SqfliteDatabase().fetchData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<SqfliteDbModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                if(query == ""){
                  return _ListItem(snapshot.data![index], context, checkType,toggleSelection,isSelected);
                }else if(snapshot.data![index].BankName.toLowerCase().contains(query.toLowerCase())) {
                  return _ListItem(snapshot.data![index], context, checkType,toggleSelection,isSelected);
                } else {
                  return Container();
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),);
  }
}
