import 'package:equatable/equatable.dart';

class OtherExpense extends Equatable {
  final String description;
  final double amount;

  const OtherExpense({
    required this.description,
    required this.amount,
  });

  @override
  List<Object> get props => [description, amount];
}