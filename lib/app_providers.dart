import 'package:provider/provider.dart';
import 'features/plan/domain/usecases/get_plans_use_case.dart';
import 'features/plan/domain/repositories/plan_repository.dart';
import 'features/plan/data/repositories/plan_repository_impl.dart';
import 'features/plan/data/datasource/plan_remote_data_source.dart';
// 실제 구현체 import
import 'features/plan/data/datasource/plan_remote_data_source_impl.dart';
import 'features/home/domain/usecases/get_destinations_use_case.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/data/datasource/home_remote_data_source.dart';
import 'features/home/data/datasource/home_remote_data_source_impl.dart';

final appProviders = [
  // PlanRemoteDataSource Provider 추가 (구현체로 대체)
  Provider<PlanRemoteDataSource>(create: (_) => PlanRemoteDataSourceImpl()),
  Provider<PlanRepository>(
    create: (context) => PlanRepositoryImpl(
      context.read<PlanRemoteDataSource>(),
    ),
  ),
  Provider<GetPlansUseCase>(
    create: (context) => GetPlansUseCase(context.read<PlanRepository>()),
  ),
  // Home feature providers
  Provider<HomeRemoteDataSource>(create: (_) => HomeRemoteDataSourceImpl()),
  Provider<HomeRepository>(
    create: (context) => HomeRepositoryImpl(
      context.read<HomeRemoteDataSource>(),
    ),
  ),
  Provider<GetDestinationsUseCase>(
    create: (context) =>
        GetDestinationsUseCase(context.read<HomeRepository>()),
  ),
  // 다른 Provider도 여기에 추가
];
