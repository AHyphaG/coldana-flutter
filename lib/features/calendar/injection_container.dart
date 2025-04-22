import 'package:coldana_flutter/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:coldana_flutter/features/category/data/datasources/category_remote_data_source.dart';
import 'package:coldana_flutter/features/category/data/repositories/category_repository_impl.dart';
import 'package:coldana_flutter/features/category/domain/repositories/category_repository.dart';
import 'package:coldana_flutter/features/calendar/domain/usecases/add_category_expense.dart';
import 'package:coldana_flutter/features/category/domain/usecases/get_categories.dart';
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
    () => CalendarBloc(
      getMonthExpenses: sl(),
      updateExpense: sl(),
      getCategories: sl(),
      addCategoryExpense: sl(),
    ),
  );

  // Use cases
  // sl.registerLazySingleton(() => GetExpensesForDate(sl()));
  sl.registerLazySingleton(() => GetMonthExpenses(sl()));
  sl.registerLazySingleton(() => UpdateExpense(sl()));
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => AddCategoryExpense(sl()));

  // Repository
  sl.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ExpenseRemoteDataSource>(
    () => ExpenseRemoteDataSourceImpl(
      client: sl<http.Client>(),
      // baseUrl: 'https://your-api-base-url.com',
      // baseUrl: 'http://localhost:8080', // If Using other than android emulator
      baseUrl: 'http://10.0.2.2:8080',
      authLocalDataSource: sl<AuthLocalDataSource>(),
    ),
  );
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(
      client: sl<http.Client>(),
      // baseUrl: 'http://localhost:8080', // If Using other than android emulator
      baseUrl: 'http://10.0.2.2:8080',
      authLocalDataSource: sl<AuthLocalDataSource>(),
    ),
  );

  // External
  // sl.registerLazySingleton(() => http.Client()); // Sudah diregister di lib/injection_container.dart
}
