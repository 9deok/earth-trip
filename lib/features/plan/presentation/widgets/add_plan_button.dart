import 'package:flutter/material.dart';
import '../pages/add_plan_page.dart';
import 'package:provider/provider.dart';
import '../controllers/plan_controller.dart';

class AddPlanButton extends StatelessWidget {
  const AddPlanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton.icon(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPlanPage()),
          );
          if (result != null) {
            await context.read<PlanController>().loadPlans();
            // 상태 갱신을 위해 setState를 사용할 수 없으므로, PlanController에서 notifyListeners()를 활용하세요.
          }
        },
        icon: const Icon(Icons.add, size: 18),
        label: const Text('여행 계획 추가하기', style: TextStyle(fontSize: 14)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          minimumSize: const Size(0, 40),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          elevation: 4,
        ),
      ),
    );
  }
}