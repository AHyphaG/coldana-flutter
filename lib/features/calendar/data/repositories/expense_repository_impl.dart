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
  Future<List<ExpenseResponse>> getExpensesForDateRange(
    String startDate,
    String endDate,
  ) async {
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

  @override
  Future<void> addExpense({
    required String categoryId,
    required double amount,
    required String date,
  }) async {
    return await remoteDataSource.addExpense(
      categoryId: categoryId,
      amount: amount,
      date: date,
    );
  }

  @override
  Future<void> addOtherExpense({
    required String id,
    required String description,
    required double amount,
    required String date,
  }) async {
    return await remoteDataSource.addOtherExpense(
      id: id,
      description: description,
      amount: amount,
      date: date,
    );
  }
}
