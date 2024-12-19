import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombudsman/src/core/resources/data_state.dart';
import 'package:ombudsman/src/features/reference/data/body/create_appeal_body.dart';
import 'package:ombudsman/src/features/reference/data/model/appeal_model.dart';
import 'package:ombudsman/src/features/reference/data/model/appeal_type_model.dart';
import 'package:ombudsman/src/features/reference/data/model/create_appeal_model.dart';
import 'package:ombudsman/src/features/reference/data/model/region_model.dart';
import 'package:ombudsman/src/features/reference/data/model/requirment_model.dart';
import 'package:ombudsman/src/features/reference/data/model/status_model.dart';
import 'package:ombudsman/src/features/reference/domain/use_case/appeal_list_use_case.dart';
import 'package:ombudsman/src/features/reference/domain/use_case/appeal_types_use_case.dart';
import 'package:ombudsman/src/features/reference/domain/use_case/citizenship_use_case.dart';
import 'package:ombudsman/src/features/reference/domain/use_case/create_appeal_use_case.dart';
import 'package:ombudsman/src/features/reference/domain/use_case/genders_use_case.dart';
import 'package:ombudsman/src/features/reference/domain/use_case/marital_statuses_use_case.dart';
import 'package:ombudsman/src/features/reference/domain/use_case/region_list_use_case.dart';
import 'package:ombudsman/src/features/reference/domain/use_case/requirment_list_use_case.dart';
import 'package:ombudsman/src/features/reference/domain/use_case/statuses_use_case.dart';

part 'appeal_event.dart';

part 'appeal_state.dart';

class AppealBloc extends Bloc<AppealEvent, AppealState> {
  final RegionListUseCase _regionListUseCase;
  final StatusesUseCase _statusesUseCase;
  final GendersUseCase _gendersUseCase;
  final MaritalStatusesUseCase _maritalStatusesUseCase;
  final CitizenshipUseCase _citizenshipUseCase;
  final AppealListUseCase _appealListUseCase;
  final AppealTypesUseCase _appealTypesUseCase;
  final CreateAppealUseCase _createAppealUseCase;
  final RequirmentListUseCase _requirmentListUseCase;

  AppealBloc(
    this._regionListUseCase,
    this._statusesUseCase,
    this._gendersUseCase,
    this._maritalStatusesUseCase,
    this._citizenshipUseCase,
    this._createAppealUseCase,
    this._appealTypesUseCase,
    this._appealListUseCase, this._requirmentListUseCase,
  ) : super(AppealState()) {
    on<RegionListEvent>((event, emit) async {
      await emit.onEach(_onRegionList(event), onData: emit.call);
    });

    on<StatusesEvent>((event, emit) async {
      await emit.onEach(_onStatuses(event), onData: emit.call);
    });

    on<GendersEvent>((event, emit) async {
      await emit.onEach(_onGenders(event), onData: emit.call);
    });

    on<MaritalStatusesEvent>((event, emit) async {
      await emit.onEach(_onMaritalStatuses(event), onData: emit.call);
    });

    on<CitizenshipEvent>((event, emit) async {
      await emit.onEach(_onCitizenship(event), onData: emit.call);
    });

    on<AppealListEvent>((event, emit) async {
      await emit.onEach(_onAppealList(event), onData: emit.call);
    });

    on<AppealTypesEvent>((event, emit) async {
      await emit.onEach(_onAppealTypes(event), onData: emit.call);
    });

    on<CreateAppealEvent>((event, emit) async {
      await emit.onEach(_onCreateAppeal(event), onData: emit.call);
    });

    on<RequirmentsEvent>((event, emit) async {
      await emit.onEach(_onRequirments(event), onData: emit.call);
    });
  }

  regionList() {
    add(RegionListEvent());
  }

  requirments() {
    add(RequirmentsEvent());
  }

  statuses() {
    add(StatusesEvent());
  }

  genders() {
    add(GendersEvent());
  }

  maritalStatuses() {
    add(MaritalStatusesEvent());
  }

  citizenship() {
    add(CitizenshipEvent());
  }

  createAppeal(CreateAppealBody body) {
    add(CreateAppealEvent(body: body));
  }

