import 'dart:convert'; // Import the dart:convert library for JsonEncoder

import 'package:dio/dio.dart';

class TaskService {
  late final Dio _dio;
  final JsonEncoder _encoder = JsonEncoder();

  static final TaskService _instance = TaskService.internal();

  static const String baseUrl = 'http://192.168.1.11:8065';

  TaskService.internal();

  static TaskService get instance => _instance;

  Future<void> initClient(String token) async {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: 60000),
        receiveTimeout: Duration(milliseconds: 60000),
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
  }

  Future<void> createTask(String taskName, DateTime dateTime) async {
    try {
      final response = await _dio.post(
        '$baseUrl/users/tasks',
        data: {'name': taskName},
      );
      return response.data;
    } on DioError catch (e) {
      throw Exception(e.response?.data['detail'] ?? e.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> getTasks(String username, String token) async {
    try {
      final response = await _dio.get(
        '$baseUrl/tasks',
        queryParameters: {'username': username},
      );
      return response.data;
    } on DioError catch (e) {
      throw Exception(e.response?.data['detail'] ?? e.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateTask(
      int taskId, String taskName, DateTime dateTime) async {
    try {
      final response = await _dio.patch(
        '$baseUrl/users/tasks/$taskId',
        data: _encoder
            .convert({'name': taskName, 'dateTime': dateTime.toString()}),
      );
      return response.data;
    } on DioError catch (e) {
      throw Exception(e.response?.data['detail'] ?? e.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteTask(int index, int taskId) async {
    try {
      final response = await _dio.delete('$baseUrl/tasks/$taskId');
      if (response.statusCode == 200) {
        // Task deleted successfully.
        return true;
      } else if (response.statusCode == 404) {
        // Task not found.
        return false;
      } else {
        final responseData = response.data;
        if (responseData != null && responseData['detail'] != null) {
          throw Exception(responseData['detail'].int.parse(taskId));
        } else {
          throw Exception('Failed to delete task: ${response.statusCode}');
        }
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data['detail'] ?? e.toString());
    } catch (e) {
      rethrow;
    }
  }
}
