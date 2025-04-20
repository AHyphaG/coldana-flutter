import '../../domain/entities/category.dart';

class CategoryModel extends ExpenseCategory {
  const CategoryModel({
    required String categoryId,
    required String userId,
    required String name,
    required double budgetAmount,
    required bool isDaily,
    double? dailyBudget,
    String? activeDays,
    required bool isActive,
  }) : super(
          categoryId: categoryId,
          userId: userId,
          name: name,
          budgetAmount: budgetAmount,
          isDaily: isDaily,
          dailyBudget: dailyBudget,
          activeDays: activeDays,
          isActive: isActive,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      name: json['name'] ?? '',  // Changed from 'category_name' to 'name'
      budgetAmount: json['budgetAmount'] != null ? (json['budgetAmount'] as num).toDouble() : 0.0,
      isDaily: json['daily'] == true || json['daily'] == 1,  // Changed from 'is_daily' to 'daily'
      dailyBudget: json['dailyBudget'] != null ? (json['dailyBudget'] as num).toDouble() : null,
      activeDays: json['activeDays'],  // Changed from 'active_days' to 'activeDays'
      isActive: json['active'] == true || json['active'] == 1,  // Changed from 'isActive' to 'active'
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'category_id': categoryId,
  //     'user_id': userId,
  //     'category_name': name,
  //     'budget_amount': budgetAmount,
  //     'is_daily': isDaily ? 1 : 0,
  //     'daily_budget': dailyBudget,
  //     'active_days': activeDays,
  //     'isActive': isActive ? 1 : 0,
  //   };
  // }
}