import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/usecases/get_diary_by_month_use_case.dart';
import '../../domain/usecases/save_diary_use_case.dart';
import '../controllers/diary_controller.dart';
import 'diary_view.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (_) => DiaryController(
            getByMonth: context.read<GetDiaryByMonthUseCase>(),
            saveDiary: context.read<SaveDiaryUseCase>(),
          )..load(),
      child: const DiaryView(),
    );
  }
}
