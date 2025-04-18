import 'package:bloc/bloc.dart';
import 'package:coldana_flutter/features/calendar/domain/usecases/update_expense.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../domain/entities/expense_response.dart';
import '../../domain/usecases/get_expenses_for_date.dart';


part 'calendar_event.dart';
part 'calendar_state.dart';

// class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
//   CalendarBloc() : super(CalendarInitial()) {
//     on<CalendarEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final GetMonthExpenses getMonthExpenses;
  final UpdateExpense updateExpense;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  Map<String, ExpenseResponse> _monthData = {};

  //   // getters
  DateTime get focusedDay => _focusedDay;
  DateTime? get selectedDay => _selectedDay;
  CalendarFormat get calendarFormat => _calendarFormat;

  CalendarBloc({required this.getMonthExpenses,required this.updateExpense, }) 
      : super(CalendarDatesLoaded(
          focusedDay: DateTime.now(),
          selectedDay: DateTime.now(),
        )) {
    _selectedDay = _focusedDay;
    
    on<SelectDateEvent>(_onSelectDate);
    on<FetchMonthExpensesEvent>(_onFetchMonthExpenses);
    on<UpdateExpenseEvent>(_onUpdateExpense);
    on<ChangeCalendarFormatEvent>(_onChangeCalendarFormat);
    
    // Initialize with current month data
    _initializeCalendar();
  }
  
  void _initializeCalendar() {
    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);
    final lastDay = DateTime(now.year, now.month + 1, 0);
    
    final startDate = "${firstDay.year}-${firstDay.month.toString().padLeft(2, '0')}-${firstDay.day.toString().padLeft(2, '0')}";
    final endDate = "${lastDay.year}-${lastDay.month.toString().padLeft(2, '0')}-${lastDay.day.toString().padLeft(2, '0')}";
    
    add(FetchMonthExpensesEvent(startDate: startDate, endDate: endDate));
  }

  void _onChangeCalendarFormat(ChangeCalendarFormatEvent event, Emitter<CalendarState> emit) {
    _calendarFormat = event.format;
    
    emit(CalendarDatesLoaded(
      focusedDay: _focusedDay,
      selectedDay: _selectedDay,
      calendarFormat: _calendarFormat,
    ));
  }

  void _onSelectDate(SelectDateEvent event, Emitter<CalendarState> emit) {
    _selectedDay = event.selectedDate;
    _focusedDay = event.focusedDate;
    
    final formattedDate = "${_selectedDay!.year}-${_selectedDay!.month.toString().padLeft(2, '0')}-${_selectedDay!.day.toString().padLeft(2, '0')}";
    
    // If we already have month data, use it instead of fetching again
    if (_monthData.containsKey(formattedDate)) {
      emit(ExpensesLoaded(_monthData[formattedDate]!));
    } else {
      // If we need to fetch data for a new month
      final firstDay = DateTime(_selectedDay!.year, _selectedDay!.month, 1);
      final lastDay = DateTime(_selectedDay!.year, _selectedDay!.month + 1, 0);
      
      final startDate = "${firstDay.year}-${firstDay.month.toString().padLeft(2, '0')}-${firstDay.day.toString().padLeft(2, '0')}";
      final endDate = "${lastDay.year}-${lastDay.month.toString().padLeft(2, '0')}-${lastDay.day.toString().padLeft(2, '0')}";
      
      add(FetchMonthExpensesEvent(startDate: startDate, endDate: endDate));
    }
  }
  
  void _onFetchMonthExpenses(FetchMonthExpensesEvent event, Emitter<CalendarState> emit) async {
    emit(ExpensesLoading());
    
    try {
      final monthResponses = await getMonthExpenses.execute(event.startDate, event.endDate);
      
      // Store month data for easy access
      _monthData = {};
      for (var dayResponse in monthResponses) {
        _monthData[dayResponse.date] = dayResponse;
      }
      
      // If a day is selected, show its data
      if (_selectedDay != null) {
        final formattedDate = "${_selectedDay!.year}-${_selectedDay!.month.toString().padLeft(2, '0')}-${_selectedDay!.day.toString().padLeft(2, '0')}";
        if (_monthData.containsKey(formattedDate)) {
          emit(ExpensesLoaded(_monthData[formattedDate]!));
        }
      }
    } catch (e) {
      emit(ExpensesError(e.toString()));
    }
  }

  void _onUpdateExpense(UpdateExpenseEvent event, Emitter<CalendarState> emit) async {
  emit(ExpensesLoading());
  
  try {
    await updateExpense.execute(
      categoryId: event.categoryId,
      amount: event.amount,
      date: event.date,
    );
    
    // After successful update, refresh the data for the current month
    final firstDayOfMonth = DateTime(_selectedDay!.year, _selectedDay!.month, 1);
    final lastDayOfMonth = DateTime(_selectedDay!.year, _selectedDay!.month + 1, 0);
    
    final startDate = "${firstDayOfMonth.year}-${firstDayOfMonth.month.toString().padLeft(2, '0')}-${firstDayOfMonth.day.toString().padLeft(2, '0')}";
    final endDate = "${lastDayOfMonth.year}-${lastDayOfMonth.month.toString().padLeft(2, '0')}-${lastDayOfMonth.day.toString().padLeft(2, '0')}";
    
    add(FetchMonthExpensesEvent(startDate: startDate, endDate: endDate));
  } catch (e) {
    emit(ExpensesError(e.toString()));
  }
}

}