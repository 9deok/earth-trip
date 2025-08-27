import 'package:flutter/material.dart';
import 'styles/trip_summary_header_styles.dart';

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
      height: TripSummaryHeaderStyles.headerHeight(context),
      width: double.infinity,
      decoration: BoxDecoration(
        image: TripSummaryHeaderStyles.backgroundImage(imageUrl),
      ),
      child: Padding(
        padding: TripSummaryHeaderStyles.contentPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TripSummaryHeaderStyles.titleTextStyle,
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
                  style: TripSummaryHeaderStyles.bodyTextStyle,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '$country / $city',
                  style: TripSummaryHeaderStyles.bodyTextStyle,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              memo,
              style: TripSummaryHeaderStyles.bodyMutedTextStyle,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.attach_money, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text(
                  '₩${totalExpense.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                  style: TripSummaryHeaderStyles.bodyTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
