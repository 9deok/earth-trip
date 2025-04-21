// lib/core/widgets/bottom_nav_bar.dart
import 'package:flutter/material.dart';

/// 앱의 주요 화면 전환을 위한 하단 네비게이션 바 위젯
class BottomNavBar extends StatelessWidget {
  final int currentIndex; // 현재 선택된 탭 인덱스
  final ValueChanged<int> onTap; // 탭 선택 시 콜백

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: '일기'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: '내 계획'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: '채팅'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '계정'),
      ],
    );
  }
}
