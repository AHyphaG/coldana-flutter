import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as client;

import '../models/expense_response_model.dart';

// abstract class ExpenseRemoteDataSource {
//   Future<ExpenseResponseModel> getExpensesForDate(String date);
// }

// class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
//   final http.Client client;
//   final String baseUrl;

//   ExpenseRemoteDataSourceImpl({
//     required this.client,
//     required this.baseUrl,
//   });

//   @override
//   Future<ExpenseResponseModel> getExpensesForDate(String date) async {
//     try {
//       final response = await client.get(
//         Uri.parse('$baseUrl/expenses?date=$date'),
//         headers: {'Content-Type': 'application/json'},
//       );
      
//       // // Mock implementation for development
//       // await Future.delayed(Duration(milliseconds: 500));
      
//       // final mockResponse = {
//       //   "date": date,
//       //   "expenses": [
//       //     {
//       //       "amount": null,
//       //       "categoryName": "sarapan",
//       //       "categoryId": "29",
//       //       "hasExpensed": false
//       //     },
//       //     {
//       //       "amount": null,
//       //       "categoryName": "makansiang",
//       //       "categoryId": "30",
//       //       "hasExpensed": false
//       //     },
//       //     {
//       //       "amount": null,
//       //       "categoryName": "makanmalam",
//       //       "categoryId": "31",
//       //       "hasExpensed": false
//       //     }
//       //   ],
//       //   "other_expenses": [
//       //     {
//       //       "description": "Camel",
//       //       "amount": 29000
//       //     },
//       //     {
//       //       "description": "Mancis",
//       //       "amount": 5000
//       //     }
//       //   ]
//       // };
      
//       // return ExpenseResponseModel.fromJson(mockResponse);
      
//       if (response.statusCode == 200) {
//         return ExpenseResponseModel.fromJson(json.decode(response.body));
//       } else {
//         throw Exception('Failed to load expenses');
//       }
//     } catch (e) {
//       throw Exception('Failed to fetch expenses: $e');
//     }
//   }
// }

// Data source
abstract class ExpenseRemoteDataSource {
  Future<List<ExpenseResponseModel>> getExpensesForDateRange(String startDate, String endDate);
  Future<void> updateExpense({
    required String categoryId, 
    required double amount, 
    required String date,
  });

}

class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  ExpenseRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });
  
  @override
  Future<List<ExpenseResponseModel>> getExpensesForDateRange(String startDate, String endDate) async {
    try {
      // final token = await _getAuthToken(); // Get token from secure storage
      final token = "U";
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
      final token = "U";
      
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
  
}
