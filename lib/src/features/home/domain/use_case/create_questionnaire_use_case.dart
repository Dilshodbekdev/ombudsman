import 'package:ombudsman/src/core/resources/data_state.dart';
import 'package:ombudsman/src/core/usecase/use_case.dart';
import 'package:ombudsman/src/features/home/data/body/voting_body.dart';
import 'package:ombudsman/src/features/home/data/models/questionnaire_model.dart';
import 'package:ombudsman/src/features/home/data/models/sent_vote_model.dart';
import 'package:ombudsman/src/features/home/domain/repository/home_repository.dart';

class CreateQuestionnaireUseCase
    implements
        UseCase<DataState<SentVoteModel>, VotingBody> {
  final HomeRepository _repository;

  CreateQuestionnaireUseCase(this._repository);

  @override
  Future<DataState<SentVoteModel>> call(
          {required VotingBody params}) async =>
      await _repository.createQuestionnaire(params);
}
