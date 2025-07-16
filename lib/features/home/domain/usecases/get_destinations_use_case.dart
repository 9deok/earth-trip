import '../../../../core/usecases/common_use_case.dart';
import '../entities/destination_entity.dart';
import '../repositories/home_repository.dart';

class GetDestinationsUseCase
    implements CommonUseCase<List<DestinationEntity>, void> {
  final HomeRepository repository;
  GetDestinationsUseCase(this.repository);

  @override
  Future<List<DestinationEntity>> call(void params) {
    return repository.getRecommendedDestinations();
  }
}
