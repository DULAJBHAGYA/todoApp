import 'dart:convert'; // Import the dart:convert library for JsonEncoder

import 'package:dio/dio.dart';

class TaskService {
  late final Dio _dio;
  final JsonEncoder _encoder = JsonEncoder(); // Use JsonEncoder without const

  static final TaskService _instance = TaskService.internal();

  // Replace this with your actual base URL
  static const String baseUrl = 'http://192.168.1.12:8065';

  TaskService.internal();

  static TaskService get instance => _instance;

  Future<void> initClient() async {
  _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(milliseconds: 60000), // Convert seconds to milliseconds (60 seconds)
      receiveTimeout: Duration(milliseconds: 60000), // Convert seconds to milliseconds (60 seconds)
    ),
  );
  // A place for interceptors. For example, for authentication and logging
}

  Future<dynamic> createTask(String taskName, DateTime dateTime) async {
    try {
      final response = await _dio.post(
        '$baseUrl/users/tasks',
        data: _encoder.convert({'name': taskName, 'dateTime': dateTime.toString()}),
      );
      return response.data;
    } on DioError catch (e) {
      throw Exception(e.response?.data['detail'] ?? e.toString());
    } catch (e) {
      rethrow;
    }
  }

 Future<List<dynamic>> getTasks(String username) async {
  try {
    final response = await _dio.get('$baseUrl/tasks/$username');
    return response.data;
  } on DioError catch (e) {
    throw Exception(e.response?.data['detail'] ?? e.toString());
  } catch (e) {
    rethrow;
  }
}


  Future<dynamic> updateTask(int taskId, String taskName, DateTime dateTime) async {
    try {
      final response = await _dio.patch(
        '$baseUrl/tasks/$taskId',
        data: _encoder.convert({'name': taskName, 'dateTime': dateTime.toString()}),
      );
      return response.data;
    } on DioError catch (e) {
      throw Exception(e.response?.data['detail'] ?? e.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask(int taskId) async {
    try {
      final response = await _dio.delete('$baseUrl/tasks/$taskId');
      return response.data;
    } on DioError catch (e) {
      throw Exception(e.response?.data['detail'] ?? e.toString());
    } catch (e) {
      rethrow;
    }
  }
}
