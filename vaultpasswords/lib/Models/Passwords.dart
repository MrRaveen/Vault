import 'dart:io';

class Passwords {
  String? _id;
  String? _Link;
  String? _Name;
  String? _Password;
  String get id => this._id!;
  String get Link => this._Link!;
  String get Name => this._Name!;
  String get Password => this._Password!;
  set id(String id) => this._id = id;
  set Link(String Link) => this._Link = Link;
  set Name(String Name)=>this._Name = Name;
  set Password(String Password)=>this._Password = Password;
}