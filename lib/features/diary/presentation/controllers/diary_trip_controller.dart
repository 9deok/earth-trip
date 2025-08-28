import 'package:flutter/foundation.dart';
import '../../domain/entities/diary_entry_entity.dart';
import '../../domain/usecases/get_diary_by_plan_use_case.dart';
import '../../domain/usecases/save_diary_use_case.dart';
import '../../domain/usecases/delete_diary_use_case.dart';

class DiaryTripController extends ChangeNotifier {
  final GetDiaryByPlanUseCase getByPlan;
  final SaveDiaryUseCase saveDiaryUseCase;
  final DeleteDiaryUseCase deleteDiaryUseCase;
  final String planId;
  DiaryTripController({
    required this.getByPlan,
    required this.saveDiaryUseCase,
    required this.deleteDiaryUseCase,
    required this.planId,
  });

  List<DiaryEntryEntity> entries = [];
  bool isLoading = false;

  Future<void> load() async {
    isLoading = true;
    notifyListeners();
    entries = await getByPlan.call(planId);
    isLoading = false;
    notifyListeners();
  }

  Future<void> saveOrUpdate(DiaryEntryEntity entry) async {
    await saveDiaryUseCase.call(entry);
    await load();
  }

  Future<void> delete(String id) async {
    await deleteDiaryUseCase.call(id);
    await load();
  }
}
