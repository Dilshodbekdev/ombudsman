import 'package:ombudsman/src/core/resources/data_state.dart';
import 'package:ombudsman/src/core/usecase/use_case.dart';
import 'package:ombudsman/src/features/reference/data/model/status_model.dart';
import 'package:ombudsman/src/features/reference/domain/repository/appeal_repository.dart';

class StatusesUseCase implements UseCase<DataState<List<StatusModel>>, int> {
  final AppealRepository _repository;

  StatusesUseCase(this._repository);

  @override
  Future<DataState<List<StatusModel>>> call({required int params}) async =>
      await _repository.statuses();
}
