import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
class ConnectivityHelper {
  Future<bool> checkConn() async {
    try {
  final result = await InternetAddress.lookup('google.com');
  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    return true;
  }else{
    return false;
  }
  } on SocketException catch (_) {
    return false;
  }
  }
}