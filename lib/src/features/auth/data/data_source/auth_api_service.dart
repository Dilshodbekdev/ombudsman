import 'package:dio/dio.dart';
import 'package:ombudsman/src/features/auth/data/models/one_id_model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  /// URLS
  static const String _oneId = 'api/signin';

  /// REQUESTS
  @POST(_oneId)
  Future<HttpResponse<OneIdModel>> oneId(@Query("code") String code);
}
