import 'package:ombudsman/src/core/resources/data_state.dart';
import 'package:ombudsman/src/core/usecase/use_case.dart';
import 'package:ombudsman/src/features/home/data/models/news_model.dart';
import 'package:ombudsman/src/features/home/domain/repository/home_repository.dart';

class FirstArticleUseCase implements UseCase<DataState<NewModel>, String> {
  final HomeRepository _repository;

  FirstArticleUseCase(this._repository);

  @override
  Future<DataState<NewModel>> call({required String params}) async =>
      await _repository.firstArticle(params);
}
