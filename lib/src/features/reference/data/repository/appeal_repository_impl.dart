import 'package:ombudsman/src/core/resources/base_repository.dart';
import 'package:ombudsman/src/core/resources/data_state.dart';
import 'package:ombudsman/src/features/reference/data/body/create_appeal_body.dart';
import 'package:ombudsman/src/features/reference/data/data_source/appeal_api_service.dart';
import 'package:ombudsman/src/features/reference/data/model/appeal_model.dart';
import 'package:ombudsman/src/features/reference/data/model/appeal_type_model.dart';
import 'package:ombudsman/src/features/reference/data/model/create_appeal_model.dart';
import 'package:ombudsman/src/features/reference/data/model/region_model.dart';
import 'package:ombudsman/src/features/reference/data/model/requirment_model.dart';
import 'package:ombudsman/src/features/reference/data/model/status_model.dart';
import 'package:ombudsman/src/features/reference/domain/repository/appeal_repository.dart';

class AppealRepositoryImpl with BaseRepository implements AppealRepository {
  final AppealApiService _apiService;

  AppealRepositoryImpl(this._apiService);

  @override
  Future<DataState<List<RegionModel>>> regionList() async =>
      await handleResponse(response: _apiService.regionList());

  @override
  Future<DataState<CreateAppealModel>> createAppeal(
          CreateAppealBody body) async =>
      await handleResponse(
          response: _apiService.createAppeal(
              body.email,
              body.phone,
              body.marital_status,
              body.is_juridical,
              body.text,
              body.gender,
              body.juridical_name,
              body.status,
              body.citizenship,
              body.region_id,
              body.district_id,
              body.appeal_type,
              body.address,
              body.file,
          ));

  @override
  Future<DataState<List<AppealModel>>> appealList() async =>
      await handleResponse(response: _apiService.appealList());

  @override
  Future<DataState<List<StatusModel>>> statuses() async =>
      await handleResponse(response: _apiService.statuses());

  @override
  Future<DataState<List<StatusModel>>> genders() async =>
      await handleResponse(response: _apiService.genders());

  @override
  Future<DataState<List<StatusModel>>> maritalStatuses() async =>
      await handleResponse(response: _apiService.maritalStatuses());

  @override
  Future<DataState<List<StatusModel>>> citizenship() async =>
      await handleResponse(response: _apiService.citizenship());

  @override
  Future<DataState<List<AppealTypeModel>>> appealTypes() async=>
      await handleResponse(response: _apiService.appealTypes());

  @override
  Future<DataState<List<RequirmentModel>>> requirments()async=>
      await handleResponse(response: _apiService.requirments());
}
