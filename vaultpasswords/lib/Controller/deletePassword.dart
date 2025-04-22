import 'package:dio/dio.dart';

enum DioMethod { post, get, put, delete }
final String baseUrl = 'http://192.168.188.42:3000'; //the Main URL 
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
          response = await _dio.post(endpoint);
          break;
        case DioMethod.get:
          response = await _dio.get(endpoint);
          break;
        case DioMethod.put:
          response = await _dio.put(endpoint);
          break;
        case DioMethod.delete:
          response = await _dio.delete(endpoint,data: formData);
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
class Deletepassword {
  Future<bool>removeByID(String id) async {
  try{
        final response = await APIService.instance.request(
        '/Access/deletePassword',
        DioMethod.delete,
        contentType: Headers.jsonContentType,
        formData: {'Id':id},
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return true;
      } else {
         return false;
      }
      }catch(e){
        throw new Exception('Error occured in deleteProcess controller' + e.toString());
      }
  }
}