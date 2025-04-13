import 'package:flutter/material.dart';
import '../../domain/entities/expense.dart';

class ExpensesListWidget extends StatelessWidget {
  final List<Expense> expenses;

  const ExpensesListWidget({
    Key? key,
    required this.expenses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(child: Text('No expenses for this date'));
    }

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(expense.categoryName),
            subtitle: Text('Category ID: ${expense.categoryId}'),
            trailing: expense.hasExpensed 
              ? Text('${expense.amount ?? 0}')
              : const Text('Not expensed', style: TextStyle(color: Colors.grey)),
            onTap: () {
              // Handle tap on expense item
              // e.g., navigate to expense detail or edit screen
            },
          ),
        );
      },
    );
  }
}
