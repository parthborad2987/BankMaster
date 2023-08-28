// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations, avoid_print, sized_box_for_whitespace, use_build_context_synchronously, prefer_const_constructors, prefer_typing_uninitialized_variables, unrelated_type_equality_checks, unused_local_variable, unnecessary_brace_in_string_interps, unnecessary_this, must_be_immutable, unused_field, prefer_final_fields, no_leading_underscores_for_local_identifiers

import 'package:codersqund_bankmaster/pages/card_detailscreen.dart';
import 'package:codersqund_bankmaster/pages/update_card_detail.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../LocalDatabase/SQl_database.dart';
import '../LocalDatabase/card_modal2.dart';
import '../LocalDatabase/card_model.dart';
import '../pages/add_card_detail.dart';
import 'home_screen.dart';

class CardScreen extends StatefulWidget {
  CardDbModel? data1;
    CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final cardtypeSelected = TextEditingController();

  bool isSelected1 = false;

  var Fav1;


  @override
  void initState() {
    if(widget.data1 != null) {
     Fav1 = widget.data1!.Fav1;
     widget.data1!.id;
     isSelected1 = widget.data1!.Fav1 as bool;
    }
    super.initState();
  }

  String CardType = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Card"),
        actions: [
          IconButton(
            onPressed:() => showSearch(context: context, delegate: Searchdata()),
            icon:  Icon(Icons.search),
          ),
          Container(
            width: 80,
            child: PopupMenuButton(
              onSelected: (value) {
                  if(value == 0) {
                    setState(() {
                      CardType = '0';
                    });
                  } else if (value == 1) {
                    setState(() {
                      CardType = '1';
                    });
                  } else if (value == 2){
                    setState(() {
                      CardType = '2';
                    });
                  }
                },
              itemBuilder: (context) =>
              [
                PopupMenuItem(
                  value: 0,
                  child: Text('All Card',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                PopupMenuItem(
                  value:  1,
                  child: Text('Credit Card',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                 PopupMenuItem(
                   value: 2,
                   child: Text('Debit Card',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ],
              child: const Icon(Icons.more_vert_sharp, color: Colors.white,size: 30,),
            ),)
        ],
      ),
      body: Padding(
    padding: const EdgeInsets.symmetric(
    horizontal: 5,
    ),
    child: _CardDetails(context, CardType),),
      floatingActionButton: FloatingActionButton(elevation: 12,
        heroTag: 2,
        onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCardDetails()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _CardDetails(BuildContext context,String CardType) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder(
          future: SqfliteDatabase().fetchdata1(),
          builder: (BuildContext context,AsyncSnapshot<List<SqfliteDbModel1>> snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context,index) {
                    // print(snapshot.data![index].card1Selected);
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
                        _GenerateCard(snapshot.data![index],icons,image1,context,CardType),
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
      ),
    );
  }

  Widget _GenerateCard(SqfliteDbModel1 data1,String icon,String image1,context,String Ctype) {
  bool iconcardType = false;
  try {
    // Trim whitespace and then parse the value
    int favValue = int.parse(data1.Fav1.trim());

    // Check if the parsed value is 1
    if (favValue == 1) {
      iconcardType = true;
    }
  } on FormatException {
    // Handle the case where parsing fails
    // This could be due to an invalid number format
    // Set a default value or perform other error handling
  }

    if(Ctype == '1'){
      if(data1.cardtypeSelected == "Credit Card"){
        return SafeArea(
          child: LayoutBuilder(
            builder: (context,constrains) {
              if(constrains.maxWidth < 768) {
                return  Container(
                  padding:  const EdgeInsets.all(32),
                  decoration:  BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20),
                    ),
                    image: DecorationImage(image: AssetImage(image1)),
                  ),
                  child: Stack(
                    children: [
                      ListTile(title:
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FavoriteButton(iconSize: 35,isFavorite: iconcardType,
                                  valueChanged: (isSelected1) {
                                    String id = data1.id;
                                    String Fav1 = data1.Fav1;
                                    if(Fav1 == '1') {
                                      Fav1 = '0';
                                      setState(() {
                                        isSelected1 = !isSelected1;
                                        updateCard(id,Fav1);
                                      });
                                    } else {
                                      Fav1 = '1';
                                      setState(() {
                                        isSelected1 = !isSelected1;
                                        updateCard(id,Fav1);
                                      });
                                    }print(Fav1);
                                  }),
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
                                onSelected: (item) => onSelected(context,item,data1),
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
                              ),
                            ],
                          ),
                        ],
                      ),
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>  CardDetails(data1)),(route) => false);
                        },
                      ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FavoriteButton(iconSize: 60,
                                valueChanged: (isSelected1) {
                                  String id = data1.id;
                                  String Fav1 = data1.Fav1;

                                  if(Fav1 == '1') {
                                    Fav1 = '0';
                                    setState(() {
                                      isSelected1 = !isSelected1;
                                      updateCard(id,Fav1);
                                    });
                                  } else {
                                    Fav1 = '1';
                                    setState(() {
                                      isSelected1 = !isSelected1;
                                      updateCard(id,Fav1);
                                    });
                                  }print(Fav1);
                                }),
                            Text(
                              "${data1.CardHolderName}",
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${data1.Exdate}",
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            PopupMenuButton<int>(
                              onSelected: (item) => onSelected(context,item,data1),
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
                            )
                          ],
                        ),
                      ],
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        );
      } else{
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FavoriteButton(iconSize: 35,isFavorite: iconcardType,
                                  valueChanged: (isSelected1) {
                                    String id = data1.id;
                                    String Fav1 = data1.Fav1;
                                    if(Fav1 == '1') {
                                      Fav1 = '0';
                                      setState(() {
                                        isSelected1 = !isSelected1;
                                        updateCard(id,Fav1);
                                      });
                                    } else {
                                      Fav1 = '1';
                                      setState(() {
                                        isSelected1 = !isSelected1;
                                        updateCard(id,Fav1);
                                      });
                                    }print(Fav1);
                                  }),
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
                                onSelected: (item) => onSelected(context,item,data1),
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
                              ),
                            ],
                          ),
                        ],
                      ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FavoriteButton(iconSize: 60,
                                valueChanged: (isSelected1) {
                                  String id = data1.id;
                                  String Fav1 = data1.Fav1;

                                  if(Fav1 == '1') {
                                    Fav1 = '0';
                                    setState(() {
                                      isSelected1 = !isSelected1;
                                      updateCard(id,Fav1);
                                    });
                                  } else {
                                    Fav1 = '1';
                                    setState(() {
                                      isSelected1 = !isSelected1;
                                      updateCard(id,Fav1);
                                    });
                                  }print(Fav1);
                                }),
                            Text(
                              "${data1.CardHolderName}",
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${data1.Exdate}",
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            PopupMenuButton<int>(
                              onSelected: (item) => onSelected(context,item,data1),
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
                            )
                          ],
                        ),
                      ],
                      ),
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
              return  Container(
                padding:  const EdgeInsets.all(32),
                decoration:  BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20),
                  ),
                  image: DecorationImage(image: AssetImage(image1)),
                ),
                child: Stack(
                  children: [
                    ListTile(title:
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FavoriteButton(iconSize: 35,isFavorite: iconcardType,
                                valueChanged: (isSelected1) {
                                  String id = data1.id;
                                  String Fav1 = data1.Fav1;
                                  if(Fav1 == '1') {
                                    Fav1 = '0';
                                    setState(() {
                                      isSelected1 = !isSelected1;
                                      updateCard(id,Fav1);
                                    });
                                  } else {
                                    Fav1 = '1';
                                    setState(() {
                                      isSelected1 = !isSelected1;
                                      updateCard(id,Fav1);
                                    });
                                  }print(Fav1);
                                }),
                            Text(
                              "${data1.CardHolderName}",
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Text(
                              "${data1.Exdate}",
                              style: const TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                             PopupMenuButton<int>(
                               onSelected: (item) => onSelected(context,item,data1),
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
                             ),
                          ],
                        ),
                      ],
                    ),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>  CardDetails(data1)),(route) => false);
                },
              ),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FavoriteButton(iconSize: 60,
                              valueChanged: (isSelected1) {
                                String id = data1.id;
                                String Fav1 = data1.Fav1;

                                if(Fav1 == '1') {
                                  Fav1 = '0';
                                  setState(() {
                                    isSelected1 = !isSelected1;
                                    updateCard(id,Fav1);
                                  });
                                } else {
                                  Fav1 = '1';
                                  setState(() {
                                    isSelected1 = !isSelected1;
                                    updateCard(id,Fav1);
                                  });
                                }print(Fav1);
                              }),
                          Text(
                            "${data1.CardHolderName}",
                            style: const TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${data1.Exdate}",
                            style: const TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          PopupMenuButton<int>(
                            onSelected: (item) => onSelected(context,item,data1),
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
                          )
                        ],
                      ),
                    ],
                    ),
                  ],
                ),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>  CardDetails(data1)),(route) => false);
                  },
                ),);
            }
          },
        ),
      );
    }
  }
}

