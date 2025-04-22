import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:vaultpasswords/Models/Passwords.dart';

enum DioMethod { post, get, put, delete }
final String baseUrl = 'http://192.168.188.42:3000';  
//final String baseUrl = 'http://192.168.43.42:3000'; 
class APIService {
    Dio _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
  APIService._singleton();
  static final APIService instance = APIService._singleton();
  // Initialize Dio in the constructor
  APIService._() {
    
  }

  Future<Response> request(
    String endpoint,
    DioMethod method, {
    String? contentType,
    dynamic formData,
  }) async {
    try {
      late Response response;
      
      switch (method) {
        case DioMethod.post:
          response = await _dio.post(endpoint);
          break;
        case DioMethod.get:
          response = await _dio.get(endpoint);
          break;
        case DioMethod.put:
          response = await _dio.put(endpoint);
          break;
        case DioMethod.delete:
          response = await _dio.delete(endpoint);
          break;
      }
      
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Connection timeout');
      case DioExceptionType.sendTimeout:
        return Exception('Send timeout');
      case DioExceptionType.receiveTimeout:
        return Exception('Receive timeout');
      case DioExceptionType.badResponse:
        return Exception('Bad response: ${e.response?.statusMessage}');
      case DioExceptionType.cancel:
        return Exception('Request cancelled');
      default:
        return Exception('Network error occurred');
    }
  }
}

class getAllProcess{
     Future<List<Passwords>?> getAllPassword() async {
      try{
        final response = await APIService.instance.request(
        '/Access/getAll',
        DioMethod.get,
        contentType: Headers.jsonContentType,
      );
      if (response.statusCode == 200) {
      //  print(response.data);
        List<dynamic> allPasswords = response.data;
        // allPasswords = jsonDecode(response.data);
        List<Passwords> allPassObject = [];
        for(var tempHolder in allPasswords){
          Passwords p1Obj = new Passwords();
          p1Obj.id = tempHolder["id"];
          p1Obj.Link = tempHolder['Link'];
          p1Obj.Name = tempHolder['Name'];
          p1Obj.Password = tempHolder['Password'];
          allPassObject.add(p1Obj);
        }
        return allPassObject;
      } else {
         print("Not Successed :: ");
          return null;
      }
      }catch(e){
        throw new Exception('Error occured in getAllProcess controller' + e.toString());
      }
     }

}