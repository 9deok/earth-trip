import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/widgets/app_scaffold.dart';
import 'app_providers.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: appProviders,
    child: MaterialApp(
      title: 'Travel Planner',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const AppScaffold(),
    ),
  );
}
