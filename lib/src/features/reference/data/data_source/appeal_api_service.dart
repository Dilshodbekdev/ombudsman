import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ombudsman/src/features/reference/data/model/appeal_model.dart';
import 'package:ombudsman/src/features/reference/data/model/appeal_type_model.dart';
import 'package:ombudsman/src/features/reference/data/model/create_appeal_model.dart';
import 'package:ombudsman/src/features/reference/data/model/region_model.dart';
import 'package:ombudsman/src/features/reference/data/model/requirment_model.dart';
import 'package:ombudsman/src/features/reference/data/model/status_model.dart';
import 'package:retrofit/retrofit.dart';

part 'appeal_api_service.g.dart';

@RestApi()
abstract class AppealApiService {
  factory AppealApiService(Dio dio, {String baseUrl}) = _AppealApiService;

  /// URLS

  static const String _createAppeal = 'api/sendRequest';
  static const String _appealList = 'api/appeals';
  static const String _regionList = 'api/regions';
  static const String _requirments = 'api/requirments';
  static const String _statuses = 'api/getStatus';
  static const String _genders = 'api/getGenderName';
  static const String _citizenship = 'api/getCitizenshipName';
  static const String _maritalStatuses = 'api/getMaritalStatusName';
  static const String _appealTypes = 'api/appealType';

  @GET(_regionList)
  Future<HttpResponse<List<RegionModel>>> regionList();

  @GET(_requirments)
  Future<HttpResponse<List<RequirmentModel>>> requirments();

  @GET(_statuses)
  Future<HttpResponse<List<StatusModel>>> statuses();

  @GET(_genders)
  Future<HttpResponse<List<StatusModel>>> genders();

  @GET(_citizenship)
  Future<HttpResponse<List<StatusModel>>> citizenship();

  @GET(_maritalStatuses)
  Future<HttpResponse<List<StatusModel>>> maritalStatuses();

  @POST(_createAppeal)
  @MultiPart()
  Future<HttpResponse<CreateAppealModel>> createAppeal(
    @Part() String? email,
    @Part() String? phone,
    @Part() int? marital_status,
    @Part() String? is_juridical,
    @Part() String? text,
    @Part() String? gender,
    @Part() String? juridical_name,
    @Part() int? status,
    @Part() int? citizenship,
    @Part() int? region_id,
    @Part() int? district_id,
    @Part() String? appeal_type,
    @Part() String? address,
    @Part() File? file,
  );

  @GET(_appealList)
  Future<HttpResponse<List<AppealModel>>> appealList();

  @GET(_appealTypes)
  Future<HttpResponse<List<AppealTypeModel>>> appealTypes();
}
