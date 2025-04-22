import 'package:equatable/equatable.dart';

class OtherExpense extends Equatable {
  final String id;
  final String description;
  final double amount;
  final String date;

  const OtherExpense({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });

  @override
  List<Object> get props => [id, description, amount, date];
}
