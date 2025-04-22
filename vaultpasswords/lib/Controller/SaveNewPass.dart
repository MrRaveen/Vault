import 'package:dio/dio.dart';

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
  APIService._singleton() {
    _dio.interceptors.add(LogInterceptor( // Add interceptor
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }
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
          response = await _dio.post(endpoint,data: formData);
          break;
        case DioMethod.get:
          response = await _dio.get(endpoint);
          break;
        case DioMethod.put:
          response = await _dio.put(endpoint,data: formData);
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

class Savenewpass {
  Future<bool> addNewData(String link,
     String name,
     String password) async {
    try {
      final response = await APIService.instance.request(
        '/Access/saveNew', // Update with your actual endpoint
        DioMethod.post,
        contentType: Headers.jsonContentType,
        formData: {
          'link': link,
          'name': name,
          'password': password,
        },
      );
      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print('Error saving new password: $e');
      return false;
    }
  }
}