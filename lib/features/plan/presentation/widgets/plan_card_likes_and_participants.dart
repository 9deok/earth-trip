import 'package:flutter/material.dart';

class PlanCardLikesAndParticipants extends StatelessWidget {
  final int likes, participants;
  const PlanCardLikesAndParticipants({super.key, required this.likes, required this.participants});
  @override
  Widget build(BuildContext context) => Row(
        children: [
          const Icon(Icons.favorite_border, size: 16),
          const SizedBox(width: 4),
          Text('$likes'),
          const SizedBox(width: 16),
          const Icon(Icons.person, size: 16),
          const SizedBox(width: 4),
          Text('$participants'),
        ],
      );
}