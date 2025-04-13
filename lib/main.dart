import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coldana_flutter/features/calendar/presentation/pages/calendar_page.dart';
import 'package:coldana_flutter/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:coldana_flutter/routes.dart';
import 'package:coldana_flutter/features/calendar/injection_container.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CalendarBloc>(
          create: (context) => di.sl<CalendarBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 120, 87, 177)),
        ),
        routes: routes,
        initialRoute: CalendarPage.routeName,
      ),
    );
  }
}