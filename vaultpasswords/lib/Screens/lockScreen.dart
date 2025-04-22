import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vaultpasswords/Controller/sqliteConnect.dart';
import 'package:vaultpasswords/Screens/MainMenu.dart';

sqliteConnect? s1Global;
// Future<Database>? dbGlobal;
class Lockscreen extends StatefulWidget {
  Lockscreen(sqliteConnect inputObj){s1Global = inputObj;}
  @override
  State<Lockscreen> createState() => _LockscreenState();
}

class _LockscreenState extends State<Lockscreen> {
  late final TextEditingController _passwordController;
  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF1C2731),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                'Vault',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _passwordController,
                style: const TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF2A3B48),
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Colors.white60),
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () async  {
                  final password = _passwordController.text;
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your password')),
      );
    }else{
      print(_passwordController.value.toString() + " : " );
      bool result = await s1Global!.checkUser(_passwordController.text);
      print(result);
      if(result == true){
      Navigator.push(context,MaterialPageRoute(
      builder: (context)=>MainMenu(),));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password is incorrect')),
      
      );
      }
    }
                },
                child: const Text(
                  'Proceed',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00B7FF),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}