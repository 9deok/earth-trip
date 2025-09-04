import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/widgets/app_scaffold.dart';
import 'app_providers.dart';
import 'core/i18n/strings.dart';
import 'core/theme/colors.dart';

void main() {
  initializeDateFormatting('ko_KR'); // 한국어 로케일 데이터 초기화
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: appProviders,
    child: MaterialApp(
      title: Strings.appTitle,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: AppColors.lightColorScheme(),
        scaffoldBackgroundColor: AppColors.backgroundSub,
        cardTheme: const CardThemeData(color: Colors.white),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.lightColorScheme().surface,
          foregroundColor: AppColors.lightColorScheme().onSurface,
          elevation: 0,
          centerTitle: true,
        ),
        tabBarTheme: TabBarThemeData(
          labelColor: AppColors.lightColorScheme().primary,
          unselectedLabelColor: AppColors.lightColorScheme().onSurfaceVariant,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: AppColors.lightColorScheme().primary,
              width: 2,
            ),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.lightColorScheme().inverseSurface,
          contentTextStyle: TextStyle(
            color: AppColors.lightColorScheme().onInverseSurface,
          ),
        ),
        dialogTheme: DialogThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: AppColors.lightColorScheme().surface,
          hintStyle: TextStyle(
            color: AppColors.lightColorScheme().onSurfaceVariant,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.lightColorScheme().primary),
          ),
        ),
        chipTheme: ChipThemeData(
          shape: StadiumBorder(
            side: BorderSide(
              color: AppColors.lightColorScheme().outlineVariant,
            ),
          ),
          selectedColor: AppColors.lightColorScheme().primaryContainer,
          labelStyle: TextStyle(color: AppColors.lightColorScheme().onSurface),
          secondaryLabelStyle: TextStyle(
            color: AppColors.lightColorScheme().onPrimaryContainer,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ),
      home: const AppScaffold(),
    ),
  );
}
