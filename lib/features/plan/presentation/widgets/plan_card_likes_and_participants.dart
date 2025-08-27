import 'package:flutter/material.dart';
import 'styles/plan_card_likes_and_participants_styles.dart';

class PlanCardLikesAndParticipants extends StatelessWidget {
  final int likes, participants;
  const PlanCardLikesAndParticipants({
    super.key,
    required this.likes,
    required this.participants,
  });
  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Icon(
        Icons.favorite_border,
        size: PlanCardLikesAndParticipantsStyles.iconSize,
      ),
      PlanCardLikesAndParticipantsStyles.gapXs,
      Text('$likes'),
      PlanCardLikesAndParticipantsStyles.gapSm,
      const Icon(
        Icons.person,
        size: PlanCardLikesAndParticipantsStyles.iconSize,
      ),
      PlanCardLikesAndParticipantsStyles.gapXs,
      Text('$participants'),
    ],
  );
}
