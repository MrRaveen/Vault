import 'package:flutter/material.dart';
import 'package:vaultpasswords/Controller/deletePassword.dart';
import 'package:vaultpasswords/Controller/getAllProcess.dart';
import 'package:vaultpasswords/Models/Passwords.dart';
import 'package:vaultpasswords/Screens/MainMenu.dart';
import 'package:vaultpasswords/Screens/updateScreen.dart';

class AllPasswords extends StatefulWidget{
  @override
   State<AllPasswords> createState() => _AllPasswords();
}
class _AllPasswords extends State<AllPasswords>{
 // int count = 0;
 bool progressStatus = true;
  List<String>allID = [];
  List<String>allLinks = [];
  List<String>allNames = [];
  List<String>allPassword = [];
  //temp data
   List<String> tempIDs = [];
      List<String> tempLinks = [];
      List<String> tempNames = [];
      List<String> tempPasswords = [];
  @override
  void initState() {
  super.initState();
  getAllProcess passObj = getAllProcess();
  
  passObj.getAllPassword().then((List<Passwords>? passwordList) {
    if (passwordList != null && passwordList.isNotEmpty) {
      setState(() {progressStatus = false;});
      for (var password in passwordList) {
        print(password.Link);
         tempIDs.add(password.id);
          tempLinks.add(password.Link);
          tempNames.add(password.Name);
          tempPasswords.add(password.Password);  
      }
      setState(() {
        allID = tempIDs;
        allLinks = tempLinks;
        allNames = tempNames;
        allPassword = tempPasswords;
        progressStatus = false;
      });
    }
  }).catchError((error) {
    print("Error fetching passwords: $error");
  });
}
  Widget _buildDetailRow({required IconData icon, required String label, required String value}) {
  return Row(
    children: [
      Icon(icon, color: Colors.indigo.shade400, size: 22),
      SizedBox(width: 12),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.indigo.shade800,
            ),
          ),
        ],
      ),
    ],
  );
}
Widget _buildActionButton({required IconData icon, required String label, required Color color, required VoidCallback onPressed}) {
  return TextButton.icon(
    icon: Icon(icon, color: color, size: 20),
    label: Text(
      label,
      style: TextStyle(color: color),
    ),
    onPressed: onPressed,
    style: TextButton.styleFrom(
      backgroundColor: color.withOpacity(0.1),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: RefreshIndicator(
      child: SafeArea(
      child: progressStatus
      ? Center(child: CircularProgressIndicator(),)
      :  ListView.builder(
        itemCount: allID.length,
        itemBuilder: (context,count){
          if(allID.isEmpty){
            return Container(

            );
          }else{
             return Card(
  elevation: 4,
  child: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(Icons.lock, color: Colors.indigo, size: 28),
              SizedBox(width: 12),
              Text(
                "Password Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Information Section
          _buildDetailRow(
            icon: Icons.person,
            label: "Description",
            value: allLinks[count],
          ),
          Divider(height: 24, color: Colors.grey.shade300),
          
          _buildDetailRow(
            icon: Icons.alternate_email,
            label: "Username",
            value: allNames[count],
          ),
          Divider(height: 24, color: Colors.grey.shade300),
           _buildDetailRow(
            icon: Icons.password_rounded,
            label: "Password",
            value: allPassword[count],
          ),
          Divider(height: 24, color: Colors.grey.shade300),
          //_buildPasswordField(),
          SizedBox(height: 20),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionButton(
                icon: Icons.content_copy,
                label: "Copy",
                color: Colors.blue,
                onPressed: () {},
              ),
              _buildActionButton(
                icon: Icons.edit,
                label: "Edit",
                color: Colors.green,
                onPressed: () {
                        Navigator.push(context,MaterialPageRoute(
                        
                        builder: (context)=>BeautifulForm(allLinks[count],allNames[count],allPassword[count],allID[count])
                        
                        ));
                },
              ),
              _buildActionButton(
                icon: Icons.delete,
                label: "Delete",
                color: Colors.red,
                onPressed: () async {
                  //process
                  Deletepassword deleteObj = new Deletepassword();
                  bool result = await deleteObj.removeByID(allID[count]);
                  if(result == true){
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password deleted')),
                    );
                    Navigator.push(context,MaterialPageRoute(
      builder: (context)=>MainMenu(),));
                  }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Error occured when deleteing')),
                    );
                    AllPasswords();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    ),
  ),
   );
          }
        },
      ),
    ),
    onRefresh: () {
    return Future.delayed(
      Duration(seconds: 1),
      () {
          Navigator.push(context,MaterialPageRoute(
      builder: (context)=>MainMenu(),));
      },
    );
  },
    )
    );
  }
}