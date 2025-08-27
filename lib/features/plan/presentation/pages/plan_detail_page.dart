import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/daily_plan_entity.dart';
import '../widgets/trip_summary_header.dart';
import '../widgets/daily_plan_card.dart';

class PlanDetailPage extends StatefulWidget {
  final String planId;
  final String title;
  final String country;
  final String city;
  final DateTime startDate;
  final DateTime endDate;

  const PlanDetailPage({
    super.key,
    required this.planId,
    required this.title,
    required this.country,
    required this.city,
    required this.startDate,
    required this.endDate,
  });

  @override
  State<PlanDetailPage> createState() => _PlanDetailPageState();
}

class _PlanDetailPageState extends State<PlanDetailPage> {
  late String _title;
  final String _memo = "가장 햇살 좋았던 날들을 기억하며";
  final int _totalExpense = 1230000;
  final int _participantCount = 3;
  late List<DailyPlanEntity> _dailyPlans;

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _loadDailyPlans();
  }

  void _loadDailyPlans() {
    // 실제로는 API나 로컬 DB에서 데이터를 가져와야 합니다.
    // 여기서는 임시 데이터를 생성합니다.
    final int dayCount = widget.endDate.difference(widget.startDate).inDays + 1;
    _dailyPlans = List.generate(dayCount, (index) {
      final date = widget.startDate.add(Duration(days: index));
      return DailyPlanEntity(
        id: const Uuid().v4(),
        date: date,
        summary: '이 날은 ${widget.city} 시내를 도보로 돌며 카페 탐방을 했습니다.',
        imageUrl: 'https://picsum.photos/seed/${index + 1}/500/300',
        places: ['중앙 광장', '역사 박물관', '시내 공원', '유명 카페', '현지 맛집'],
        mealCount: 2,
        moveCount: 1,
      );
    });
  }

  void _editTitle() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('여행 제목 수정'),
            content: TextField(
              controller: TextEditingController(text: _title),
              decoration: const InputDecoration(hintText: '여행 제목을 입력하세요'),
              onChanged: (value) => _title = value,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {});
                  Navigator.pop(context);
                },
                child: const Text('저장'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height / 3,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: TripSummaryHeader(
                title: _title,
                imageUrl: 'https://picsum.photos/seed/travel/800/600',
                country: widget.country,
                city: widget.city,
                memo: _memo,
                totalExpense: _totalExpense,
                participantCount: _participantCount,
                onEditTitle: _editTitle,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: const Text(
                '일자별 계획',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return DailyPlanCard(
                dailyPlan: _dailyPlans[index],
                dayNumber: index + 1,
                onTap: () {
                  // 일자별 상세 페이지로 이동
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Day ${index + 1} 상세 페이지로 이동')),
                  );
                },
              );
            }, childCount: _dailyPlans.length),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
