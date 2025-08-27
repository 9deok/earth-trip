import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/plan_controller.dart';
import '../widgets/add_plan_button.dart';
import 'sections/plan_list_section.dart';
import '../../../../core/i18n/strings.dart';

class PlanView extends StatefulWidget {
  const PlanView({super.key});

  @override
  State<PlanView> createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PlanController>();

    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: Text(Strings.Plan.myPlans)),
      body: const PlanListSection(),
      floatingActionButton: const AddPlanButton(),
    );
  }
}
