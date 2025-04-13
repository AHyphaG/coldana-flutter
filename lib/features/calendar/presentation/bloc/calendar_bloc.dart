import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final GetExpensesForDate getExpensesForDate;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // getters
  DateTime get focusedDay => _focusedDay;
  DateTime? get selectedDay => _selectedDay;

  CalendarBloc({required this.getExpensesForDate}) 
      : super(CalendarDatesLoaded(
          focusedDay: DateTime.now(),
          selectedDay: DateTime.now(),
        )) {
    _selectedDay = _focusedDay;
    
    on<SelectDateEvent>(_onSelectDate);
    on<FetchExpensesEvent>(_onFetchExpenses);
  }

  void _onSelectDate(SelectDateEvent event, Emitter<CalendarState> emit) {
    _selectedDay = event.selectedDate;
    _focusedDay = event.focusedDate;
    
    emit(CalendarDatesLoaded(
      focusedDay: _focusedDay,
      selectedDay: _selectedDay,
    ));
    
    // Format date as YYYY-MM-DD
    final formattedDate = "${_selectedDay!.year}-${_selectedDay!.month.toString().padLeft(2, '0')}-${_selectedDay!.day.toString().padLeft(2, '0')}";
    
    add(FetchExpensesEvent(formattedDate));
  }

  void _onFetchExpenses(FetchExpensesEvent event, Emitter<CalendarState> emit) async {
    emit(ExpensesLoading());
    
    try {
      final expenseResponse = await getExpensesForDate.execute(event.date);
      emit(ExpensesLoaded(expenseResponse));
    } catch (e) {
      emit(ExpensesError(e.toString()));
    }
  }
}