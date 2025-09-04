import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/usecases/get_diary_trips_use_case.dart';
import '../controllers/diary_trips_controller.dart';
import '../../../../core/i18n/strings.dart';
import 'diary_trips_view.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => context.read<GetDiaryTripsUseCase>()),
        ChangeNotifierProvider(create: (_) => DiaryTripsController()),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(Strings.Diary.title)),
        body: const DiaryTripsView(),
      ),
    );
  }
}
