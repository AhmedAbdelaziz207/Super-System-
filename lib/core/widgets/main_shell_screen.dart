import 'package:flutter/material.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/core/widgets/app_bottom_nav_bar.dart';
import 'package:super_system/features/exams/exams_screen.dart';
import 'package:super_system/features/home/home_screen.dart';
import 'package:super_system/features/profile/profile_screen.dart';

class MainShellScreen extends StatefulWidget {
  final int initialIndex;

  const MainShellScreen({super.key, this.initialIndex = 0});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabSelected(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Allows the body to go behind the bottom nav bar
      backgroundColor: AppColors.surface,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(onProfileTap: () => _onTabSelected(2)),
          const ExamsScreen(showBackButton: false),
          const ProfileScreen(showBackButton: false),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
      ),
    );
  }
}
