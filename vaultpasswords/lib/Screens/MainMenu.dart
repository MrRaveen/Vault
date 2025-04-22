import 'package:flutter/material.dart';
import 'package:vaultpasswords/Screens/AllPasswords.dart';
import 'package:vaultpasswords/Screens/addPasswords.dart';

class MainMenu extends StatefulWidget{
   @override
   State<MainMenu> createState() => _MainMenuState();
}
class _MainMenuState extends State<MainMenu>{
  int currentPageIndex = 0;
@override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color.fromARGB(255, 175, 176, 190),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.add_box_rounded)),
            label: 'Add',
          ),
        ],
      ),
      body: SafeArea(
        child:<Widget>[
            /// Home page
            AllPasswords(),
            /// Notifications page
            Addpasswords(),
          ][currentPageIndex],
      )
    );
  }
}