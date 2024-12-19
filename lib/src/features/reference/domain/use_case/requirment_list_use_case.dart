import 'package:ombudsman/src/core/resources/data_state.dart';
import 'package:ombudsman/src/core/usecase/use_case.dart';
import 'package:ombudsman/src/features/reference/data/model/region_model.dart';
import 'package:ombudsman/src/features/reference/data/model/requirment_model.dart';
import 'package:ombudsman/src/features/reference/domain/repository/appeal_repository.dart';

class RequirmentListUseCase implements UseCase<DataState<List<RequirmentModel>>, int> {
  final AppealRepository _repository;

  RequirmentListUseCase(this._repository);

  @override
  Future<DataState<List<RequirmentModel>>> call({required int params}) async =>
      await _repository.requirments();
}
