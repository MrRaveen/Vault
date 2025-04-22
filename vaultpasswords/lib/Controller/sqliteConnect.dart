import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class sqliteConnect {
  Future<Database> openMyDatabase() async {
    //test section
     final String? path = await getDatabasesPath();
     print('the path' + path!);
    return await openDatabase(
        join(await getDatabasesPath(), 'localData.db'),
        version: 1,
        onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE localAccounts(id INTEGER PRIMARY KEY AUTOINCREMENT, password TEXT)',
      );
    });
  }
  Future <bool> checkUser(String password) async {
     final db = await openMyDatabase();
    List<Map<String,dynamic>> result =  await db.query(
    'localAccounts', // Table name
    where: 'password = ?', // WHERE clause
    whereArgs: [password], // Arguments for the placeholders
  );
  bool resultCheck = false;
  for(var tempHolder in result){
    print(tempHolder['password']);
    if(tempHolder['password'] == password){
      resultCheck = true;
    }
  }
  return resultCheck;
  }
}
