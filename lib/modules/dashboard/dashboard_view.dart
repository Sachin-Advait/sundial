import '../home/home_view.dart';
import 'dashboard_provider.dart';
import '../profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final List<Widget> _screens = [const HomeView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _screens[context.watch<DashboardProvider>().selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: context.watch<DashboardProvider>().selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: context.read<DashboardProvider>().changeSelectedIndex,
      ),
    );
  }
}
