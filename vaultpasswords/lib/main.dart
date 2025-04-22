import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vaultpasswords/Controller/sqliteConnect.dart';
import 'package:vaultpasswords/Screens/lockScreen.dart';

sqliteConnect s1 = new sqliteConnect();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // Future<Database> db = s1.openMyDatabase();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Lockscreen(s1),
    );
  }
}
