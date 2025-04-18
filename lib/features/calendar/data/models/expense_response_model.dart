import 'package:coldana_flutter/features/calendar/data/models/other_expense_model.dart';
import 'package:coldana_flutter/features/calendar/domain/entities/other_expense.dart';

import '../../domain/entities/expense_response.dart';
import 'expense_model.dart';

class ExpenseResponseModel extends ExpenseResponse {
  const ExpenseResponseModel({
    required String date,
    required List<ExpenseModel> expenses,
    required List<OtherExpenseModel> otherExpenses,
  }) : super(
          date: date,
          expenses: expenses,
          otherExpenses: otherExpenses,
        );

  factory ExpenseResponseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseResponseModel(
      date: json['date'],
      expenses: (json['expenses'] as List)
          .map((item) => ExpenseModel.fromJson(item))
          .toList(),
      otherExpenses: json['other_expenses'] != null
          ? (json['other_expenses'] as List)
              .map((item) => OtherExpenseModel.fromJson(item))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'expenses': (expenses as List<ExpenseModel>)
          .map((expense) => expense.toJson())
          .toList(),
      'other_expenses': (otherExpenses as List<OtherExpenseModel>)
          .map((otherExpense) => otherExpense.toJson())
          .toList(),
    };
  }
}