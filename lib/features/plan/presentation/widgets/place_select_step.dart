import 'package:flutter/material.dart';

class PlaceSelectStep extends StatefulWidget {
  final List<String> selectedPlaces;
  final ValueChanged<String> onPlaceSelected;
  final ValueChanged<String> onPlaceRemoved;

  const PlaceSelectStep({
    super.key,
    required this.selectedPlaces,
    required this.onPlaceSelected,
    required this.onPlaceRemoved,
  });

  @override
  State<PlaceSelectStep> createState() => _PlaceSelectStepState();
}

class _PlaceSelectStepState extends State<PlaceSelectStep> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _allPlaces = [
    '서울', '부산', '제주', '도쿄', '오사카', '파리', '런던', '뉴욕', '로마', '방콕', '싱가포르'
  ];
  List<String> _suggestions = [];

  void _onTextChanged(String value) {
    setState(() {
      _suggestions = _allPlaces
          .where((place) =>
              place.contains(value) && !widget.selectedPlaces.contains(place))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '여행 장소를 입력하세요',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: widget.selectedPlaces
              .map((place) => Chip(
                    label: Text(place),
                    onDeleted: () => widget.onPlaceRemoved(place),
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: '장소 입력',
            border: OutlineInputBorder(),
          ),
          onChanged: _onTextChanged,
        ),
        if (_suggestions.isNotEmpty)
          ..._suggestions
              .map(
                (place) => ListTile(
                  title: Text(place),
                  onTap: () {
                    widget.onPlaceSelected(place);
                    _controller.clear();
                    setState(() {
                      _suggestions.clear();
                    });
                  },
                ),
              )
              ,
        // 직접 입력 버튼 추가
        if (_controller.text.isNotEmpty &&
            !_allPlaces.contains(_controller.text) &&
            !_suggestions.contains(_controller.text))
          ListTile(
            title: Text('"${_controller.text}" 직접 추가'),
            leading: const Icon(Icons.add),
            onTap: () async {
              final customPlace = _controller.text.trim();
              if (customPlace.isNotEmpty) {
                widget.onPlaceSelected(customPlace);
                _controller.clear();
                setState(() {
                  _suggestions.clear();
                });
              }
            },
          ),
      ],
    );
  }
}