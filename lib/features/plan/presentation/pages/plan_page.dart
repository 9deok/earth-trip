import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/plan_controller.dart';
import 'plan_view.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (_) => PlanController(getPlansUseCase: context.read())..loadPlans(),
      child: const PlanView(),
    );
  }
}
