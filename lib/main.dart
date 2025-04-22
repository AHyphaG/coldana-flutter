import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'routes.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/splash_page.dart';
import 'features/calendar/presentation/bloc/calendar_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => di.sl<AuthBloc>()),
        BlocProvider<CalendarBloc>(create: (context) => di.sl<CalendarBloc>()),
      ],
      child: MaterialApp(
        title: 'Coldana',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 28, 90, 156),
          ),
          useMaterial3: true,
        ),
        routes: routes,
        initialRoute: SplashPage.routeName,
      ),
    );
  }
}
