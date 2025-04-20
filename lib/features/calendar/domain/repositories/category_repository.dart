import '../entities/category.dart';

abstract class CategoryRepository {
  Future<List<ExpenseCategory>> getCategories({required bool isDaily});
}