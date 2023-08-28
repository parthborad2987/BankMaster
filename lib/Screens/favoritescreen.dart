// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_string_interpolations, unused_element, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, must_be_immutable, prefer_const_constructors, dead_code, avoid_print, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:styled_divider/styled_divider.dart';
import '../LocalDatabase/bank_model.dart';
import '../LocalDatabase/SQl_database.dart';
import '../LocalDatabase/card_model.dart';
import '../pages/bank_detailscreen.dart';
import '../pages/card_detailscreen.dart';
import '../pages/update_bank_detail.dart';
import '../pages/update_card_detail.dart';
import 'home_screen.dart';

class FavoriteScreen extends StatefulWidget {
  SqfliteDbModel? data;
  SqfliteDbModel1? data1;
   FavoriteScreen({super.key});


  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
 String CardType = 'n';

  var card;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Home'),
      ),
       body:  Stack(
         children: [

           _BankView(),
           _CardView(),
       ],)
    );
  }

 _ListItem(SqfliteDbModel data,context,) {
  String iconType = data.Fav;
  if(iconType == '1') {
    return SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 768) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 45,horizontal: 5),
                child: Stack(
                  children: [
                    Image.asset('assets/passbook.png'),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(10),
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
                                Padding(padding: const EdgeInsets.only(top: 5),
                                    child: Text("${data.AcHolderName}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )),
                                const StyledDivider(
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
                                          onSelected(context, item,data),
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
                                        color: Colors.black, size: 25,),
                                    ),
                                  ],),
                                SizedBox(height: 470,)
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
              return SingleChildScrollView(
                  child: ListTile(title: Stack(
                children: [
                  Padding(padding:  EdgeInsets.symmetric(horizontal: 120,),
                    child: Image.asset('assets/passbook.png'),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 150,vertical: 10),
                          child: Column(
                            children: [
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
                              Padding(padding: const EdgeInsets.only(top: 5),
                                  child: Text("${data.AcHolderName}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )),
                              const StyledDivider(
                                color: Colors.black,
                                height: 50,
                                thickness: 2,
                                lineStyle: DividerLineStyle.dashed,
                              ),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text("A/c : ${data.AcNo}",
                                    style: const TextStyle(fontSize: 22,
                                        fontWeight: FontWeight.bold),),
                                  const SizedBox(height: 50,),
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
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>  BankDetail(data)),(route) => false);
                    },
              ),
              );
            }
          },));
  } else {
    'NO data Found!';
  }
  return null;
}

  onSelected(BuildContext context, int item, SqfliteDbModel data) {
    switch(item) {
      case 0: Navigator.push(context, MaterialPageRoute(builder: (context) =>  UpDateBankDetail(data)));
      break;
      case 1: Share.share('Bank Name: ${data.BankName}\n\n BranchName:${data.BName}\n\n Ac Holder Name: ${data.AcHolderName}\n\n Account number: ${data.AcNo}\n\n');
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

_GenerateCard(SqfliteDbModel1 data1,String icon,String image1,context,String Ctype) {
 String Fav = data1.Fav1;
 if(Fav == '1') {
   if(Ctype == '1'){
     if(data1.cardtypeSelected == "Credit Card"){
       return SafeArea(
         child: LayoutBuilder(
           builder: (context,constrains) {
             if(constrains.maxWidth < 768) {
               return Container(
                 padding:  const EdgeInsets.all(100),
                 decoration:  BoxDecoration(
                   borderRadius: const BorderRadius.all(Radius.circular(20),
                   ),
                   image: DecorationImage(image: AssetImage(image1)),
                 ),
                 child: Stack(
                   children: [
                     Column(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Column(
                               children: [
                                 Text("${data1.BName}",
                                   style: const TextStyle(
                                     fontSize: 25,
                                     fontFamily: "Roboto",
                                     color: Colors.white,
                                   ),
                                 ),
                                 const SizedBox(height: 35),
                                 Text("${data1.cardtypeSelected}",
                                   style: const TextStyle(
                                     fontSize: 1,
                                     fontFamily: "Roboto",
                                     color: Colors.white,
                                   ),
                                 ),
                               ],
                             ),
                             Image.asset(icon,height: 60,alignment: Alignment.topRight),
                           ],
                         ),
                         const SizedBox(height: 60),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                               "${data1.Cno}",
                               style: const TextStyle(
                                 fontFamily: "Roboto",
                                 fontSize: 24,
                                 color: Colors.white,
                               ),
                             ),
                           ],
                         ),
                         const SizedBox(height: 5),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                               "${data1.CardHolderName}",
                               style: const TextStyle(
                                 fontFamily: "Roboto",
                                 fontSize: 18,
                                 color: Colors.white,
                               ),
                             ),
                             SizedBox(width: 10),
                             Text(
                               "${data1.Exdate}",
                               style: const TextStyle(
                                 fontFamily: "Roboto",
                                 fontSize: 18,
                                 color: Colors.white,
                               ),
                             ),
                           ],
                         ),
                         SizedBox(height: 10,),
                       ],
                     ),
                     Expanded(
                       flex: 3,
                       child: PopupMenuButton<int>(
                         onSelected: (item) => onSelected1(context,item,data1),
                         itemBuilder: (context) => [
                           PopupMenuItem<int>(
                             value: 0,
                             child: Row(
                               children: const [
                                 Icon(Icons.edit,),
                                 Padding(padding: EdgeInsets.only(left: 12.0),
                                   child: Text('update'),
                                 ),
                               ],
                             ),
                           ),
                           PopupMenuItem<int>(
                             value: 1,
                             child: Row(
                               children: const [
                                 Icon(Icons.share,color: Colors.black,),
                                 Padding(padding: EdgeInsets.only(left: 12.0),
                                   child: Text('Share'),
                                 ),
                               ],
                             ),
                           ),
                           PopupMenuItem<int>(
                             value: 2,
                             child: Row(
                               children: const [
                                 Icon(Icons.delete_forever),
                                 Padding(padding: EdgeInsets.only(left: 12.0),
                                   child: Text('Delete'),
                                 ),
                               ],
                             ),
                           ),
                         ],
                         child: const Icon(Icons.more_vert_sharp, color: Colors.white,size: 25,),
                       ),),
                   ],
                 ),
               );
             } else {
               return Container(
                 padding:  const EdgeInsets.all(100),
                 decoration:  BoxDecoration(
                   borderRadius: const BorderRadius.all(Radius.circular(20),
                   ),
                   image: DecorationImage(image: AssetImage(image1)),
                 ),
                 child: Stack(
                   children: [
                     Column(children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             children: [
                               Text("${data1.BName}",
                                 style: const TextStyle(
                                   fontSize: 25,
                                   fontFamily: "Roboto",
                                   color: Colors.white,
                                 ),
                               ),
                               const SizedBox(height: 100),
                               Text("${data1.cardtypeSelected}",
                                 style: const TextStyle(
                                   fontSize: 1,
                                   fontFamily: "Roboto",
                                   color: Colors.white,
                                 ),
                               ),
                             ],
                           ),
                           Image.asset(icon,height: 120,alignment: Alignment.topRight),
                         ],
                       ),
                       const SizedBox(height: 100),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                             "${data1.Cno}",
                             style: const TextStyle(
                               fontFamily: "Roboto",
                               fontSize: 45,
                               color: Colors.white,
                             ),
                           ),
                         ],
                       ),
                       const SizedBox(height: 25),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                             "${data1.CardHolderName}",
                             style: const TextStyle(
                               fontFamily: "Roboto",
                               fontSize: 40,
                               color: Colors.white,
                             ),
                           ),
                           SizedBox(width: 20),
                           Text(
                             "${data1.Exdate}",
                             style: const TextStyle(
                               fontFamily: "Roboto",
                               fontSize: 30,
                               color: Colors.white,
                             ),
                           ),
                           // SizedBox(width: 50,),
                         ],
                       ),
                     ],
                     ),
                     Positioned(height: 666,
                       left: 605,
                       child: PopupMenuButton<int>(
                         onSelected: (item) => onSelected1(context,item,data1),
                         itemBuilder: (context) => [
                           PopupMenuItem<int>(
                             value: 0,
                             child: Row(
                               children: const [
                                 Icon(Icons.edit,),
                                 Padding(padding: EdgeInsets.only(left: 12.0),
                                   child: Text('update'),
                                 ),
                               ],
                             ),
                           ),
                           PopupMenuItem<int>(
                             value: 1,
                             child: Row(
                               children: const [
                                 Icon(Icons.share,color: Colors.black,),
                                 Padding(padding: EdgeInsets.only(left: 12.0),
                                   child: Text('Share'),
                                 ),
                               ],
                             ),
                           ),
                           PopupMenuItem<int>(
                             value: 2,
                             child: Row(
                               children: const [
                                 Icon(Icons.delete_forever),
                                 Padding(padding: EdgeInsets.only(left: 12.0),
                                   child: Text('Delete'),
                                 ),
                               ],
                             ),
                           ),
                         ],
                         child: const Icon(Icons.more_vert_sharp, color: Colors.white,size: 45,),
                       ),),
                   ],
                 ),
               );
             }
           },
         ),
       );
     }else{
       return Container();
     }
   }else if (Ctype == '2'){
     if(data1.cardtypeSelected == "Debit Card"){
       return SafeArea(
         child: LayoutBuilder(
           builder: (context,constrains) {
             if(constrains.maxWidth < 768) {
               return Container(
                 padding:  const EdgeInsets.all(32),
                 decoration:  BoxDecoration(
                   borderRadius: const BorderRadius.all(Radius.circular(20),
                   ),
                   image: DecorationImage(image: AssetImage(image1)),
                 ),
                 child: Stack(
                   children: [
                     Column(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Column(
                               children: [
                                 Text("${data1.BName}",
                                   style: const TextStyle(
                                     fontSize: 25,
                                     fontFamily: "Roboto",
                                     color: Colors.white,
                                   ),
                                 ),
                                 const SizedBox(height: 35),
                                 Text("${data1.cardtypeSelected}",
                                   style: const TextStyle(
                                     fontSize: 1,
                                     fontFamily: "Roboto",
                                     color: Colors.white,
                                   ),
                                 ),
                               ],
                             ),
                             Image.asset(icon,height: 60,alignment: Alignment.topRight),
                           ],
                         ),
                         const SizedBox(height: 60),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                               "${data1.Cno}",
                               style: const TextStyle(
                                 fontFamily: "Roboto",
                                 fontSize: 24,
                                 color: Colors.white,
                               ),
                             ),
                           ],
                         ),
                         const SizedBox(height: 5),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                               "${data1.CardHolderName}",
                               style: const TextStyle(
                                 fontFamily: "Roboto",
                                 fontSize: 18,
                                 color: Colors.white,
                               ),
                             ),
                             SizedBox(width: 10),
                             Text(
                               "${data1.Exdate}",
                               style: const TextStyle(
                                 fontFamily: "Roboto",
                                 fontSize: 18,
                                 color: Colors.white,
                               ),
                             ),
                           ],
                         ),
                         SizedBox(height: 10,)
                       ],
                     ),
                     Positioned(height: 335,
                       left: 300,
                       child: PopupMenuButton<int>(
                         onSelected: (item) => onSelected1(context,item,data1),
                         itemBuilder: (context) => [
                           PopupMenuItem<int>(
                             value: 0,
                             child: Row(
                               children: const [
                                 Icon(Icons.edit,),
                                 Padding(padding: EdgeInsets.only(left: 12.0),
                                   child: Text('update'),
                                 ),
                               ],
                             ),
                           ),
                           PopupMenuItem<int>(
                             value: 1,
                             child: Row(
                               children: const [
                                 Icon(Icons.share,color: Colors.black,),
                                 Padding(padding: EdgeInsets.only(left: 12.0),
                                   child: Text('Share'),
                                 ),
                               ],
                             ),
                           ),
                           PopupMenuItem<int>(
                             value: 2,
                             child: Row(
                               children: const [
                                 Icon(Icons.delete_forever),
                                 Padding(padding: EdgeInsets.only(left: 12.0),
                                   child: Text('Delete'),
                                 ),
                               ],
                             ),
                           ),
                         ],
                         child: const Icon(Icons.more_vert_sharp, color: Colors.white,size: 25,),
                       ),),
                   ],
                 ),
               );
             } else {
               return Container(
                 padding:  const EdgeInsets.all(100),
                 decoration:  BoxDecoration(
                   borderRadius: const BorderRadius.all(Radius.circular(20),
                   ),
                   image: DecorationImage(image: AssetImage(image1)),
                 ),
                 child: Stack(
                   children: [
                     Column(children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             children: [
                               Text("${data1.BName}",
                                 style: const TextStyle(
                                   fontSize: 25,
                                   fontFamily: "Roboto",
                                   color: Colors.white,
                                 ),
                               ),
                               const SizedBox(height: 100),
                               Text("${data1.cardtypeSelected}",
                                 style: const TextStyle(
                                   fontSize: 1,
                                   fontFamily: "Roboto",
                                   color: Colors.white,
                                 ),
                               ),
                             ],
                           ),
                           Image.asset(icon,height: 120,alignment: Alignment.topRight),
                         ],
                       ),
                       const SizedBox(height: 100),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                             "${data1.Cno}",
                             style: const TextStyle(
                               fontFamily: "Roboto",
                               fontSize: 45,
                               color: Colors.white,
                             ),
                           ),
                         ],
                       ),
                       const SizedBox(height: 25),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                             "${data1.CardHolderName}",
                             style: const TextStyle(
                               fontFamily: "Roboto",
                               fontSize: 40,
                               color: Colors.white,
                             ),
                           ),
                           SizedBox(width: 20),
                           Text(
                             "${data1.Exdate}",
                             style: const TextStyle(
                               fontFamily: "Roboto",
                               fontSize: 30,
                               color: Colors.white,
                             ),
                           ),
                           // SizedBox(width: 50,),
                         ],
                       ),
                     ],
                     ),
                     Positioned(height: 666,
                       left: 605,
                       child: PopupMenuButton<int>(
                         onSelected: (item) => onSelected1(context,item,data1),
                         itemBuilder: (context) => [
                           PopupMenuItem<int>(
                             value: 0,
                             child: Row(
                               children: const [
                                 Icon(Icons.edit,),
                                 Padding(padding: EdgeInsets.only(left: 12.0),
                                   child: Text('update'),
                                 ),
                               ],
                             ),
                           ),
                           PopupMenuItem<int>(
                             value: 1,
                             child: Row(
                               children: const [
                                 Icon(Icons.share,color: Colors.black,),
                                 Padding(padding: EdgeInsets.only(left: 12.0),
                                   child: Text('Share'),
                                 ),
                               ],
                             ),
                           ),
                           PopupMenuItem<int>(
                             value: 2,
                             child: Row(
                               children: const [
                                 Icon(Icons.delete_forever),
                                 Padding(padding: EdgeInsets.only(left: 12.0),
                                   child: Text('Delete'),
                                 ),
                               ],
                             ),
                           ),
                         ],
                         child: const Icon(Icons.more_vert_sharp, color: Colors.white,size: 45,),
                       ),),
                   ],
                 ),
               );
             }
           },
         ),
       );
     }else{
       return Container();
     }
   } else{
     return SafeArea(
       child: LayoutBuilder(
         builder: (context,constrains) {
           if(constrains.maxWidth < 768) {
             return Container(
               padding:  const EdgeInsets.all(32),
               decoration:  BoxDecoration(
                 borderRadius: const BorderRadius.all(Radius.circular(20),
                 ),
                 image: DecorationImage(image: AssetImage(image1)),
               ),
               child: ListTile(title: Stack(
                 children: [
                   Column(
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             children: [
                               Text("${data1.BName}",
                                 style: const TextStyle(
                                   fontSize: 25,
                                   fontFamily: "Roboto",
                                   color: Colors.white,
                                 ),
                               ),
                               const SizedBox(height: 35),
                               Text("${data1.cardtypeSelected}",
                                 style: const TextStyle(
                                   fontSize: 1,
                                   fontFamily: "Roboto",
                                   color: Colors.white,
                                 ),
                               ),
                             ],
                           ),
                           Image.asset(icon,height: 60,alignment: Alignment.topRight),
                         ],
                       ),
                       const SizedBox(height: 70),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                             "${data1.Cno}",
                             style: const TextStyle(
                               fontFamily: "Roboto",
                               fontSize: 24,
                               color: Colors.white,
                             ),
                           ),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           Text(
                             "${data1.CardHolderName}",
                             style: const TextStyle(
                               fontFamily: "Roboto",
                               fontSize: 18,
                               color: Colors.white,
                             ),
                           ),
                           Text(
                             "${data1.Exdate}",
                             style: const TextStyle(
                               fontFamily: "Roboto",
                               fontSize: 18,
                               color: Colors.white,
                             ),
                           ),
                           PopupMenuButton<int>(
                             onSelected: (item) => onSelected1(context,item,data1),
                             itemBuilder: (context) => [
                               PopupMenuItem<int>(
                                 value: 0,
                                 child: Row(
                                   children: const [
                                     Icon(Icons.edit,),
                                     Padding(padding: EdgeInsets.only(left: 12.0),
                                       child: Text('update'),
                                     ),
                                   ],
                                 ),
                               ),
                               PopupMenuItem<int>(
                                 value: 1,
                                 child: Row(
                                   children: const [
                                     Icon(Icons.share,color: Colors.black,),
                                     Padding(padding: EdgeInsets.only(left: 12.0),
                                       child: Text('Share'),
                                     ),
                                   ],
                                 ),
                               ),
                               PopupMenuItem<int>(
                                 value: 2,
                                 child: Row(
                                   children: const [
                                     Icon(Icons.delete_forever),
                                     Padding(padding: EdgeInsets.only(left: 12.0),
                                       child: Text('Delete'),
                                     ),
                                   ],
                                 ),
                               ),
                             ],
                             child: const Icon(Icons.more_vert_sharp, color: Colors.white,size: 25,),
                           )
                         ],
                       ),
                       SizedBox(height: 10,)
                     ],
                   ),
                 ],
               ),
                 onTap: () {
                   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>  CardDetails(data1)),(route) => false);
                 },
               ),
             );
           } else {
             return Container(
               padding:  const EdgeInsets.all(100),
               decoration:  BoxDecoration(
                 borderRadius: const BorderRadius.all(Radius.circular(20),
                 ),
                 image: DecorationImage(image: AssetImage(image1)),
               ),
               child: ListTile(title: Stack(
                 children: [
                   Column(children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Column(
                           children: [
                             Text("${data1.BName}",
                               style: const TextStyle(
                                 fontSize: 25,
                                 fontFamily: "Roboto",
                                 color: Colors.white,
                               ),
                             ),
                             const SizedBox(height: 100),
                             Text("${data1.cardtypeSelected}",
                               style: const TextStyle(
                                 fontSize: 1,
                                 fontFamily: "Roboto",
                                 color: Colors.white,
                               ),
                             ),
                           ],
                         ),
                         Image.asset(icon,height: 120,alignment: Alignment.topRight),
                       ],
                     ),
                     const SizedBox(height: 100),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(
                           "${data1.Cno}",
                           style: const TextStyle(
                             fontFamily: "Roboto",
                             fontSize: 45,
                             color: Colors.white,
                           ),
                         ),
                       ],
                     ),
                     const SizedBox(height: 25),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(
                           "${data1.CardHolderName}",
                           style: const TextStyle(
                             fontFamily: "Roboto",
                             fontSize: 40,
                             color: Colors.white,
                           ),
                         ),
                         SizedBox(width: 20),
                         Text(
                           "${data1.Exdate}",
                           style: const TextStyle(
                             fontFamily: "Roboto",
                             fontSize: 30,
                             color: Colors.white,
                           ),
                         ),
                         // SizedBox(width: 50,),
                       ],
                     ),
                   ],
                   ),
                   Positioned(height: 666,
                     left: 595,
                     child: PopupMenuButton<int>(
                       onSelected: (item) => onSelected1(context,item,data1),
                       itemBuilder: (context) => [
                         PopupMenuItem<int>(
                           value: 0,
                           child: Row(
                             children: const [
                               Icon(Icons.edit,),
                               Padding(padding: EdgeInsets.only(left: 12.0),
                                 child: Text('update'),
                               ),
                             ],
                           ),
                         ),
                         PopupMenuItem<int>(
                           value: 1,
                           child: Row(
                             children: const [
                               Icon(Icons.share,color: Colors.black,),
                               Padding(padding: EdgeInsets.only(left: 12.0),
                                 child: Text('Share'),
                               ),
                             ],
                           ),
                         ),
                         PopupMenuItem<int>(
                           value: 2,
                           child: Row(
                             children: const [
                               Icon(Icons.delete_forever),
                               Padding(padding: EdgeInsets.only(left: 12.0),
                                 child: Text('Delete'),
                               ),
                             ],
                           ),
                         ),
                       ],
                       child: const Icon(Icons.more_vert_sharp, color: Colors.white,size: 45,),
                     ),),
                 ],
               ),
                 onTap: () {
                   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>  CardDetails(data1)),(route) => false);
                 },
               ),
             );
           }
         },
       ),
     );
   }
 } else {
   return Container();
 }
  }

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
 _BankView() {
   return  SafeArea(
     minimum: EdgeInsets.symmetric(horizontal: 10),
     child: FutureBuilder(
       future: SqfliteDatabase().fetchData(),
       builder: (BuildContext context,AsyncSnapshot<List<SqfliteDbModel>> snapshot) {
         if(snapshot.hasData) {
           return PageView.builder(
             scrollDirection: Axis.horizontal,
             itemCount: snapshot.data!.length,
             itemBuilder: (ctx,index) {
               return Column(
                 children: [
                  Center(child: _ListItem(snapshot.data![index],context),),
                 ],
               );
             },
           );
         } else {
           return const Center(
             child: Text('No Data Found'),
           );
         }return Container();
       },
     ),
   );
 }

  _CardView() {
   return SafeArea(
      minimum: EdgeInsets.symmetric(vertical: 220,horizontal: 5),
      child: FutureBuilder(
        future: SqfliteDatabase().fetchdata1(),
        builder: (BuildContext context,AsyncSnapshot<List<SqfliteDbModel1>> snapshot) {
          if(snapshot.hasData) {
            return PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context,index) {
                  String icons = '';
                  String image1;
                  image1 =  'assets/creditcard1.png';
                  if(snapshot.data![index].card1Selected == "Visa"){
                    icons = 'assets/visa.png';
                  }else if(snapshot.data![index].card1Selected == "Master Card"){
                    icons = 'assets/mastercard.png';
                  } else if(snapshot.data![index].card1Selected == "Discover") {
                    icons = 'assets/discover.png';
                  } else if(snapshot.data![index].card1Selected == "American Express") {
                    icons = 'assets/americanexpress.png';
                  }

                  if(snapshot.data![index].cardtypeSelected == "Credit Card"){
                    image1 = 'assets/creditcard1.png';
                  }else{
                    image1 = 'assets/debitcard2.png';
                  }
                  return Column(
                    children: [
                      Center(child: _GenerateCard(snapshot.data![index],icons,image1,context,CardType),),
                    ],
                  );
                });
          } else {
            return const Center(
              child: Text('No Data Found'),
            );
          }
        },
      ),
    );
  }


}