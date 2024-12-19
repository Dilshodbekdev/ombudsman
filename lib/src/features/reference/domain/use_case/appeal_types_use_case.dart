import 'package:ombudsman/src/core/resources/data_state.dart';
import 'package:ombudsman/src/core/usecase/use_case.dart';
import 'package:ombudsman/src/features/reference/data/model/appeal_model.dart';
import 'package:ombudsman/src/features/reference/data/model/appeal_type_model.dart';
import 'package:ombudsman/src/features/reference/domain/repository/appeal_repository.dart';

class AppealTypesUseCase implements UseCase<DataState<List<AppealTypeModel>>, int> {
  final AppealRepository _repository;

  AppealTypesUseCase(this._repository);

  @override
  Future<DataState<List<AppealTypeModel>>> call({required int params}) async =>
      await _repository.appealTypes();
}