void updateCard(String id,String Fav) async {
  CardDbModel data1 = CardDbModel(id: id, Fav1: Fav);
  await SqfliteDatabase().updateDataCard(data1);print(Fav);
}

@override
Widget _GenerateCard(SqfliteDbModel1 data1,String icon,String image1,context,String Ctype,toggleSelection,isSelected1) {
   if(Ctype == '1'){
    if(data1.cardtypeSelected == "Credit Card"){
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
                    SizedBox(height: 10,),
                    Positioned(height: 340,right: 282,
                      child: IconButton(
                        onPressed: toggleSelection,
                        icon: isSelected1 ? Icon(Icons.favorite,color: Colors.red) : Icon(Icons.favorite,color: Colors.white),
                      ),),
                    Positioned(height: 335,
                      left: 300,
                      child: PopupMenuButton<int>(
                        onSelected: (item) => onSelected(context,item,data1),
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
                        ],
                      ),
                    ],
                    ),
                    Positioned(height: 660,right: 595,
                      child: IconButton(
                        onPressed: toggleSelection,
                        icon: isSelected1 ? Icon(Icons.favorite,color: Colors.red) : Icon(Icons.favorite,color: Colors.white),
                      ),),
                    Positioned(height: 666,
                      left: 595,
                      child: PopupMenuButton<int>(
                        onSelected: (item) => onSelected(context,item,data1),
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
  }
   else if (Ctype == '2'){
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
                    SizedBox(height: 10,),
                    Positioned(height: 335,
                      left: 300,
                      child: PopupMenuButton<int>(
                        onSelected: (item) => onSelected(context,item,data1),
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
                        ],
                      ),
                    ],
                    ),
                    Positioned(height: 666,
                      left: 595,
                      child: PopupMenuButton<int>(
                        onSelected: (item) => onSelected(context,item,data1),
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
                  SizedBox(height: 10,),
                  Positioned(height: 335,
                    left: 300,
                    child: PopupMenuButton<int>(
                      onSelected: (item) => onSelected(context,item,data1),
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
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                  ),
                  Positioned(height: 666,
                    left: 595,
                    child: PopupMenuButton<int>(
                      onSelected: (item) => onSelected(context,item,data1),
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
  }

}

onSelected(context, int item,SqfliteDbModel1 data1) {
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

class Searchdata extends SearchDelegate {

  bool isSelected = false;

  void toggleSelection() {
      isSelected = !isSelected;
  }

   String CardType =  '0';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(onPressed: () {
        query = "";
      }, icon: const Icon(Icons.clear))];
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
   future: SqfliteDatabase().fetchdata1(),
    builder: (BuildContext context,AsyncSnapshot<List<SqfliteDbModel1>> snapshot) {
    if(snapshot.hasData) {
    return ListView.builder(
    padding: const EdgeInsets.all(10),
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
      if(snapshot.data![index].BName == query) {
        return _GenerateCard(snapshot.data![index],icons,image1,context,CardType,toggleSelection,isSelected);
      } else if (snapshot.data![index].BName.toLowerCase().contains(query.toLowerCase())) {
        return _GenerateCard(snapshot.data![index],icons,image1,context,CardType,toggleSelection,isSelected);
      } else {
        return Container();
      }
    }
    );
    }else {
      return Container();
      }
    }),
   );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: SqfliteDatabase().fetchdata1(),
          builder: (BuildContext context,AsyncSnapshot<List<SqfliteDbModel1>> snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                  padding: const EdgeInsets.all(10),
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

                    if(query == '') {
                     return _GenerateCard(snapshot.data![index],icons,image1,context,CardType,toggleSelection,isSelected);
                    } else if (snapshot.data![index].BName.toLowerCase().contains(query.toLowerCase())) {
                      return _GenerateCard(snapshot.data![index],icons,image1,context,CardType,toggleSelection,isSelected);
                    } else {
                      return Container();
                    }
                  }
              );
            }else {
              return const Center(
                child: Text('No Data Found'),
              );
            }
          }),
    );
  }
}

