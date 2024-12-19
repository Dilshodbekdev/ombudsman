import 'package:ombudsman/src/core/resources/data_state.dart';
import 'package:ombudsman/src/core/usecase/use_case.dart';
import 'package:ombudsman/src/features/reference/data/model/region_model.dart';
import 'package:ombudsman/src/features/reference/domain/repository/appeal_repository.dart';

class RegionListUseCase implements UseCase<DataState<List<RegionModel>>, int> {
  final AppealRepository _repository;

  RegionListUseCase(this._repository);

  @override
  Future<DataState<List<RegionModel>>> call({required int params}) async =>
      await _repository.regionList();
}
