import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/plan_controller.dart';
import 'plan_view.dart';
import '../../domain/usecases/delete_plan_use_case.dart';
import '../../domain/usecases/get_plans_use_case.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (_) => PlanController(
            getPlansUseCase: context.read<GetPlansUseCase>(),
            deletePlanUseCase: context.read<DeletePlanUseCase>(),
          )..loadPlans(),
      child: const PlanView(),
    );
  }
}
