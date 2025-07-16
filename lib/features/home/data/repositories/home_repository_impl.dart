import '../../domain/entities/destination_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasource/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<DestinationEntity>> getRecommendedDestinations() {
    return remoteDataSource.fetchRecommendedDestinations();
  }
}
