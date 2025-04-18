import 'package:coldana_flutter/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:coldana_flutter/features/calendar/presentation/widgets/expenses_list_widget.dart';
import 'package:coldana_flutter/features/calendar/presentation/widgets/other_expenses_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseContentWidget extends StatelessWidget {
  final CalendarState state;
  
  const ExpenseContentWidget({
    Key? key, 
    required this.state,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    if (state is ExpensesLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ExpensesLoaded) {
      final expenseState = state as ExpensesLoaded;
      return Column(
        children: [
          Expanded(
            child: ExpensesListWidget(
              expenses: expenseState.expenseResponse.expenses,
              onExpenseUpdated: (categoryId, amount) {
                final calendarBloc = BlocProvider.of<CalendarBloc>(context);
                final selectedDay = calendarBloc.selectedDay;
                if (selectedDay != null) {
                  final formattedDate = "${selectedDay.year}-${selectedDay.month.toString().padLeft(2, '0')}-${selectedDay.day.toString().padLeft(2, '0')}";
                  
                  calendarBloc.add(
                    UpdateExpenseEvent(
                      categoryId: categoryId,
                      amount: amount,
                      date: formattedDate,
                    ),
                  );
                }
              },
            ),
          ),
          OtherExpensesListWidget(otherExpenses: expenseState.expenseResponse.otherExpenses),
        ],
      );
    } else if (state is ExpensesError) {
      return Center(child: Text('Error: ${(state as ExpensesError).message}'));
    } else {
      return const Center(child: Text('Select a date to view expenses'));
    }
  }
}