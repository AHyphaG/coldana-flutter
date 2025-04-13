// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:table_calendar/table_calendar.dart';

// import '../bloc/calendar_bloc.dart';
// import '../widgets/expenses_list_widget.dart';
// import '../../domain/entities/expense_response.dart';

// class CalendarPage extends StatelessWidget {
//   static const String routeName = '/calendar';

//   const CalendarPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Calendar'),
//       ),
//       body: BlocConsumer<CalendarBloc, CalendarState>(
//         listener: (context, state) {
//           if (state is ExpensesError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.message)),
//             );
//           }
//         },
//         builder: (context, state) {
//           final calendarState = state is CalendarDatesLoaded 
//               ? state 
//               : BlocProvider.of<CalendarBloc>(context).state as CalendarDatesLoaded;
          
//           return Column(
//             children: [
//               TableCalendar(
//                 focusedDay: calendarState.focusedDay,
//                 firstDay: DateTime.utc(2010, 1, 1),
//                 lastDay: DateTime.utc(2030, 12, 31),
//                 selectedDayPredicate: (day) {
//                   return isSameDay(calendarState.selectedDay, day);
//                 },
//                 onDaySelected: (selectedDay, focusedDay) {
//                   BlocProvider.of<CalendarBloc>(context).add(
//                     SelectDateEvent(
//                       selectedDate: selectedDay,
//                       focusedDate: focusedDay,
//                     ),
//                   );
//                 },
//               ),
//               const Divider(),
//               Expanded(
//                 child: _buildExpensesContent(state),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildExpensesContent(CalendarState state) {
//     if (state is ExpensesLoading) {
//       return const Center(child: CircularProgressIndicator());
//     } else if (state is ExpensesLoaded) {
//       return ExpensesListWidget(expenses: state.expenseResponse.expenses);
//     } else if (state is ExpensesError) {
//       return Center(child: Text('Error: ${state.message}'));
//     } else {
//       return const Center(child: Text('Select a date to view expenses'));
//     }
//   }
// }


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
          // Get the calendar bloc
          final calendarBloc = BlocProvider.of<CalendarBloc>(context);
          
          // Extract focused day and selected day
          DateTime focusedDay;
          DateTime? selectedDay;
          
          // This is where we were having the issue
          if (state is CalendarDatesLoaded) {
            focusedDay = state.focusedDay;
            selectedDay = state.selectedDay;
          } else {
            // Use the values stored in the bloc itself
            focusedDay = calendarBloc.focusedDay;
            selectedDay = calendarBloc.selectedDay;
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
              ),
              const Divider(),
              Expanded(
                child: _buildExpensesContent(state),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildExpensesContent(CalendarState state) {
    if (state is ExpensesLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ExpensesLoaded) {
      return ExpensesListWidget(expenses: state.expenseResponse.expenses);
    } else if (state is ExpensesError) {
      return Center(child: Text('Error: ${state.message}'));
    } else {
      return const Center(child: Text('Select a date to view expenses'));
    }
  }
}