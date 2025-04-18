import '../../domain/entities/expense_response.dart';
import '../../domain/repositories/expense_repository.dart';
import '../datasources/expense_remote_data_source.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseRemoteDataSource remoteDataSource;

  ExpenseRepositoryImpl({required this.remoteDataSource});

  // @override
  // Future<ExpenseResponse> getExpensesForDate(String date) async {
  //   return await remoteDataSource.getExpensesForDate(date);
  // }
  @override
  Future<List<ExpenseResponse>> getExpensesForDateRange(String startDate, String endDate) async {
    return await remoteDataSource.getExpensesForDateRange(startDate, endDate);
  }
  @override
  Future<void> updateExpense({
    required String categoryId,
    required double amount,
    required String date,
  }) async {
    return await remoteDataSource.updateExpense(
      categoryId: categoryId,
      amount: amount,
      date: date,
    );
  }
}
