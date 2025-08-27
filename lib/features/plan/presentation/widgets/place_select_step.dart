import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'styles/place_select_step_styles.dart';
import '../controllers/place_autocomplete_controller.dart';

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
  List<String> _suggestions = [];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlaceAutocompleteController(),
      child: Consumer<PlaceAutocompleteController>(
        builder: (ctx, ac, _) {
          final suggestions = ac.suggestions;
          _suggestions = suggestions; // keep local for direct-add condition
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '여행 장소를 입력하세요',
                style: PlaceSelectStepStyles.titleStyle,
              ),
              PlaceSelectStepStyles.titleSpacing,
              Wrap(
                spacing: 8,
                children:
                    widget.selectedPlaces
                        .map(
                          (place) => Chip(
                            label: Text(place),
                            onDeleted: () => widget.onPlaceRemoved(place),
                          ),
                        )
                        .toList(),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: '장소 입력',
                  border: OutlineInputBorder(),
                ),
                onChanged:
                    (value) => ac.updateQuery(value, widget.selectedPlaces),
              ),
              if (suggestions.isNotEmpty)
                ...suggestions.map(
                  (place) => ListTile(
                    title: Text(place),
                    onTap: () {
                      widget.onPlaceSelected(place);
                      _controller.clear();
                      ac.clear();
                    },
                  ),
                ),
              // 직접 입력 버튼 추가
              if (_controller.text.isNotEmpty &&
                  !suggestions.contains(_controller.text) &&
                  !widget.selectedPlaces.contains(_controller.text))
                ListTile(
                  title: Text('"${_controller.text}" 직접 추가'),
                  leading: const Icon(Icons.add),
                  onTap: () async {
                    final customPlace = _controller.text.trim();
                    if (customPlace.isNotEmpty) {
                      widget.onPlaceSelected(customPlace);
                      _controller.clear();
                      ac.clear();
                    }
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
