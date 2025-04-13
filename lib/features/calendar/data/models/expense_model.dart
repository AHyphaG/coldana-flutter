import '../../domain/entities/expense.dart';

class ExpenseModel extends Expense {
  const ExpenseModel({
    required double? amount,
    required String categoryName,
    required String categoryId,
    required bool hasExpensed,
  }) : super(
          amount: amount,
          categoryName: categoryName,
          categoryId: categoryId,
          hasExpensed: hasExpensed,
        );

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      amount: json['amount'] != null ? (json['amount'] as num).toDouble() : null,
      categoryName: json['categoryName'],
      categoryId: json['categoryId'],
      hasExpensed: json['hasExpensed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'categoryName': categoryName,
      'categoryId': categoryId,
      'hasExpensed': hasExpensed,
    };
  }
}
