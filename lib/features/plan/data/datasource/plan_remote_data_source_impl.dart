import 'plan_remote_data_source.dart';
import '../../domain/entities/plan_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dummy_plan_data.dart';
import 'dart:convert';

class PlanRemoteDataSourceImpl implements PlanRemoteDataSource {
  @override
  Future<List<PlanEntity>> fetchUpcomingPlans() async {
    // 1. 더미 데이터 불러오기
    final dummyPlans = DummyPlanRepository.fetchUpcomingPlans();

    // 2. SharedPreferences에서 사용자 데이터 불러오기
    final prefs = await SharedPreferences.getInstance();
    final userPlansJson = prefs.getString('userPlans');
    List<PlanEntity> userPlans = [];
    if (userPlansJson != null) {
      final List<dynamic> decoded = jsonDecode(userPlansJson);
      userPlans = decoded.map((e) => PlanEntity.fromJson(e)).toList();
    }

    // 3. 더미 데이터 + 사용자 데이터 합치기
    return [...dummyPlans, ...userPlans];
  }

  @override
  Future<void> saveUserPlan(PlanEntity plan) async {
    final prefs = await SharedPreferences.getInstance();
    final userPlansJson = prefs.getString('userPlans');
    List<Map<String, dynamic>> userPlans = [];
    if (userPlansJson != null) {
      userPlans = List<Map<String, dynamic>>.from(jsonDecode(userPlansJson));
    }
    userPlans.add(plan.toJson());
    await prefs.setString('userPlans', jsonEncode(userPlans));
  }
}
