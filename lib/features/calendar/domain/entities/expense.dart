import 'package:equatable/equatable.dart';

class Expense extends Equatable {
  final double? amount;
  final String categoryName;
  final String categoryId;
  final bool hasExpensed;

  const Expense({
    this.amount,
    required this.categoryName,
    required this.categoryId,
    required this.hasExpensed,
  });

  @override
  List<Object?> get props => [amount, categoryName, categoryId, hasExpensed];
}
