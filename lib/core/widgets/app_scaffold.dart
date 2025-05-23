import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';
import '../../features/plan/presentation/pages/plan_page.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _selectedIndex = 2;

  static final _pages = <Widget>[
    Center(child: Text('Home')),
    Center(child: Text('Diary')),
    PlanPage(),
    Center(child: Text('Chat')),
    Center(child: Text('Account')),
  ];

  void _onTap(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
    );
  }
}