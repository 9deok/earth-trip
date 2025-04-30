import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/plan_controller.dart';
import '../widgets/plan_card.dart';
import '../widgets/add_plan_button.dart';

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
        itemBuilder: (context, index) => _buildPlanItem(context, controller, index),
      ),
      floatingActionButton: const AddPlanButton(),
    );
  }

  Widget _buildPlanItem(BuildContext context, PlanController controller, int index) {
    final p = controller.plans[index];
    final imageUrl =
        (p.imageUrl == null || p.imageUrl!.isEmpty)
            ? 'assets/flags/default.png'
            : p.imageUrl!;
    return Dismissible(
      key: ValueKey(p.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('삭제 확인'),
            content: const Text('정말로 이 여행 계획을 삭제하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('취소'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('삭제'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) async {
        await controller.deletePlan(p.id); // id로 삭제
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('여행 계획이 삭제되었습니다.')),
        );
      },
      child: PlanCard(
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
      ),
    );
  }
}
