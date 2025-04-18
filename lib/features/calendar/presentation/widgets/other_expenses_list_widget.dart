import 'package:flutter/material.dart';
import '../../domain/entities/other_expense.dart';

class OtherExpensesListWidget extends StatelessWidget {
  final List<OtherExpense> otherExpenses;

  const OtherExpensesListWidget({
    Key? key,
    required this.otherExpenses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (otherExpenses.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Other Expenses',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: otherExpenses.length,
          itemBuilder: (context, index) {
            final otherExpense = otherExpenses[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ListTile(
                title: Text(otherExpense.description),
                trailing: Text('${otherExpense.amount}'),
              ),
            );
          },
        ),
      ],
    );
  }
}