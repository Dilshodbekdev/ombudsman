import 'package:ombudsman/src/core/resources/base_repository.dart';
import 'package:ombudsman/src/core/resources/data_state.dart';
import 'package:ombudsman/src/features/home/data/body/voting_body.dart';
import 'package:ombudsman/src/features/home/data/data_source/home_api_service.dart';
import 'package:ombudsman/src/features/home/data/models/category_model.dart';
import 'package:ombudsman/src/features/home/data/models/end_question_model.dart';
import 'package:ombudsman/src/features/home/data/models/faq_model.dart';
import 'package:ombudsman/src/features/home/data/models/leadership_model.dart';
import 'package:ombudsman/src/features/home/data/models/management_model.dart';
import 'package:ombudsman/src/features/home/data/models/news_model.dart';
import 'package:ombudsman/src/features/home/data/models/notification_model.dart';
import 'package:ombudsman/src/features/home/data/models/questionnaire_model.dart';
import 'package:ombudsman/src/features/home/data/models/sent_vote_model.dart';
import 'package:ombudsman/src/features/home/data/models/statistic_model.dart';
import 'package:ombudsman/src/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl with BaseRepository implements HomeRepository {
  final HomeApiService _apiService;

  HomeRepositoryImpl(this._apiService);

  @override
  Future<DataState<List<FaqModel>>> faq() async =>
      await handleResponse(response: _apiService.faq());

  @override
  Future<DataState<List<LeadershipModel>>> leadership() async=>
      await handleResponse(response: _apiService.leadership());

  @override
  Future<DataState<EndQuestionModel>> questionnaire() async =>
      await handleResponse(response: _apiService.questionnaire());

  @override
  Future<DataState<NewsModel>> news(int page) async =>
      await handleResponse(response: _apiService.news(page));

  @override
  Future<DataState<NewModel>> firstArticle(String lang) async =>
      await handleResponse(response: _apiService.firstArticle(lang));

  @override
  Future<DataState<StatisticModel>> statistic() async =>
      await handleResponse(response: _apiService.statistic());

  @override
  Future<DataState<List<CategoryModel>>> category() async =>
      await handleResponse(response: _apiService.category());

  @override
  Future<DataState<List<ManagementModel>>> management(int id) async =>
      await handleResponse(response: _apiService.management(id));

  @override
  Future<DataState<SentVoteModel>> createQuestionnaire(
          VotingBody body) async =>
      await handleResponse(response: _apiService.createQuestionnaire(body));

  @override
  Future<DataState<List<NotificationModel>>> notifications() async=>
      await handleResponse(response: _apiService.notifications());

  @override
  Future<DataState<SentVoteModel>> updateNotify(int id) async=>
      await handleResponse(response: _apiService.updateNotify(id));
}
