import 'package:flutter/material.dart';
import '../pages/add_plan_page.dart';
import 'package:provider/provider.dart';
import '../controllers/plan_controller.dart';
import 'styles/add_plan_button_styles.dart';

class AddPlanButton extends StatelessWidget {
  const AddPlanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AddPlanButtonStyles.buttonHeight,
      child: ElevatedButton.icon(
        onPressed: () async {
          final navigator = Navigator.of(context);
          final controller = context.read<PlanController>();
          final result = await navigator.push(
            // 상위 컨텍스트 사용 금지 규칙 준수: 사전 캡처한 navigator 사용
            MaterialPageRoute(builder: (context) => const AddPlanPage()),
          );
          if (result != null) {
            await controller.loadPlans();
            // 상태 갱신을 위해 setState를 사용할 수 없으므로, PlanController에서 notifyListeners()를 활용하세요.
          }
        },
        icon: const Icon(Icons.add, size: AddPlanButtonStyles.iconSize),
        label: const Text(
          '여행 계획 추가하기',
          style: AddPlanButtonStyles.labelTextStyle,
        ),
        style: AddPlanButtonStyles.buttonStyle(context),
      ),
    );
  }
}
