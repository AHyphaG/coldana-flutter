import 'package:coldana_flutter/features/auth/presentation/pages/home_page.dart';
import 'package:coldana_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:coldana_flutter/features/auth/presentation/pages/splash_page.dart';
import 'package:coldana_flutter/features/calendar/presentation/pages/calendar_page.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashPage.routeName: (_) => const SplashPage(),
  LoginPage.routeName: (_) => const LoginPage(),
  HomePage.routeName: (_) => const HomePage(),
  CalendarPage.routeName: (_) => CalendarPage(),
};