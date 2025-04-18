import 'package:coldana_flutter/features/calendar/domain/entities/other_expense.dart';
import 'package:equatable/equatable.dart';
import 'expense.dart';

class ExpenseResponse extends Equatable {
  final String date;
  final List<Expense> expenses;
  final List<OtherExpense> otherExpenses;

  const ExpenseResponse({
    required this.date,
    required this.expenses,
    required this.otherExpenses,
  });

  @override
  List<Object> get props => [date, expenses, otherExpenses];
}
