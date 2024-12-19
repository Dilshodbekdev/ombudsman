part of 'appeal_bloc.dart';

abstract class AppealEvent {}

class RegionListEvent extends AppealEvent {
  RegionListEvent();
}

class StatusesEvent extends AppealEvent {
  StatusesEvent();
}

class GendersEvent extends AppealEvent {
  GendersEvent();
}

class MaritalStatusesEvent extends AppealEvent {
  MaritalStatusesEvent();
}

class CitizenshipEvent extends AppealEvent {
  CitizenshipEvent();
}

class CategoryListEvent extends AppealEvent {
  CategoryListEvent();
}

class AppealListEvent extends AppealEvent {
  AppealListEvent();
}

class AppealTypesEvent extends AppealEvent {
  AppealTypesEvent();
}

class RequirmentsEvent extends AppealEvent {
  RequirmentsEvent();
}

class CreateAppealEvent extends AppealEvent{
  final CreateAppealBody body;

  CreateAppealEvent({required this.body});
}
