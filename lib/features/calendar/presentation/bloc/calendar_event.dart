part of 'calendar_bloc.dart';

// abstract class CalendarEvent extends Equatable {
//   const CalendarEvent();

//   @override
//   List<Object> get props => [];
// }

abstract class CalendarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SelectDateEvent extends CalendarEvent {
  final DateTime selectedDate;
  final DateTime focusedDate;

  SelectDateEvent({
    required this.selectedDate,
    required this.focusedDate,
  });

  @override
  List<Object> get props => [selectedDate, focusedDate];
}

class FetchExpensesEvent extends CalendarEvent {
  final String date;

  FetchExpensesEvent(this.date);

  @override
  List<Object> get props => [date];
}