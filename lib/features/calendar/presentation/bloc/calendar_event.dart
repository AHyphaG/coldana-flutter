part of 'calendar_bloc.dart';

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

class FetchMonthExpensesEvent extends CalendarEvent {
  final String startDate;
  final String endDate;

  FetchMonthExpensesEvent({required this.startDate, required this.endDate});
  
  @override
  List<Object> get props => [startDate, endDate];
}

class UpdateExpenseEvent extends CalendarEvent {
  final String categoryId;
  final double amount;
  final String date;

  UpdateExpenseEvent({
    required this.categoryId,
    required this.amount,
    required this.date,
  });

  @override
  List<Object> get props => [categoryId, amount, date];
}


class ChangeCalendarFormatEvent extends CalendarEvent {
  final CalendarFormat format;

  ChangeCalendarFormatEvent(this.format);

  @override
  List<Object> get props => [format];
}

class LoadCategoriesEvent extends CalendarEvent{}

// class AddCategoryExpenseEvent extends CalendarEvent{
//   final String categoryId;
//   final double amount;
//   final String date;

//   AddCategoryExpenseEvent({required this.categoryId, required this.amount , required this.date});

//   @override
//   List<Object> get props => [categoryId, amount, date];
// }

class AddCategoryExpenseEvent extends CalendarEvent {
  final String categoryId;
  final String categoryName; // Add this field
  final double amount;
  final String date;

  AddCategoryExpenseEvent({
    required this.categoryId,
    required this.categoryName, // New required field
    required this.amount,
    required this.date,
  });

  @override
  List<Object> get props => [categoryId, categoryName, amount, date];
}