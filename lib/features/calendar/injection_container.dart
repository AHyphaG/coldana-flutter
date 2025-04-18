import 'package:coldana_flutter/features/calendar/domain/usecases/update_expense.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/expense_remote_data_source.dart';
import 'data/repositories/expense_repository_impl.dart';
import 'domain/repositories/expense_repository.dart';
import 'domain/usecases/get_expenses_for_date.dart';
import 'presentation/bloc/calendar_bloc.dart';

final sl = GetIt.instance;

void init() {
  // BLoC
  sl.registerFactory(
    () => CalendarBloc(getMonthExpenses: sl(),
    updateExpense: sl(),
    ),
  );

  // Use cases
  // sl.registerLazySingleton(() => GetExpensesForDate(sl()));
  sl.registerLazySingleton(() => GetMonthExpenses(sl()));
  sl.registerLazySingleton(() => UpdateExpense(sl()));

  // Repository
  sl.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ExpenseRemoteDataSource>(
    () => ExpenseRemoteDataSourceImpl(
      client: sl(),
      // baseUrl: 'https://your-api-base-url.com',
      baseUrl: 'http://localhost:8080',
    ),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}
