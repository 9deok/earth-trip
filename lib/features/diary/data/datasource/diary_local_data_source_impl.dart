import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/diary_entry_entity.dart';
import 'diary_local_data_source.dart';

class DiaryLocalDataSourceImpl implements DiaryLocalDataSource {
  static const _key = 'diaryEntries';

  @override
  Future<void> delete(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return;
    final list = List<Map<String, dynamic>>.from(jsonDecode(raw));
    list.removeWhere((e) => e['id'] == id);
    await prefs.setString(_key, jsonEncode(list));
  }

  @override
  Future<List<DiaryEntryEntity>> listByMonth(int year, int month) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final list = List<Map<String, dynamic>>.from(jsonDecode(raw));
    final entries =
        list
            .map(DiaryEntryEntity.fromJson)
            .where((e) => e.date.year == year && e.date.month == month)
            .toList();
    entries.sort((a, b) => a.date.compareTo(b.date));
    return entries;
  }

  @override
  Future<List<DiaryEntryEntity>> listByPlan(String planId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final list = List<Map<String, dynamic>>.from(jsonDecode(raw));
    final entries =
        list
            .map(DiaryEntryEntity.fromJson)
            .where((e) => e.planId == planId)
            .toList();
    entries.sort((a, b) => a.date.compareTo(b.date));
    return entries;
  }

  @override
  Future<List<DiaryEntryEntity>> listAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final list = List<Map<String, dynamic>>.from(jsonDecode(raw));
    final entries = list.map(DiaryEntryEntity.fromJson).toList();
    entries.sort((a, b) => a.date.compareTo(b.date));
    return entries;
  }

  @override
  Future<void> save(DiaryEntryEntity entry) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    final list =
        raw == null
            ? <Map<String, dynamic>>[]
            : List<Map<String, dynamic>>.from(jsonDecode(raw));
    final idx = list.indexWhere((e) => e['id'] == entry.id);
    final map = entry.toJson();
    if (idx >= 0) {
      list[idx] = map;
    } else {
      list.add(map);
    }
    await prefs.setString(_key, jsonEncode(list));
  }
}
