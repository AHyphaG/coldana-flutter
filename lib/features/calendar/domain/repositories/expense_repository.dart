import '../entities/expense_response.dart';

abstract class ExpenseRepository {
  // Future<ExpenseResponse> getExpensesForDate(String date);
  Future<List<ExpenseResponse>> getExpensesForDateRange(
    String startDate,
    String endDate,
  );

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

  Future<void> addOtherExpense({
    required String id,
    required String description,
    required double amount,
    required String date,
  });
}
