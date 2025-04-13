import '../../domain/entities/expense_response.dart';
import 'expense_model.dart';

class ExpenseResponseModel extends ExpenseResponse {
  const ExpenseResponseModel({
    required String date,
    required List<ExpenseModel> expenses,
  }) : super(
          date: date,
          expenses: expenses,
        );

  factory ExpenseResponseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseResponseModel(
      date: json['date'],
      expenses: (json['expenses'] as List)
          .map((item) => ExpenseModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'expenses': (expenses as List<ExpenseModel>)
          .map((expense) => expense.toJson())
          .toList(),
    };
  }
}