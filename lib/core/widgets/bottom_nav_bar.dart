// lib/core/widgets/bottom_nav_bar.dart
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../i18n/strings.dart';

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
    final scheme = Theme.of(context).colorScheme;
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: scheme.primary,
      unselectedItemColor: scheme.onSurfaceVariant,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: Strings.Nav.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.book),
          label: Strings.Nav.diary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.map),
          label: Strings.Nav.plans,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.chat),
          label: Strings.Nav.chat,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: Strings.Nav.account,
        ),
      ],
    );
  }
}
