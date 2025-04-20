import 'dart:convert';
import 'package:coldana_flutter/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as client;

import '../models/expense_response_model.dart';

// Data source
abstract class ExpenseRemoteDataSource {
  Future<List<ExpenseResponseModel>> getExpensesForDateRange(String startDate, String endDate);

  Future<void> updateExpense({
    required String categoryId, 
    required double amount, 
    required String date,
  });

  Future<void> addExpense({
    required String categoryId,
    required double amount, 
    required String date,
  });
}

class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  final http.Client client;
  final String baseUrl;
  final AuthLocalDataSource authLocalDataSource;

  ExpenseRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
    required this.authLocalDataSource
  });
  
  @override
  Future<List<ExpenseResponseModel>> getExpensesForDateRange(String startDate, String endDate) async {
    try {
      final token = await authLocalDataSource.getToken(); // Get token from secure storage
      final response = await client.get(
        Uri.parse('${baseUrl}/api/calendar?start=${startDate}&end=${endDate}'),
        headers: {
          'Authorization': 'Bearer ${token}',
          'Content-Type': 'application/json'
        },
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => ExpenseResponseModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load expenses');
      }
    } catch (e) {
      throw Exception('Failed to fetch expenses: ${e}');
    }
  }


  @override
  Future<void> updateExpense({
    required String categoryId,
    required double amount,
    required String date,
  }) async {
    try {
      // final token = await _getAuthToken();
      final token = await authLocalDataSource.getToken();
      
      final response = await client.put(
        Uri.parse('${baseUrl}/api/calendar/expenses'),
        headers: {
          'Authorization': 'Bearer ${token}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'categoryId': categoryId,
          'amount': amount,
          'date': date,
        }),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to update expense: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating expense: $e');
    }
  }

  @override
  Future<void> addExpense({
    required String categoryId,
    required double amount,
    required String date,
  }) async {
    try {
      final token = await authLocalDataSource.getToken();
      
      final response = await client.post(
        Uri.parse('${baseUrl}/api/calendar/expenses'),
        headers: {
          'Authorization': 'Bearer ${token}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'categoryId': categoryId,
          'amount': amount,
          'date': date,
        }),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Failed to update expense: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating expense: $e');
    }
  }

}
