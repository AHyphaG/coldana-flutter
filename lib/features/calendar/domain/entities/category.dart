import 'package:equatable/equatable.dart';

class ExpenseCategory extends Equatable{
  final String categoryId;
  final String userId;
  final String name;
  final double budgetAmount;
  final bool isDaily;
  final double? dailyBudget;
  final String? activeDays;
  final bool isActive;

  const ExpenseCategory({
    required this.categoryId,
    required this.userId,
    required this.name,
    required this.budgetAmount,
    required this.isDaily,
    this.dailyBudget,
    this.activeDays,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
    categoryId, 
    userId, 
    name, 
    budgetAmount, 
    isDaily, 
    dailyBudget, 
    activeDays, 
    isActive
  ];

}