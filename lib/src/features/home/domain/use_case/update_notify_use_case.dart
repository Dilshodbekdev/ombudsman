import 'package:ombudsman/src/core/resources/data_state.dart';
import 'package:ombudsman/src/core/usecase/use_case.dart';
import 'package:ombudsman/src/features/home/data/models/sent_vote_model.dart';
import 'package:ombudsman/src/features/home/domain/repository/home_repository.dart';

class UpdateNotifyUseCase implements UseCase<DataState<SentVoteModel>, int> {
  final HomeRepository _repository;

  UpdateNotifyUseCase(this._repository);

  @override
  Future<DataState<SentVoteModel>> call({required int params}) async =>
      await _repository.updateNotify(params);
}
