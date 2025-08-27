import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/plan_controller.dart';
import '../../widgets/plan_card.dart';
import '../../../../../core/i18n/strings.dart';

class PlanListSection extends StatelessWidget {
  const PlanListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PlanController>();

    if (controller.plans.isEmpty) {
      return Center(child: Text(Strings.Plan.emptyList));
    }

    return ListView.builder(
      itemCount: controller.plans.length,
      itemBuilder: (context, index) {
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
              builder:
                  (ctx) => AlertDialog(
                    title: Text(Strings.Plan.confirmDeleteTitle),
                    content: Text(Strings.Plan.confirmDeleteContent),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: Text(Strings.Common.cancel),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        child: Text(Strings.Common.delete),
                      ),
                    ],
                  ),
            );
          },
          onDismissed: (direction) async {
            await controller.deletePlan(p.id);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(Strings.Plan.deletedSnack)));
          },
          child: PlanCard(
            id: p.id,
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
      },
    );
  }
}
