import 'package:flutter/material.dart';

class TripSummaryHeader extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String country;
  final String city;
  final String memo;
  final int totalExpense;
  final int participantCount;
  final VoidCallback onEditTitle;

  const TripSummaryHeader({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.country,
    required this.city,
    required this.memo,
    required this.totalExpense,
    required this.participantCount,
    required this.onEditTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: onEditTitle,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.people, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text(
                  '함께한 사람 $participantCount명',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '$country / $city',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              memo,
              style: const TextStyle(color: Colors.white70),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.attach_money, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text(
                  '₩${totalExpense.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
