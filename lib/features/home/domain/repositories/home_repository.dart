import '../entities/destination_entity.dart';

abstract class HomeRepository {
  Future<List<DestinationEntity>> getRecommendedDestinations();
}
