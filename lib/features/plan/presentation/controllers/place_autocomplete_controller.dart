import 'package:flutter/foundation.dart';

class PlaceAutocompleteController extends ChangeNotifier {
  final List<String> _allPlaces = const [
    '서울',
    '부산',
    '제주',
    '도쿄',
    '오사카',
    '파리',
    '런던',
    '뉴욕',
    '로마',
    '방콕',
    '싱가포르',
  ];

  List<String> _suggestions = const [];
  List<String> get suggestions => _suggestions;
  int _debounceMs = 200;
  int _lastIssued = 0;

  void updateQuery(String value, List<String> alreadySelected) {
    final now = DateTime.now().microsecondsSinceEpoch;
    _lastIssued = now;
    Future.delayed(Duration(milliseconds: _debounceMs), () {
      if (_lastIssued != now) return;
      if (value.isEmpty) {
        _suggestions = const [];
      } else {
        _suggestions = _allPlaces
            .where(
              (place) =>
                  place.contains(value) && !alreadySelected.contains(place),
            )
            .toList(growable: false);
      }
      notifyListeners();
    });
  }

  void clear() {
    _suggestions = const [];
    notifyListeners();
  }
}
