import 'home_remote_data_source.dart';
import '../dummy_home_data.dart';
import '../../domain/entities/destination_entity.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<DestinationEntity>> fetchRecommendedDestinations() async {
    // In a real app this would fetch from network
    return DummyHomeData.fetchRecommendedDestinations();
  }
}
