import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ombudsman/src/core/app_state/cubit/app_cubit.dart';
import 'package:ombudsman/src/core/network/api_interceptor.dart';
import 'package:ombudsman/src/features/auth/data/data_source/auth_api_service.dart';
import 'package:ombudsman/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:ombudsman/src/features/auth/domain/repository/auth_repository.dart';
import 'package:ombudsman/src/features/auth/domain/use_case/one_id_use_case.dart';
import 'package:ombudsman/src/features/auth/presentation/manager/auth_bloc.dart';
import 'package:ombudsman/src/features/home/data/data_source/home_api_service.dart';
import 'package:ombudsman/src/features/home/data/repository/home_repository_impl.dart';
import 'package:ombudsman/src/features/home/domain/repository/home_repository.dart';
import 'package:ombudsman/src/features/home/domain/use_case/category_use_case.dart';
import 'package:ombudsman/src/features/home/domain/use_case/faq_use_case.dart';
import 'package:ombudsman/src/features/home/domain/use_case/create_questionnaire_use_case.dart';
import 'package:ombudsman/src/features/home/domain/use_case/first_article_use_case.dart';
import 'package:ombudsman/src/features/home/domain/use_case/leadership_use_case.dart';
import 'package:ombudsman/src/features/home/domain/use_case/management_use_case.dart';
import 'package:ombudsman/src/features/home/domain/use_case/news_use_case.dart';
import 'package:ombudsman/src/features/home/domain/use_case/notifications_use_case.dart';
import 'package:ombudsman/src/features/home/domain/use_case/questionnaire_use_case.dart';
import 'package:ombudsman/src/features/home/domain/use_case/statistic_use_case.dart';
import 'package:ombudsman/src/features/home/domain/use_case/update_notify_use_case.dart';
import 'package:ombudsman/src/features/home/presentation/manager/home_bloc.dart';
import 'package:ombudsman/src/features/reference/data/data_source/appeal_api_service.dart';
import 'package:ombudsman/src/features/reference/data/repository/appeal_repository_impl.dart';
import 'package:ombudsman/src/features/reference/domain/repository/appeal_repository.dart';
import 'package:ombudsman/src/features/reference/domain/use_case/appeal_list_use_case.dart';
import 'package:ombudsman/src/features/reference/domain/use_case/appeal_types_use_case.dart';
import 'package:ombudsman/src/features/reference/domain/use_case/citizenship_use_case.dart';
import 'package:ombudsman/src/features/reference/domain/use_case/genders_use_case.dart';
import 'package:ombudsman/src/features/reference/domain/use_case/marital_statuses_use_case.dart';
import 'package:ombudsman/src/features/reference/domain/use_case/requirment_list_use_case.dart';
import 'package:ombudsman/src/features/reference/domain/use_case/statuses_use_case.dart';
import 'package:ombudsman/src/features/reference/domain/use_case/create_appeal_use_case.dart';
import 'package:ombudsman/src/features/reference/domain/use_case/region_list_use_case.dart';
import 'package:ombudsman/src/features/reference/presentation/manager/appeal_bloc.dart';

final GetIt locator = GetIt.instance;

Future<void> initializeDependencies() async {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://omd2.technocorp.uz/",
      contentType: "application/json",
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60 * 1000),
      receiveTimeout: const Duration(seconds: 60 * 1000),
      listFormat: ListFormat.multiCompatible,
    ),
  );

  dio.interceptors.add(ApiInterceptor());
  locator.registerSingleton<Dio>(dio);

  locator.registerFactory(() => AppCubit());

  // Services
  locator.registerSingleton(AuthApiService(locator()));
  locator.registerSingleton(HomeApiService(locator()));
  locator.registerSingleton(AppealApiService(locator()));

  // Repositories
  locator.registerSingleton<AuthRepository>(AuthRepositoryImpl(locator()));
  locator.registerSingleton<HomeRepository>(HomeRepositoryImpl(locator()));
  locator.registerSingleton<AppealRepository>(AppealRepositoryImpl(locator()));

  // Auth UseCases
  locator.registerSingleton(OneIdUseCase(locator()));

  // Home UseCases
  locator.registerSingleton(FaqUseCase(locator()));
  locator.registerSingleton(LeadershipUseCase(locator()));
  locator.registerSingleton(ManagementUseCase(locator()));
  locator.registerSingleton(NewsUseCase(locator()));
  locator.registerSingleton(StatisticUseCase(locator()));
  locator.registerSingleton(CategoryUseCase(locator()));
  locator.registerSingleton(FirstArticleUseCase(locator()));
  locator.registerSingleton(QuestionnaireUseCase(locator()));
  locator.registerSingleton(CreateQuestionnaireUseCase(locator()));
  locator.registerSingleton(NotificationsUseCase(locator()));
  locator.registerSingleton(UpdateNotifyUseCase(locator()));

  // Reference UseCase
  locator.registerSingleton(RegionListUseCase(locator()));
  locator.registerSingleton(StatusesUseCase(locator()));
  locator.registerSingleton(GendersUseCase(locator()));
  locator.registerSingleton(MaritalStatusesUseCase(locator()));
  locator.registerSingleton(CitizenshipUseCase(locator()));
  locator.registerSingleton(AppealListUseCase(locator()));
  locator.registerSingleton(AppealTypesUseCase(locator()));
  locator.registerSingleton(CreateAppealUseCase(locator()));
  locator.registerSingleton(RequirmentListUseCase(locator()));

  // Profile UseCase

  // Blocs
  locator.registerFactory<AuthBloc>(
    () => AuthBloc(
      locator(),
    ),
  );

  locator.registerFactory<HomeBloc>(() => HomeBloc(
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  locator.registerFactory<AppealBloc>(
    () => AppealBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
}
