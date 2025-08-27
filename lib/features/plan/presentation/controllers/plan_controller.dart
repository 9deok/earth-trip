import 'package:flutter/foundation.dart';
import '../../domain/entities/plan_entity.dart';
import '../../domain/usecases/get_plans_use_case.dart';
import '../../domain/usecases/delete_plan_use_case.dart';

class PlanController extends ChangeNotifier {
  final GetPlansUseCase getPlansUseCase;
  final DeletePlanUseCase deletePlanUseCase;
  List<PlanEntity> plans = [];
  bool isLoading = false;

  PlanController({
    required this.getPlansUseCase,
    required this.deletePlanUseCase,
  });

  Future<void> loadPlans() async {
    isLoading = true;
    notifyListeners();

    plans = await getPlansUseCase.call(null);

    isLoading = false;
    notifyListeners();
  }

  Future<void> deletePlan(String id) async {
    await deletePlanUseCase.call(id);
    plans.removeWhere((plan) => plan.id == id);
    notifyListeners();
  }
}
