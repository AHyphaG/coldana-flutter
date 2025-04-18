part of 'calendar_bloc.dart';

// abstract class CalendarState extends Equatable {
//   const CalendarState();  

//   @override
//   List<Object> get props => [];
// }
// class CalendarInitial extends CalendarState {}


abstract class CalendarState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CalendarInitial extends CalendarState {}

// class CalendarDatesLoaded extends CalendarState {
//   final DateTime focusedDay;
//   final DateTime? selectedDay;

//   CalendarDatesLoaded({
//     required this.focusedDay,
//     this.selectedDay,
//   });

//   @override
//   List<Object?> get props => [focusedDay, selectedDay];
// }

class ExpensesLoading extends CalendarState {}

class ExpensesLoaded extends CalendarState {
  final ExpenseResponse expenseResponse;

  ExpensesLoaded(this.expenseResponse);

  @override
  List<Object> get props => [expenseResponse];
}

class ExpensesError extends CalendarState {
  final String message;

  ExpensesError(this.message);

  @override
  List<Object> get props => [message];
}

class CalendarDatesLoaded extends CalendarState {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final CalendarFormat calendarFormat;

  CalendarDatesLoaded({
    required this.focusedDay,
    this.selectedDay,
    this.calendarFormat = CalendarFormat.month,
  });

  @override
  List<Object?> get props => [focusedDay, selectedDay, calendarFormat];
}