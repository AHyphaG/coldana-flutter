import '../repositories/expense_repository.dart';
class UpdateExpense {
  final ExpenseRepository repository;
  
  UpdateExpense(this.repository);
  
  Future<void> execute({
    required String categoryId,
    required double amount,
    required String date,
  }) async {
    return await repository.updateExpense(
      categoryId: categoryId,
      amount: amount,
      date: date,
    );
  }
}