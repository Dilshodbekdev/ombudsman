import 'package:ombudsman/src/core/resources/data_state.dart';
import 'package:ombudsman/src/features/reference/data/body/create_appeal_body.dart';
import 'package:ombudsman/src/features/reference/data/model/appeal_model.dart';
import 'package:ombudsman/src/features/reference/data/model/appeal_type_model.dart';
import 'package:ombudsman/src/features/reference/data/model/create_appeal_model.dart';
import 'package:ombudsman/src/features/reference/data/model/region_model.dart';
import 'package:ombudsman/src/features/reference/data/model/requirment_model.dart';
import 'package:ombudsman/src/features/reference/data/model/status_model.dart';

abstract class AppealRepository {
  Future<DataState<List<RegionModel>>> regionList();
  Future<DataState<List<RequirmentModel>>> requirments();

  Future<DataState<List<StatusModel>>> statuses();

  Future<DataState<List<StatusModel>>> genders();

  Future<DataState<List<StatusModel>>> maritalStatuses();

  Future<DataState<List<StatusModel>>> citizenship();

  Future<DataState<CreateAppealModel>> createAppeal(CreateAppealBody body);

  Future<DataState<List<AppealModel>>> appealList();
  Future<DataState<List<AppealTypeModel>>> appealTypes();
}
