import 'package:coldana_flutter/features/calendar/domain/repositories/expense_repository.dart';

class AddCategoryExpense {
  final ExpenseRepository repository;

  AddCategoryExpense(this.repository);

  Future<void> execute({
    required String categoryId,
    required double amount,
    required String date,
  }) async {
    return await repository.addExpense(
      categoryId: categoryId,
      amount: amount,
      date: date,
    );
  }
}