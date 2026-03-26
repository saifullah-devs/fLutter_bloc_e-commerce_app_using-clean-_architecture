import 'package:e_commerce_bloc/core/config/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 1. Import flutter_bloc

// 2. Adjust these imports to match your actual file paths
import '../../../../service_locator.dart';
import '../bloc/admin_bloc.dart';

import 'admin_dashboard.dart';
import 'admin_category_screen.dart';

class AdminBottomNavigation extends StatefulWidget {
  const AdminBottomNavigation({super.key});

  @override
  State<AdminBottomNavigation> createState() => _AdminBottomNavigationState();
}

class _AdminBottomNavigationState extends State<AdminBottomNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [AdminDashboard(), AdminCategoryScreen()];

  @override
  Widget build(BuildContext context) {
    // 3. Wrap your Scaffold in a BlocProvider
    return BlocProvider(
      create: (context) => sl<AdminBloc>(), // Create the BLoC here
      child: Scaffold(
        // Because the pages are built inside the Scaffold,
        // they automatically inherit the AdminBloc!
        body: _pages[_currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
          ],
        ),
      ),
    );
  }
}
