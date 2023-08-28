// '>=3.0.3 <4.0.0'

// bottemnavigationbarp;
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final _pagesData = [
//     const FavoriteScreen(),
//     BankScreen(),
//     const CardScreen(),
//     SettingScreen(),
//   ];
//   int _selectedItem = 0;
//   @override
//   Widget build(BuildContext context) {
//        return Scaffold(
//          bottomNavigationBar: BottomNavigationBar(selectedLabelStyle: const TextStyle(height: 2,),
//                  fixedColor: Colors.cyan,
//                  items: const [
//                    BottomNavigationBarItem(
//                      icon: Icon(Icons.favorite,),
//                      label: "Home", backgroundColor: Colors.indigo,
//                    ),
//                    BottomNavigationBarItem(
//                      icon: Icon(FontAwesomeIcons.university),
//                      label: "Bank", backgroundColor: Colors.indigo,
//                    ),
//                    BottomNavigationBarItem(
//                      icon: Icon(Icons.card_membership),
//                      label: "Card", backgroundColor: Colors.indigo,
//                    ),
//                    BottomNavigationBarItem(
//                      icon: Icon(Icons.settings_applications_sharp),
//                      label: "Setting", backgroundColor: Colors.indigo,
//                    ),
//                  ],
//                  currentIndex: _selectedItem,
//                  onTap: (setValue) {
//                    setState(() {
//                      _selectedItem = setValue;
//                    });
//                  },
//                ),
//          body: Center(child: _pagesData[_selectedItem]),
//     );
//   }
// }

//change pin
// TextFormField(
//   controller: _pin,
//   keyboardType: TextInputType.number,
//   style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),
//   decoration: InputDecoration(
//     labelText: 'Pin',border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(20)),
//     counterText: '',
//   ),
//   validator: (value) {
//     if(value == null || value.isEmpty) {
//       return 'Please Enter pin';
//     } else if (value.length < 4) {
//       return 'Min length is 4';
//     }
//     return null;
//   },
//   maxLength: 4,
// ),
// const SizedBox(height: 20,),
// TextFormField(
//   controller: _ConPin,
//   keyboardType: TextInputType.number,
//   style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),
//   decoration: InputDecoration(
//     labelText: 'Conform Pin',border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(20)),
//     counterText: '',
//   ),
//   validator: (value) {
//     if(value == null || value.isEmpty) {
//       return 'Please Enter ConForm pin';
//     } else if (value != _pin.text) {
//       return 'PIN does not match';
//     }
//     return null;
//   },
//   maxLength: 4,
// ),

// class PINNumber extends StatelessWidget {
//   final TextEditingController textEditingController;
//   final OutlineInputBorder outlineInputBorder;
//   const PINNumber({Key? key,
//     required this.textEditingController,
//     required this.outlineInputBorder}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     // ignore: sized_box_for_whitespace
//     return Container(
//       width: 50.0,
//       child: TextFormField(
//         controller: textEditingController,
//         enabled: false,
//         obscureText: true,
//         textAlign: TextAlign.center,
//         decoration: InputDecoration(
//           contentPadding: const EdgeInsets.all(16.0),
//           border: outlineInputBorder,
//           filled: true,
//           fillColor: Colors.white30,
//         ),
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 21.0,
//           color: Colors.white,
//         ),
//         validator: (value) {
//           'SELECT * FROM _createpinTable WHERE pinone = value';
//           if(value == null || value.isEmpty) {
//             return 'Please Enter pin';
//           } else {
//             return 'PIN does not match';
//           }
//         },
//       ),
//     );
//   }
// }

//main.dart
// void _Type(String n) {
//   print(n);

  // if(mounted) {
  //   setState(() {
  //     Timer(const Duration(seconds: 0), () {
  //       if (Type == '0') {
  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (context) => MyHomePage()));
  //       } else if (Type == '1') {
  //         Navigator.pushReplacement(context,
  //             MaterialPageRoute(builder: (context) => const SetPinPage()));
  //       } else if (Type == '2') {
  //         Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(builder: (context) => const HomeView()));
  //       } else if(Type == "INSERT") {
  //         print('data is  insert');
  //         _insertSplashData(
  //             "0"
  //         );
  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (context) => MyHomePage()));
  //       }
  //     });
  //   });}

  //   print(Type);
  //   _Type(widget.data!.Type);
//}
// else {
//   _Type("INSERT");
// }

  // if (Type == '0') {
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => MyHomePage()));
  // } else if (Type == '1') {
  //   Navigator.pushReplacement(context,
  //       MaterialPageRoute(builder: (context) => const SetPinPage()));
  // } else if (Type == '2') {
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const HomeView()));
  // }
  // else if(Type == "INSERT") {
  //   print('data is  insert');
  //   _insertSplashData(
  //       "0"
  //   );
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => MyHomePage()));
  // }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: SafeArea(
//       child: FutureBuilder<List<SqliteDbModel3>>(
//         future: SqfliteDatabase().fetchdata3(),
//         builder: (BuildContext context, AsyncSnapshot<List<SqliteDbModel3>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // Show a loading indicator while fetching data
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             // Handle any errors that occurred during data fetching
//             return Text('Error: ${snapshot.error}');
//           } else {
//             // Data fetched successfully
//             List<SqliteDbModel3> dataList = snapshot.data;
//
//             // Assume that the Type variable is available and properly defined
//             int type = Type;
//
//             // Check the value of the Type variable and take appropriate actions
//             if (type == 0) {
//               // Update data (replace this with your actual update function)
//               _updateData();
//               // Redirect to MyHomePage after updating
//               return FutureBuilder(
//                 future: Future.delayed(Duration(seconds: B)),
//                 builder: (context, snapshot) => MyHomePage(),
//               );
//             } else if (type == 1) {
//               // Redirect to SetPinPage
//               return SetPinPage();
//             } else if (type == 2) {
//               // Redirect to HomeView
//               return HomeView();
//             } else {
//               // Insert data (replace this with your actual insert function)
//               _insertSplashData(dataList);
//               // Redirect to MyHomePage after inserting
//               return FutureBuilder(
//                 future: Future.delayed(Duration(seconds: B)),
//                 builder: (context, snapshot) => MyHomePage(),
//               );
//             }
//           }
//         },
//       ),
//     ),
//   );
// }