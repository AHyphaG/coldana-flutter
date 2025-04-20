import 'package:coldana_flutter/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        Row(
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
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                icon: const Icon(Icons.add_circle),
                tooltip: 'Add Category Expense',
                onPressed: () {
                  context.read<CalendarBloc>().add(LoadCategoriesEvent());
                  _showAddCategoryExpenseDialog(context);
                },
              ),
            )
          ],
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

void _showAddCategoryExpenseDialog(BuildContext context){
  final amountController = TextEditingController();
  String?  selectedCategoryId;

  final CalendarBloc calendarBloc = context.read<CalendarBloc>();
  final selectedDay = calendarBloc.selectedDay ?? DateTime.now();
  final formattedDate = "${selectedDay.year}-${selectedDay.month.toString().padLeft(2, '0')}-${selectedDay.day.toString().padLeft(2, '0')}";

  showDialog(
    context: context, 
    builder: (context) {
      return BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state){
          if (state is CategoriesLoaded){
            final categories = state.categories;

            return AlertDialog(
              title: const Text('Add Category Expense'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      items: categories.map((category) {
                        return DropdownMenuItem(
                          value: category.categoryId,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedCategoryId = value;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: amountController,
                      decoration: const InputDecoration(
                        labelText: 'Amount',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedCategoryId != null && amountController.text.isNotEmpty) {
                      // Process the form
                      final amount = double.parse(amountController.text);
                      
                      // Add the expense through CalendarBloc
                      context.read<CalendarBloc>().add(
                        AddCategoryExpenseEvent(
                          categoryId: selectedCategoryId!,
                          categoryName: categories.firstWhere((c) => c.categoryId == selectedCategoryId).name, // Get name from selected category
                          amount: amount,
                          date: formattedDate,
                        ),
                      );
                      
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          }

          return const AlertDialog(
            content: Center(
              child: CircularProgressIndicator(),
            ),
          );

          
        },
      );
    }
  );

}