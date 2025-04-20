import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:coldana_flutter/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:coldana_flutter/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:coldana_flutter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:coldana_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:coldana_flutter/features/auth/domain/usecases/get_current_user.dart';
import 'package:coldana_flutter/features/auth/domain/usecases/is_logged_in.dart';
import 'package:coldana_flutter/features/auth/domain/usecases/login.dart';
import 'package:coldana_flutter/features/auth/domain/usecases/logout.dart';
import 'package:coldana_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:coldana_flutter/features/calendar/injection_container.dart' as calendar_di;

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Auth
  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      login: sl(),
      logout: sl(),
      getCurrentUser: sl(),
      isLoggedIn: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => IsLoggedIn(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      client: sl(),
      baseUrl: 'http://localhost:8080', // Use your API base URL
    ),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());

  // Init calendar dependencies
  calendar_di.init();
}
