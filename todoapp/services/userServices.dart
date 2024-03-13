import 'dart:convert';

import 'package:dio/dio.dart';

class NetworkService {
  late final Dio _dio;
  final JsonEncoder _encoder = JsonEncoder();

  static final NetworkService _instance = NetworkService.internal();

  // Replace this with your actual base URL
  static const String baseUrl = 'http://your-api-url.com';

  NetworkService.internal();

  static NetworkService get instance => _instance;

  Future<void> initClient() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: 60000),
        receiveTimeout: Duration(milliseconds: 60000),
      ),
    );
    // A place for interceptors. For example, for authentication and logging
  }

  Future<dynamic> registerUser(String name, String username, String email, String password) async {
    try {
      final response = await _dio.post(
        '$baseUrl/register',
        data: _encoder.convert({
          'name': name,
          'username': username,
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
}
