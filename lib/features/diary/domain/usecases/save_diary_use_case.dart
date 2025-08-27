import '../../../../core/usecases/common_use_case.dart';
import '../entities/diary_entry_entity.dart';
import '../repositories/diary_repository.dart';

class SaveDiaryUseCase implements CommonUseCase<void, DiaryEntryEntity> {
  final DiaryRepository repository;
  SaveDiaryUseCase(this.repository);

  @override
  Future<void> call(DiaryEntryEntity params) => repository.save(params);
}
