import 'package:coldana_flutter/features/calendar/domain/repositories/expense_repository.dart';

class AddOtherExpense {
  final ExpenseRepository repository;
  AddOtherExpense(this.repository);

  Future<void> execute({
    required String id,
    required String description,
    required double amount,
    required String date,
  }) async {
    return await repository.addOtherExpense(
      id: id,
      description: description,
      amount: amount,
      date: date,
    );
  }
}
