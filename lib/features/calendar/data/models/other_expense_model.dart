import '../../domain/entities/other_expense.dart';

class OtherExpenseModel extends OtherExpense {
  const OtherExpenseModel({
    required super.id,
    required super.description,
    required super.amount,
    required super.date,
  });

  factory OtherExpenseModel.fromJson(Map<String, dynamic> json) {
    return OtherExpenseModel(
      id: json['id'],
      description: json['description'],
      amount: (json['amount'] as num).toDouble(),
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'date': date,
    };
  }
}
