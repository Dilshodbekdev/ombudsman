import 'package:ombudsman/src/core/resources/data_state.dart';
import 'package:ombudsman/src/core/usecase/use_case.dart';
import 'package:ombudsman/src/features/home/data/models/leadership_model.dart';

import 'package:ombudsman/src/features/home/domain/repository/home_repository.dart';

class LeadershipUseCase implements UseCase<DataState<List<LeadershipModel>>, int> {
  final HomeRepository _repository;

  LeadershipUseCase(this._repository);

  @override
  Future<DataState<List<LeadershipModel>>> call({required int params}) async =>
      await _repository.leadership();
}
