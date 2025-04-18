import '../../domain/entities/other_expense.dart';

class OtherExpenseModel extends OtherExpense {
  const OtherExpenseModel({
    required String description,
    required double amount,
  }) : super(
          description: description,
          amount: amount,
        );

  factory OtherExpenseModel.fromJson(Map<String, dynamic> json) {
    return OtherExpenseModel(
      description: json['description'],
      amount: (json['amount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'amount': amount,
    };
  }
}