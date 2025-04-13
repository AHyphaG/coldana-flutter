import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/expense_response_model.dart';

abstract class ExpenseRemoteDataSource {
  Future<ExpenseResponseModel> getExpensesForDate(String date);
}

class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  ExpenseRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<ExpenseResponseModel> getExpensesForDate(String date) async {
    try {
      // final response = await client.get(
      //   Uri.parse('$baseUrl/expenses?date=$date'),
      //   headers: {'Content-Type': 'application/json'},
      // );
      
      // Mock implementation for development
      await Future.delayed(Duration(milliseconds: 500));
      
      final mockResponse = {
        "date": date,
        "expenses": [
          {
            "amount": null,
            "categoryName": "sarapan",
            "categoryId": "29",
            "hasExpensed": false
          },
          {
            "amount": null,
            "categoryName": "makansiang",
            "categoryId": "30",
            "hasExpensed": false
          },
          {
            "amount": null,
            "categoryName": "makanmalam",
            "categoryId": "31",
            "hasExpensed": false
          }
        ]
      };
      
      return ExpenseResponseModel.fromJson(mockResponse);
      
      // if (response.statusCode == 200) {
      //   return ExpenseResponseModel.fromJson(json.decode(response.body));
      // } else {
      //   throw Exception('Failed to load expenses');
      // }
    } catch (e) {
      throw Exception('Failed to fetch expenses: $e');
    }
  }
}
