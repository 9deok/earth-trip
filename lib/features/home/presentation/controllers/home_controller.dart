import 'package:flutter/foundation.dart';
import '../../domain/entities/destination_entity.dart';
import '../../domain/usecases/get_destinations_use_case.dart';

class HomeController extends ChangeNotifier {
  final GetDestinationsUseCase getDestinationsUseCase;

  HomeController({required this.getDestinationsUseCase});

  List<DestinationEntity> destinations = [];
  bool isLoading = false;

  Future<void> loadDestinations() async {
    isLoading = true;
    notifyListeners();

    destinations = await getDestinationsUseCase.call(null);

    isLoading = false;
    notifyListeners();
  }
}
