import 'package:flutter/foundation.dart';
import '../../domain/entities/plan_entity.dart';
import '../../domain/usecases/get_plans_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PlanController extends ChangeNotifier {
  final GetPlansUseCase getPlansUseCase;
  List<PlanEntity> plans = [];
  bool isLoading = false;

  PlanController({required this.getPlansUseCase});

  Future<void> loadPlans() async {
    isLoading = true;
    notifyListeners();

    plans = await getPlansUseCase.call(null);

    isLoading = false;
    notifyListeners();
  }

  Future<void> deletePlan(String id) async {
    plans.removeWhere((plan) => plan.id == id);
    await _saveUserPlansToStorage();
    notifyListeners();
    // 필요시 서버/DB 연동 삭제 로직 추가
  }

  Future<void> _saveUserPlansToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    // 더미 데이터와 구분: 사용자 생성 플랜만 저장 (id가 'dummy-'로 시작하지 않는 것만)
    final userPlans = plans.where((plan) => !plan.id.startsWith('dummy-')).toList();
    final userPlansJson = jsonEncode(userPlans.map((e) => e.toJson()).toList());
    await prefs.setString('userPlans', userPlansJson);
  }
}