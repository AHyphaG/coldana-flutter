import 'package:equatable/equatable.dart';
import 'expense.dart';

class ExpenseResponse extends Equatable {
  final String date;
  final List<Expense> expenses;

  const ExpenseResponse({
    required this.date,
    required this.expenses,
  });

  @override
  List<Object> get props => [date, expenses];
}
