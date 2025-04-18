import '../entities/expense_response.dart';

abstract class ExpenseRepository {
  // Future<ExpenseResponse> getExpensesForDate(String date);
  Future<List<ExpenseResponse>> getExpensesForDateRange(String startDate, String endDate);
  Future<void> updateExpense({
    required String categoryId,
    required double amount,
    required String date,
  });
}
