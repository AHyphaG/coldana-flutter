import '../entities/expense_response.dart';

abstract class ExpenseRepository {
  Future<ExpenseResponse> getExpensesForDate(String date);
}