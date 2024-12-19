import 'package:ombudsman/src/core/resources/data_state.dart';
import 'package:ombudsman/src/core/usecase/use_case.dart';
import 'package:ombudsman/src/features/home/data/models/end_question_model.dart';
import 'package:ombudsman/src/features/home/domain/repository/home_repository.dart';

class QuestionnaireUseCase
    implements UseCase<DataState<EndQuestionModel>, int> {
  final HomeRepository _repository;

  QuestionnaireUseCase(this._repository);

  @override
  Future<DataState<EndQuestionModel>> call({required int params}) async =>
      await _repository.questionnaire();
}
