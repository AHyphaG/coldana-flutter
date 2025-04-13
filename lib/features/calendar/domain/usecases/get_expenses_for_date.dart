import '../entities/expense_response.dart';
import '../repositories/expense_repository.dart';

class GetExpensesForDate {
  final ExpenseRepository repository;

  GetExpensesForDate(this.repository);

  Future<ExpenseResponse> execute(String date) async {
    return await repository.getExpensesForDate(date);
  }
}
