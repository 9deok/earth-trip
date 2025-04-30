import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/plan_controller.dart';
import '../widgets/plan_card.dart';
import 'add_plan_page.dart';

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
      appBar: AppBar(title: const Text('내 계획')),
      body: ListView.builder(
        itemCount: controller.plans.length,
        itemBuilder: (context, index) {
          final p = controller.plans[index];
          final imageUrl =
              (p.imageUrl == null || p.imageUrl!.isEmpty)
                  ? 'assets/flags/default.png'
                  : p.imageUrl!;
          return PlanCard(
            title: p.title,
            imageUrl: imageUrl,
            startDate: p.start,
            endDate: p.end,
            daysLeft: p.daysLeft ?? 0,
            flightDuration: p.flightDuration ?? '',
            stayDuration: p.stayDuration ?? '',
            cost: p.cost ?? 0,
            likes: p.likes ?? 0,
            participants: p.participants ?? 1,
          );
        },
      ),
      floatingActionButton: SizedBox(
        height: 40,
        child: ElevatedButton.icon(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPlanPage()),
            );
            if (result != null) {
              await context.read<PlanController>().loadPlans();
              setState(() {}); // 상태 갱신을 위해 setState 호출
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
      ),
    );
  }
}
