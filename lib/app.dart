import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_tracker/features/habits/presentation/pages/habit_page.dart';
import 'core/theme/app_theme.dart';
import 'features/dashboard/presentation/dashboard_page.dart';
import 'features/finance/presentation/finance_page.dart';
import 'features/habits/presentation/bloc/habit_bloc.dart';
import 'features/reading/presentation/pages/reading_page.dart';
import 'features/sleep/presentation/sleep_page.dart';
import 'core/di/service_locator.dart';
import 'features/reading/presentation/bloc/reading_bloc.dart';
import 'features/reading/presentation/bloc/reading_event.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ReadingBloc>(
          create: (_) => sl<ReadingBloc>()..add(LoadAllBooks()),
        ),
        BlocProvider<HabitBloc>(
          create: (_) => sl<HabitBloc>(),
        ),
        // Add other feature BLoCs here
      ],
      child: MaterialApp(
        title: 'Personal Tracker',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: const MainNavigation(),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 2; // Dashboard as center

  late final List<Widget> _pages = <Widget>[
    const HabitPage(),
    const ReadingPage(),
    const DashboardPage(),
    const FinancePage(),
    const SleepPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = Theme.of(context).colorScheme.primary;
    final Color inactiveColor = Colors.grey.shade500;
    final Color backgroundColor = Theme.of(context).colorScheme.background;

    return SizedBox(
      height: 80,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: backgroundColor,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NavBarIcon(
                  icon: Icons.check_circle_outline,
                  label: 'Habits',
                  isActive: currentIndex == 0,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  onTap: () => onTap(0),
                ),
                _NavBarIcon(
                  icon: Icons.menu_book_outlined,
                  label: 'Reading',
                  isActive: currentIndex == 1,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  onTap: () => onTap(1),
                ),
                const SizedBox(width: 64), // Space for center button
                _NavBarIcon(
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'Finance',
                  isActive: currentIndex == 3,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  onTap: () => onTap(3),
                ),
                _NavBarIcon(
                  icon: Icons.bedtime_outlined,
                  label: 'Sleep',
                  isActive: currentIndex == 4,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  onTap: () => onTap(4),
                ),
              ],
            ),
          ),
          // Center floating button
          Positioned(
            bottom: 10,
            child: GestureDetector(
              onTap: () => onTap(2),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: currentIndex == 2 ? activeColor : inactiveColor,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.dashboard_outlined,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  const _NavBarIcon({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? activeColor : inactiveColor,
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? activeColor : inactiveColor,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
