import 'package:ombudsman/src/core/resources/data_state.dart';
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

abstract class HomeRepository {
  Future<DataState<List<FaqModel>>> faq();

  Future<DataState<List<LeadershipModel>>> leadership();

  Future<DataState<EndQuestionModel>> questionnaire();

  Future<DataState<SentVoteModel>> createQuestionnaire(VotingBody body);

  Future<DataState<NewsModel>> news(int page);

  Future<DataState<List<NotificationModel>>> notifications();

  Future<DataState<SentVoteModel>> updateNotify(int id);

  Future<DataState<NewModel>> firstArticle(String lang);

  Future<DataState<StatisticModel>> statistic();

  Future<DataState<List<CategoryModel>>> category();

  Future<DataState<List<ManagementModel>>> management(int id);
}
