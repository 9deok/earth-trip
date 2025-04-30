import 'package:earth_trip/features/plan/data/datasource/plan_remote_data_source.dart';
import 'package:earth_trip/features/plan/domain/entities/plan_entity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/place_select_step.dart';
import '../widgets/date_range_select_step.dart';

class AddPlanPage extends StatefulWidget {
  const AddPlanPage({super.key});

  @override
  State<AddPlanPage> createState() => _AddPlanPageState();
}

class _AddPlanPageState extends State<AddPlanPage> {
  int _step = 0;
  final List<String> _selectedPlaces = [];
  DateTimeRange? _selectedDateRange;

  void _nextStep() {
    setState(() {
      _step++;
    });
  }

  void _prevStep() {
    if (_step > 0) {
      setState(() {
        _step--;
      });
    }
  }

  void _onPlaceSelected(String place) {
    if (!_selectedPlaces.contains(place)) {
      setState(() {
        _selectedPlaces.add(place);
      });
    }
  }

  void _onPlaceRemoved(String place) {
    setState(() {
      _selectedPlaces.remove(place);
    });
  }

  void _onDateRangeSelected(DateTimeRange range) {
    setState(() {
      _selectedDateRange = range;
    });
  }

  Future<void> _onComplete() async {
    if (_selectedPlaces.isNotEmpty && _selectedDateRange != null) {
      final plan = PlanEntity(
        title: _selectedPlaces.first,
        start: _selectedDateRange!.start,
        end: _selectedDateRange!.end,
        cost: 0,
        daysLeft: _selectedDateRange!.start.difference(DateTime.now()).inDays,
        flightDuration: '',
        stayDuration: '',
        likes: 0,
        participants: 1,
      );
      final dataSource = context.read<PlanRemoteDataSource>();
      await dataSource.saveUserPlan(plan);
      Navigator.pop(context, plan);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget stepWidget;
    if (_step == 0) {
      stepWidget = PlaceSelectStep(
        selectedPlaces: _selectedPlaces,
        onPlaceSelected: _onPlaceSelected,
        onPlaceRemoved: _onPlaceRemoved,
      );
    } else {
      stepWidget = DateRangeSelectStep(
        selectedRange: _selectedDateRange,
        onRangeSelected: _onDateRangeSelected,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('여행 계획 추가'),
        leading:
            _step > 0
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _prevStep,
                )
                : null,
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child:
            (_step == 0)
                ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 24.0,
                    ),
                    child: stepWidget,
                  ),
                )
                : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 24.0,
                  ),
                  child: stepWidget,
                ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 24.0,
          right: 24.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 8,
        ),
        child: ElevatedButton(
          onPressed: () {
            if (_step == 0 && _selectedPlaces.isNotEmpty) {
              _nextStep();
            } else if (_step == 1 && _selectedDateRange != null) {
              _onComplete();
            }
          },
          child: Text(_step == 0 ? '다음' : '완료'),
        ),
      ),
    );
  }
}
