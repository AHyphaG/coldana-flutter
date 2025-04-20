import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coldana_flutter/features/calendar/presentation/pages/calendar_page.dart';
import 'package:coldana_flutter/features/auth/presentation/bloc/auth_bloc.dart';

import 'dashboard_page.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use ValueNotifier to track current index
    final ValueNotifier<int> selectedIndex = ValueNotifier(0);

    // Define navigation pages
    final pages = [
      const DashboardPage(),
      const CalendarPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coldana'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutEvent());
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: selectedIndex,
        builder: (context, index, _) {
          return pages[index];
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: selectedIndex,
        builder: (context, index, _) {
          return BottomNavigationBar(
            currentIndex: index,
            onTap: (newIndex) {
              selectedIndex.value = newIndex;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Calendar',
              ),
            ],
          );
        },
      ),
    );
  }
}