import 'package:flutter/foundation.dart';
import '../../domain/entities/diary_entry_entity.dart';
import '../../domain/usecases/get_diary_by_month_use_case.dart';
import '../../domain/usecases/save_diary_use_case.dart';

class DiaryController extends ChangeNotifier {
  final GetDiaryByMonthUseCase getByMonth;
  final SaveDiaryUseCase saveDiary;

  DateTime focusedMonth;
  List<DiaryEntryEntity> entries = [];
  bool isLoading = false;

  DiaryController({
    required this.getByMonth,
    required this.saveDiary,
    DateTime? initialMonth,
  }) : focusedMonth = DateTime(
         (initialMonth ?? DateTime.now()).year,
         (initialMonth ?? DateTime.now()).month,
       );

  Future<void> load() async {
    isLoading = true;
    notifyListeners();
    entries = await getByMonth.call(focusedMonth);
    isLoading = false;
    notifyListeners();
  }

  Future<void> addOrUpdate(DiaryEntryEntity entry) async {
    await saveDiary.call(entry);
    await load();
  }
}
