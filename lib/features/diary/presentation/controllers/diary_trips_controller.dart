import 'package:flutter/foundation.dart';

enum DiaryTripsFilter { all, hasEntries, hasRetro }

class DiaryTripsController extends ChangeNotifier {
  DiaryTripsFilter _filter = DiaryTripsFilter.all;

  DiaryTripsFilter get filter => _filter;

  void setFilter(DiaryTripsFilter value) {
    if (_filter == value) return;
    _filter = value;
    notifyListeners();
  }
}
