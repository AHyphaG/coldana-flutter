import '../../domain/entities/expense_response.dart';
import '../../domain/repositories/expense_repository.dart';
import '../datasources/expense_remote_data_source.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseRemoteDataSource remoteDataSource;

  ExpenseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ExpenseResponse> getExpensesForDate(String date) async {
    return await remoteDataSource.getExpensesForDate(date);
  }
}
