import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/widgets/app_scaffold.dart';
import 'app_providers.dart';
import 'core/i18n/strings.dart';

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
      theme: ThemeData(primarySwatch: Colors.green),
      home: const AppScaffold(),
    ),
  );
}
