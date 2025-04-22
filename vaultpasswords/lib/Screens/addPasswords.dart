import 'package:flutter/material.dart';
import 'package:vaultpasswords/Controller/ConnectivityHelper.dart';
import 'package:vaultpasswords/Controller/SaveNewPass.dart';
import 'package:vaultpasswords/Controller/updateFun.dart';
import 'package:vaultpasswords/Screens/MainMenu.dart';
class Addpasswords extends StatefulWidget {
  @override
  _AddpasswordsState createState() => _AddpasswordsState();
}

class _AddpasswordsState extends State<Addpasswords> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Card(
            elevation: 8,
            child:  Padding(
              padding: EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add Details',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    SizedBox(height: 32),
                    _buildTextField(
                      controller: _nameController,
                      label: "Description",
                      icon: Icons.description,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Description is empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    _buildTextField(
                      controller: _emailController,
                      label: "User name",
                      icon: Icons.supervised_user_circle_rounded,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'User name is empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    _buildTextField(
                      controller: _passwordController,
                      label: "Password",
                      icon: Icons.lock_outline,
                      obscureText: true,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a password';
                        }
                        if (value!.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32),
                    _isLoading 
                        ? CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                ConnectivityHelper obj1 = new ConnectivityHelper();
                                var result = obj1.checkConn();
                                if(result == true){
                                   try{
      if (_emailController.text!="" && _nameController.text!="" && _passwordController.text!="") {
      setState(() => _isLoading = true);
      Savenewpass s1 = new Savenewpass();
      var result = await s1.addNewData(_nameController.text,_emailController.text,_passwordController.text);
      if(result == true){
            ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password added'),
          backgroundColor: Colors.green,
        ),
      );
      }else{
            ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error occured when saving data'),
          backgroundColor: const Color.fromARGB(255, 180, 60, 60),
        ),
      );
      }
      setState(() => _isLoading = false);
      _clearForm();
    }else{
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text("Fill all the values"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                // Perform action
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    }
                                }catch(e){
                                  
        throw new Exception('Error occured in update screen' + e.toString());
                                }
                                }else{
                                    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No internet Connection"),
          content: Text("Check your connection & try again"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                // Perform action
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
                                }
                              },
                              child: Text(
                                'Add',
                                style: TextStyle(fontSize: 16,color: const Color.fromARGB(255, 255, 255, 255)),
                              ),
                                style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                                ),
                            ),
                            ),
                            SizedBox(height: 16,),
                            TextButton(
                      onPressed: _clearForm,
                      child: Text(
                        'Clear Form',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold),
                      ),
                    ),
                            ]),
                ),
              ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.indigo),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.indigo, width: 2),
        ),
    ));
  }

  void _submitForm() async {
    // if (_emailController.text!="" && _nameController.text!="" && _passwordController.text!="") {
    //   setState(() => _isLoading = true);
    //   Updatefun updateObj = new Updatefun();
    //   Future<bool>?result;
    //   if(Link!=null && Name!=null && Password!=null && ID!=null){
    //     result = updateObj.updateByID(Link!, Name!, Password!, ID!);
    //   }
    //   await Future.delayed(Duration(seconds: 2));
    //   setState(() => _isLoading = false);
    //   if(result == true){
    //           ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Updated'),
    //       backgroundColor: Colors.green,
    //     ),
    //   );
    //   }else{
    //           ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Error occured when updating'),
    //       backgroundColor: Colors.green,
    //     ),
    //   );
    //   }
    //   _clearForm();
    // }else{

    // }
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}