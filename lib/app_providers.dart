import 'package:provider/provider.dart';
import 'features/plan/domain/usecases/get_plans_use_case.dart';
import 'features/plan/domain/usecases/save_plan_use_case.dart';
import 'features/plan/domain/usecases/delete_plan_use_case.dart';
import 'features/plan/domain/repositories/plan_repository.dart';
import 'features/plan/data/repositories/plan_repository_impl.dart';
import 'features/plan/data/datasource/plan_remote_data_source.dart';
// 실제 구현체 import
import 'features/plan/data/datasource/plan_remote_data_source_impl.dart';
// Diary imports
import 'features/diary/data/datasource/diary_local_data_source.dart';
import 'features/diary/data/datasource/diary_local_data_source_impl.dart';
import 'features/diary/domain/repositories/diary_repository.dart';
import 'features/diary/data/repositories/diary_repository_impl.dart';
import 'features/diary/domain/usecases/get_diary_by_month_use_case.dart';
import 'features/diary/domain/usecases/save_diary_use_case.dart';

final appProviders = [
  // PlanRemoteDataSource Provider 추가 (구현체로 대체)
  Provider<PlanRemoteDataSource>(create: (_) => PlanRemoteDataSourceImpl()),
  Provider<PlanRepository>(
    create:
        (context) => PlanRepositoryImpl(context.read<PlanRemoteDataSource>()),
  ),
  Provider<GetPlansUseCase>(
    create: (context) => GetPlansUseCase(context.read<PlanRepository>()),
  ),
  Provider<SavePlanUseCase>(
    create: (context) => SavePlanUseCase(context.read<PlanRepository>()),
  ),
  Provider<DeletePlanUseCase>(
    create: (context) => DeletePlanUseCase(context.read<PlanRepository>()),
  ),
  // Diary providers
  Provider<DiaryLocalDataSource>(create: (_) => DiaryLocalDataSourceImpl()),
  Provider<DiaryRepository>(
    create:
        (context) => DiaryRepositoryImpl(context.read<DiaryLocalDataSource>()),
  ),
  Provider<GetDiaryByMonthUseCase>(
    create:
        (context) => GetDiaryByMonthUseCase(context.read<DiaryRepository>()),
  ),
  Provider<SaveDiaryUseCase>(
    create: (context) => SaveDiaryUseCase(context.read<DiaryRepository>()),
  ),
  // 다른 Provider도 여기에 추가
];
