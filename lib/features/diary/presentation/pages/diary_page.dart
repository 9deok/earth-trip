import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/usecases/get_diary_trips_use_case.dart';
import 'diary_trips_view.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => context.read<GetDiaryTripsUseCase>(),
      child: const DiaryTripsView(),
    );
  }
}
