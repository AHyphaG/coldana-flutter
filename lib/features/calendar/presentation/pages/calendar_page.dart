import 'package:coldana_flutter/features/calendar/presentation/widgets/expense_content_widget.dart';
import 'package:coldana_flutter/features/calendar/presentation/widgets/other_expenses_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../bloc/calendar_bloc.dart';
import '../widgets/expenses_list_widget.dart';

class CalendarPage extends StatelessWidget {
  static const String routeName = '/calendar';

  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          final calendarBloc = BlocProvider.of<CalendarBloc>(context);
          
          DateTime focusedDay;
          DateTime? selectedDay;
          CalendarFormat calendarFormat;
          
          if (state is CalendarDatesLoaded) {
            focusedDay = state.focusedDay;
            selectedDay = state.selectedDay;
            calendarFormat = state.calendarFormat;
          } else {
            focusedDay = calendarBloc.focusedDay;
            selectedDay = calendarBloc.selectedDay;
            calendarFormat = calendarBloc.calendarFormat;
          }
          
          return Column(
            children: [
              TableCalendar(
                focusedDay: focusedDay,
                firstDay: DateTime.utc(2010, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                selectedDayPredicate: (day) {
                  return selectedDay != null && isSameDay(selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  calendarBloc.add(
                    SelectDateEvent(
                      selectedDate: selectedDay,
                      focusedDate: focusedDay,
                    ),
                  );
                },
                calendarFormat: calendarFormat,
                onFormatChanged: (format) {
                  calendarBloc.add(ChangeCalendarFormatEvent(format));
                },
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                  CalendarFormat.twoWeeks: '2 Weeks',
                  CalendarFormat.week: 'Week',
                },
              ),
              const Divider(),
              Expanded(
                // child: _buildExpensesContent(context, state),
                child: ExpenseContentWidget(state: state),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildExpensesContent(BuildContext context, CalendarState state) {
  if (state is ExpensesLoading) {
    return const Center(child: CircularProgressIndicator());
  } else if (state is ExpensesLoaded) {
    return Column(
      children: [
        Expanded(
          child: ExpensesListWidget(
            expenses: state.expenseResponse.expenses,
            onExpenseUpdated: (categoryId, amount) {
              final selectedDay = BlocProvider.of<CalendarBloc>(context).selectedDay;
              if (selectedDay != null) {
                final formattedDate = "${selectedDay.year}-${selectedDay.month.toString().padLeft(2, '0')}-${selectedDay.day.toString().padLeft(2, '0')}";
                
                // Dispatch event to update expense
                BlocProvider.of<CalendarBloc>(context).add(
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
        OtherExpensesListWidget(otherExpenses: state.expenseResponse.otherExpenses),
      ],
    );
  } else if (state is ExpensesError) {
    return Center(child: Text('Error: ${state.message}'));
  } else {
    return const Center(child: Text('Select a date to view expenses'));
  }
}

}