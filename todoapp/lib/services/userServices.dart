import 'dart:convert';
import 'package:dio/dio.dart';

import 'user.dart';

class NetworkService {
  late final Dio _dio;
  final JsonEncoder _encoder = JsonEncoder();

  static final NetworkService _instance = NetworkService._internal();

  static const String baseUrl = 'http://192.168.1.12:8066';

  NetworkService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: 60000),
        receiveTimeout: Duration(milliseconds: 60000),
      ),
    );
    // Initialize any interceptors or other configurations here if needed
  }

  static NetworkService get instance => _instance;

Future<dynamic> registerUser(String Name, String UserName, String Email,
    String Password, String ConfirmedPassword) async {
  try {
    final response = await _dio.post(
      '$baseUrl/users',
      data: _encoder.convert({
        'name': Name,
        'username': UserName,
        'email': Email,
        'password': Password,
        'confirmedPassword': ConfirmedPassword,
      }),
    );

    // Check if the response status code indicates success
    if (response.statusCode == 200) {
      // Parse the JSON response into a User object
      return User.fromJson(response.data);
    } else {
      // If the response status code indicates an error, throw an exception with the status code and message
      throw Exception('Registration failed: ${response.statusCode} ${response.statusMessage}');
    }
  } on DioError catch (e) {
    // Handle Dio errors
    throw Exception(
      e.response?.data['detail'] is String
          ? e.response!.data['detail']
          : e.response?.data['detail'].toString() ?? e.toString(),
    );
  } catch (e) {
    // Handle other exceptions
    rethrow;
  }
}




  Future<dynamic> loginUser(String email, String password) async {
    try {
      final response = await _dio.post(
        '$baseUrl/login',
        data: _encoder.convert({
          'email': email,
          'password': password,
        }),
      );
      return response.data;
    } on DioError catch (e) {
      throw Exception(e.response?.data['detail'] ?? e.toString());
    } catch (e) {
      rethrow;
    }
  }

  // Initialize the Dio client
  Future<void> initClient() async {
    _dio.interceptors.add(
      // Add any interceptors if needed
      InterceptorsWrapper(onRequest: (options, handler) {
        // Modify requests here if needed
        return handler.next(options);
      }),
    );
  }

  // Other methods...
}
