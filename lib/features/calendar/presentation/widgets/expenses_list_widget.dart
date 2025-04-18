import 'package:flutter/material.dart';
import '../../domain/entities/expense.dart';

class ExpensesListWidget extends StatelessWidget {
  final List<Expense> expenses;
  final Function(String categoryId, double amount) onExpenseUpdated;

  const ExpensesListWidget({
    Key? key,
    required this.expenses,
    required this.onExpenseUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(child: Text('No expenses for this date'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Category Expenses',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final expense = expenses[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(expense.categoryName),
                  // subtitle: Text('Category ID: ${expense.categoryId}'),
                  trailing: expense.hasExpensed 
                    ? Text('${expense.amount ?? 0}')
                    : const Text('Not expensed', style: TextStyle(color: Colors.grey)),
                  onTap: () {
                    _showInputDialog(context, expense);
                  },
                ),
              );
            },
          )
        )
      ]
    );
  }

  void _showInputDialog(BuildContext context, Expense expense) {
    final amountController = TextEditingController();
    
    // Pre-fill with existing amount if available
    if (expense.amount != null) {
      amountController.text = expense.amount.toString();
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Update ${expense.categoryName}'),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Amount',
            prefixText: 'Rp ',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (amountController.text.isNotEmpty) {
                final amount = double.tryParse(amountController.text);
                if (amount != null) {
                  onExpenseUpdated(expense.categoryId, amount);
                  Navigator.of(ctx).pop();
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}