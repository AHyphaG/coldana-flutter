import 'package:coldana_flutter/features/calendar/domain/entities/category.dart';
import 'package:coldana_flutter/features/calendar/domain/repositories/category_repository.dart';

class GetCategories {
  final CategoryRepository repository;

  GetCategories(this.repository);

  Future<List<ExpenseCategory>> execute({required bool isDaily}) async {
    return await repository.getCategories(isDaily: isDaily);
  }
}