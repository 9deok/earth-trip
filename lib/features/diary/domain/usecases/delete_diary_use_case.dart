import '../../../../core/usecases/common_use_case.dart';
import '../repositories/diary_repository.dart';

class DeleteDiaryUseCase implements CommonUseCase<void, String> {
  final DiaryRepository repository;
  DeleteDiaryUseCase(this.repository);

  @override
  Future<void> call(String id) => repository.delete(id);
}
