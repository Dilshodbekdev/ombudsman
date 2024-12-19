import 'package:ombudsman/src/core/resources/data_state.dart';
import 'package:ombudsman/src/core/usecase/use_case.dart';
import 'package:ombudsman/src/features/home/data/models/category_model.dart';
import 'package:ombudsman/src/features/home/domain/repository/home_repository.dart';

class CategoryUseCase implements UseCase<DataState<List<CategoryModel>>, int> {
  final HomeRepository _repository;

  CategoryUseCase(this._repository);

  @override
  Future<DataState<List<CategoryModel>>> call({required int params}) async =>
      await _repository.category();
}
