import '../../domain/entities/destination_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<DestinationEntity>> fetchRecommendedDestinations();
}
