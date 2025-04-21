import 'package:flutter/material.dart';
import 'core/widgets/bottom_nav_bar.dart';
import 'features/plan/presentation/pages/plan_page.dart';

/// 앱 진입점: TravelPlannerApp 위젯 실행
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Travel Planner',
    theme: ThemeData(primarySwatch: Colors.green),
    home: AppScaffold(),
  );
}

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _selectedIndex = 2; // 초기 선택 탭: 내 계획

  // 각 탭별 보여줄 페이지 리스트
  static final _pages = <Widget>[
    Center(child: Text('Home')),
    Center(child: Text('Diary')),
    PlanPage(), // 실제로는 GetPlansUseCase 결과 주입 필요
    Center(child: Text('Chat')),
    Center(child: Text('Account')),
  ];

  /// 하단 탭 선택 시 인덱스 업데이트
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
