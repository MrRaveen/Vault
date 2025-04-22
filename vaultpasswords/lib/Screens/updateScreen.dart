import 'package:flutter/material.dart';
import 'package:vaultpasswords/Controller/updateFun.dart';
import 'package:vaultpasswords/Screens/MainMenu.dart';

String? Link;
String? Name;
String? Password;
String? ID;
class BeautifulForm extends StatefulWidget {
  BeautifulForm(String link,String name,String password,String id){
    Link = link;
    Name = name;
    Password = password;
    ID = id;
  }
  @override
  _BeautifulFormState createState() => _BeautifulFormState();
}

class _BeautifulFormState extends State<BeautifulForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void initState() {
    _nameController.text = Link!;
    _emailController.text = Name!;
    _passwordController.text = Password!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Update password',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
      ),
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
                      'Update Details',
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
                                try{
                                                                  if (_emailController.text!="" && _nameController.text!="" && _passwordController.text!="") {
      setState(() => _isLoading = true);
      Updatefun updateObj = new Updatefun();
      bool result = false;
      var newLink = _nameController.text;
      var newName = _emailController.text;
      var newPass = _passwordController.text;
      if(newLink!=null && newName!=null && newPass!=null && ID!=null){
       result = await updateObj.updateByID(newLink, newName, newPass, ID!);
      }
      await Future.delayed(Duration(seconds: 2));
      setState(() => _isLoading = false);
      // print("Update screen status" + result.toString());
      if(result == true){
              ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Updated'),
          backgroundColor: Colors.green,
        ),
      );
       await Future.delayed(Duration(seconds: 2));
       Navigator.push(context,MaterialPageRoute(
        builder: (context)=> MainMenu(),           
        ));
      }else{
              ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error occured when updating'),
          backgroundColor: const Color.fromARGB(255, 180, 8, 8),
        ),
      );
      }
      _clearForm();
    }else{

    }
                                }catch(e){
                                  
        throw new Exception('Error occured in update screen' + e.toString());
                                }
                              },
                              child: Text(
                                'Update',
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