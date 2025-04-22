import 'dart:convert';
import 'package:earth_trip/features/plan/data/dummy_plan_data.dart';
import 'package:earth_trip/features/plan/domain/entities/plan_entity.dart';
import 'package:flutter/material.dart';
import '../widgets/plan_card.dart';
import 'add_plan_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  List<PlanEntity> dummyPlans = [];
  List<PlanEntity> userPlans = [];

  @override
  void initState() {
    super.initState();
    dummyPlans = DummyPlanRepository.fetchUpcomingPlans();
    _loadUserPlans();
  }

  Future<void> _loadUserPlans() async {
    final prefs = await SharedPreferences.getInstance();
    final planListString = prefs.getString('userPlans');
    if (planListString != null) {
      final List decoded = jsonDecode(planListString);
      setState(() {
        userPlans = decoded.map((e) => PlanEntity(
          title: e['title'],
          start: DateTime.parse(e['start']),
          end: DateTime.parse(e['end']),
          imageUrl: e['imageUrl'],
          cost: e['cost'],
          daysLeft: e['daysLeft'],
          flightDuration: e['flightDuration'],
          stayDuration: e['stayDuration'],
          likes: e['likes'],
          participants: e['participants'],
        )).toList();
      });
    }
  }

  Future<void> _saveUserPlans() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> planList = userPlans.map((plan) => {
      'title': plan.title,
      'start': plan.start.toIso8601String(),
      'end': plan.end.toIso8601String(),
      'imageUrl': plan.imageUrl,
      'cost': plan.cost,
      'daysLeft': plan.daysLeft,
      'flightDuration': plan.flightDuration,
      'stayDuration': plan.stayDuration,
      'likes': plan.likes,
      'participants': plan.participants,
    }).toList();
    await prefs.setString('userPlans', jsonEncode(planList));
  }

  Future<void> _addPlan() async {
    final newPlan = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddPlanPage()),
    );
    if (newPlan != null) {
      setState(() {
        userPlans.add(newPlan);
      });
      await _saveUserPlans();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 더미 + 사용자 데이터 합치기
    final allPlans = [...dummyPlans, ...userPlans];

    return Scaffold(
      appBar: AppBar(title: const Text('내 계획 (더미 데이터 + 내 데이터)')),
      body: ListView.builder(
        itemCount: allPlans.length,
        itemBuilder: (context, index) {
          final p = allPlans[index];
          // 이미지가 없으면 default.png 사용
          final imageUrl = (p.imageUrl == null || p.imageUrl!.isEmpty)
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
          onPressed: _addPlan,
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
