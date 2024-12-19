import 'package:ombudsman/src/core/resources/data_state.dart';
import 'package:ombudsman/src/core/usecase/use_case.dart';
import 'package:ombudsman/src/features/home/data/models/category_model.dart';
import 'package:ombudsman/src/features/home/data/models/management_model.dart';
import 'package:ombudsman/src/features/home/domain/repository/home_repository.dart';

class ManagementUseCase
    implements UseCase<DataState<List<ManagementModel>>, int> {
  final HomeRepository _repository;

  ManagementUseCase(this._repository);

  @override
  Future<DataState<List<ManagementModel>>> call({required int params}) async =>
      await _repository.management(params);
}
