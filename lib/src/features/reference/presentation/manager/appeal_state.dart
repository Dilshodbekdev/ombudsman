part of 'appeal_bloc.dart';

class AppealState {
  final List<RegionModel>? regionList;
  final List<RequirmentModel>? requirments;
  final List<RegionModel>? regions;
  final List<StatusModel>? statuses;
  final List<StatusModel>? genders;
  final List<StatusModel>? maritalStatuses;
  final List<StatusModel>? citizenship;
  final List<AppealModel>? appealList;
  final List<AppealTypeModel>? appealTypes;
  final List<AppealTypeModel>? appealTypeList;
  final CreateAppealModel? createAppealModel;
  final bool isSendVerified;
  final bool isGetMessageVerified;
  final bool isGetNewMessageVerified;
  final bool isPaging;
  final bool reachedMaxQuestions;
  final bool reachedMaxNews;
  final bool isLoading;
  final bool hasError;
  final String errorMessage;

  AppealState({
    this.regionList,
    this.requirments,
    this.regions,
    this.statuses,
    this.genders,
    this.maritalStatuses,
    this.citizenship,
    this.appealList,
    this.appealTypeList,
    this.appealTypes,
    this.createAppealModel,
    this.isSendVerified = false,
    this.isGetMessageVerified = false,
    this.isGetNewMessageVerified = false,
    this.isPaging = false,
    this.reachedMaxQuestions = false,
    this.reachedMaxNews = false,
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage = 'Some Error',
  });

  AppealState copyWith({
    List<RegionModel>? regionList,
    List<RequirmentModel>? requirments,
    List<RegionModel>? regions,
    List<StatusModel>? statuses,
    List<StatusModel>? genders,
    List<StatusModel>? maritalStatuses,
    List<StatusModel>? citizenship,
    List<AppealModel>? appealList,
    List<AppealTypeModel>? appealTypes,
    List<AppealTypeModel>? appealTypeList,
    CreateAppealModel? createAppealModel,
    bool? isSendVerified,
    bool? isGetMessageVerified,
    bool? isGetNewMessageVerified,
    bool? isPaging,
    bool? reachedMaxQuestions,
    bool? reachedMaxNews,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  }) =>
      AppealState(
        regionList: regionList ?? this.regionList,
        requirments: requirments??this.requirments,
        regions: regions ?? this.regions,
        statuses: statuses ?? this.statuses,
        genders: genders ?? this.genders,
        maritalStatuses: maritalStatuses ?? this.maritalStatuses,
        citizenship: citizenship ?? this.citizenship,
        appealList: appealList ?? this.appealList,
        appealTypes: appealTypes ?? this.appealTypes,
        appealTypeList: appealTypeList ?? this.appealTypeList,
        createAppealModel: createAppealModel,
        isSendVerified: isSendVerified ?? false,
        isGetMessageVerified: isGetMessageVerified ?? false,
        isGetNewMessageVerified: isGetNewMessageVerified ?? false,
        isPaging: isPaging ?? false,
        reachedMaxQuestions: reachedMaxQuestions ?? this.reachedMaxQuestions,
        reachedMaxNews: reachedMaxNews ?? this.reachedMaxNews,
        isLoading: isLoading ?? false,
        hasError: hasError ?? false,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