  appealList() {
    add(AppealListEvent());
  }

  appealTypes() {
    add(AppealTypesEvent());
  }

  Stream<AppealState> _onRegionList(RegionListEvent event) async* {
    yield state.copyWith(isLoading: true);

    final dataState = await _regionListUseCase.call(params: 1);

    if (dataState is DataSuccess) {
      yield state.copyWith(regionList: dataState.data,regions: dataState.data?.where((test)=>test.parentId==null).toList());
    } else if (dataState is DataFailed) {
      yield state.copyWith(hasError: true, errorMessage: dataState.message);
    }
  }

  Stream<AppealState> _onStatuses(StatusesEvent event) async* {
    yield state.copyWith(isLoading: true);

    final dataState = await _statusesUseCase.call(params: 1);

    if (dataState is DataSuccess) {
      yield state.copyWith(statuses: dataState.data);
    } else if (dataState is DataFailed) {
      yield state.copyWith(hasError: true, errorMessage: dataState.message);
    }
  }

  Stream<AppealState> _onGenders(GendersEvent event) async* {
    yield state.copyWith(isLoading: true);

    final dataState = await _gendersUseCase.call(params: 1);

    if (dataState is DataSuccess) {
      yield state.copyWith(genders: dataState.data);
    } else if (dataState is DataFailed) {
      yield state.copyWith(hasError: true, errorMessage: dataState.message);
    }
  }

  Stream<AppealState> _onMaritalStatuses(MaritalStatusesEvent event) async* {
    yield state.copyWith(isLoading: true);

    final dataState = await _maritalStatusesUseCase.call(params: 1);

    if (dataState is DataSuccess) {
      yield state.copyWith(maritalStatuses: dataState.data);
    } else if (dataState is DataFailed) {
      yield state.copyWith(hasError: true, errorMessage: dataState.message);
    }
  }

  Stream<AppealState> _onCitizenship(CitizenshipEvent event) async* {
    yield state.copyWith(isLoading: true);

    final dataState = await _citizenshipUseCase.call(params: 1);

    if (dataState is DataSuccess) {
      yield state.copyWith(citizenship: dataState.data);
    } else if (dataState is DataFailed) {
      yield state.copyWith(hasError: true, errorMessage: dataState.message);
    }
  }

  Stream<AppealState> _onAppealList(AppealListEvent event) async* {
    yield state.copyWith(isLoading: true);

    final dataState = await _appealListUseCase.call(params: 1);

    if (dataState is DataSuccess) {
      yield state.copyWith(
          appealList: dataState.data, isGetMessageVerified: true);
    } else if (dataState is DataFailed) {
      yield state.copyWith(hasError: true, errorMessage: dataState.message);
    }
  }

  Stream<AppealState> _onRequirments(RequirmentsEvent event) async* {
    yield state.copyWith(isLoading: true);

    final dataState = await _requirmentListUseCase.call(params: 1);

    if (dataState is DataSuccess) {
      yield state.copyWith(
          requirments: dataState.data, isGetMessageVerified: true);
    } else if (dataState is DataFailed) {
      yield state.copyWith(hasError: true, errorMessage: dataState.message);
    }
  }

  Stream<AppealState> _onAppealTypes(AppealTypesEvent event) async* {
    yield state.copyWith(isLoading: true);

    final dataState = await _appealTypesUseCase.call(params: 1);

    if (dataState is DataSuccess) {
      yield state.copyWith(appealTypeList: dataState.data, appealTypes: dataState.data?.where((test)=>test.parentId==0).toList(),isGetNewMessageVerified: true);
    } else if (dataState is DataFailed) {
      yield state.copyWith(hasError: true, errorMessage: dataState.message);
    }
  }

  Stream<AppealState> _onCreateAppeal(CreateAppealEvent event) async* {
    yield state.copyWith(isLoading: true);

    final dataState = await _createAppealUseCase.call(params: event.body);

    if (dataState is DataSuccess) {
      yield state.copyWith(
          createAppealModel: dataState.data, isSendVerified: true);
    } else if (dataState is DataFailed) {
      yield state.copyWith(hasError: true, errorMessage: dataState.message);
    }
  }
}
