// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:codersqund_bankmaster/Screens/settingscreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'bankscreen.dart';
import 'cardscreen.dart';
import 'favoritescreen.dart';
import '../provider/tab_provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TabProvider>(
        builder: (context, tabProvider, _) {
          return IndexedStack(
            index: tabProvider.selectedTab,
            children: [
              // Add your different pages here
               FavoriteScreen(),
               BankScreen(),
               CardScreen(),
              SettingScreen(),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer<TabProvider>(
        builder: (context, tabProvider,_) {
          return BottomNavigationBar(
            fixedColor: Colors.cyan,
            currentIndex: tabProvider.selectedTab,
            onTap: (index) {
              tabProvider.selectedTab = index;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite,),
                label: "Home", backgroundColor: Colors.indigo,
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.university),
                label: "Bank", backgroundColor: Colors.indigo,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_membership),
                label: "Card", backgroundColor: Colors.indigo,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_applications_sharp),
                label: "Setting", backgroundColor: Colors.indigo,
              ),
            ],
          );
        },
      ),
    );
  }
}