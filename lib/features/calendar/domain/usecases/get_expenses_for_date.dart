import '../entities/expense_response.dart';
import '../repositories/expense_repository.dart';

// class GetExpensesForDate {
//   final ExpenseRepository repository;

//   GetExpensesForDate(this.repository);

//   Future<ExpenseResponse> execute(String date) async {
//     return await repository.getExpensesForDate(date);
//   }
// }

class GetMonthExpenses {
  final ExpenseRepository repository;
  GetMonthExpenses(this.repository);

  Future<List<ExpenseResponse>> execute(
    String startDate,
    String endDate,
  ) async {
    return await repository.getExpensesForDateRange(startDate, endDate);
  }
}
