import 'package:dio/dio.dart';
import 'package:ombudsman/src/features/home/data/body/voting_body.dart';
import 'package:ombudsman/src/features/home/data/models/category_model.dart';
import 'package:ombudsman/src/features/home/data/models/end_question_model.dart';
import 'package:ombudsman/src/features/home/data/models/faq_model.dart';
import 'package:ombudsman/src/features/home/data/models/leadership_model.dart';
import 'package:ombudsman/src/features/home/data/models/management_model.dart';
import 'package:ombudsman/src/features/home/data/models/news_model.dart';
import 'package:ombudsman/src/features/home/data/models/notification_model.dart';
import 'package:ombudsman/src/features/home/data/models/sent_vote_model.dart';
import 'package:ombudsman/src/features/home/data/models/statistic_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api_service.g.dart';

@RestApi()
abstract class HomeApiService {
  factory HomeApiService(Dio dio, {String baseUrl}) = _HomeApiService;

  /// URLS
  static const String _faq = 'api/faq';
  static const String _news = 'api/lists';
  static const String _notifications = 'api/unread';
  static const String _updateNotify = 'api/update-notify/{id}';
  static const String _leadership = 'api/ombudsmanaboutleadersheep';
  static const String _category = 'api/management_category';
  static const String _management = 'api/management/{id}}';
  static const String _firstArticle = 'api/endNews/{lang}';
  static const String _statistic = 'api/statistic';
  static const String _questionnaire = 'api/endquestion';
  static const String _createQuestionnaire = 'api/sendVote';

  @GET(_faq)
  Future<HttpResponse<List<FaqModel>>> faq();

  @GET(_leadership)
  Future<HttpResponse<List<LeadershipModel>>> leadership();

  @GET(_questionnaire)
  Future<HttpResponse<EndQuestionModel>> questionnaire();

  @POST(_createQuestionnaire)
  Future<HttpResponse<SentVoteModel>> createQuestionnaire(@Body() VotingBody body);

  @GET(_news)
  Future<HttpResponse<NewsModel>> news(
    @Query('page') int p,
  );

  @GET(_notifications)
  Future<HttpResponse<List<NotificationModel>>> notifications();

  @PUT(_updateNotify)
  Future<HttpResponse<SentVoteModel>> updateNotify(@Path('id') int id);

  @GET(_firstArticle)
  Future<HttpResponse<NewModel>> firstArticle(@Path('lang') String lang);

  @GET(_statistic)
  Future<HttpResponse<StatisticModel>> statistic();

  @GET(_category)
  Future<HttpResponse<List<CategoryModel>>> category();

  @GET(_management)
  Future<HttpResponse<List<ManagementModel>>> management(@Path('id') int id);
}
