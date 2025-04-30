import 'package:flutter/foundation.dart';
import '../../domain/entities/plan_entity.dart';
import '../../domain/usecases/get_plans_use_case.dart';

class PlanController extends ChangeNotifier {
  final GetPlansUseCase getPlansUseCase;
  List<PlanEntity> plans = [];
  bool isLoading = false;

  PlanController({required this.getPlansUseCase});

  Future<void> loadPlans() async {
    isLoading = true;
    notifyListeners();

    plans = await getPlansUseCase.call(null);

    isLoading = false;
    notifyListeners();
  }
}