import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombudsman/src/core/resources/data_state.dart';
import 'package:ombudsman/src/core/services/services.dart';
import 'package:ombudsman/src/core/util/app_constants.dart';
import 'package:ombudsman/src/features/auth/data/models/one_id_model.dart';
import 'package:ombudsman/src/features/auth/domain/use_case/one_id_use_case.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final OneIdUseCase _oneIdUseCase;

  AuthBloc(
    this._oneIdUseCase,
  ) : super(AuthState()) {

    on<OneIdEvent>((event, emit) async {
      await emit.onEach(_onOneId(event), onData: emit.call);
    });
  }

  oneId({required String body}) {
    add(OneIdEvent(body: body));
  }

  Stream<AuthState> _onOneId(OneIdEvent event) async* {
    yield state.copyWith(isLoading: true);

    final dataState = await _oneIdUseCase.call(params: event.body);

    if (dataState is DataSuccess) {
      yield state.copyWith(oneIdModel: dataState.data, isOneIdVerified: true);
      Prefs.setString(AppConstants.kAccessToken, dataState.data?.token??'');
      Prefs.setString(AppConstants.kUser, jsonEncode(dataState.data?.user));
    } else if (dataState is DataFailed) {
      yield state.copyWith(hasError: true, errorMessage: dataState.message);
    }
  }
}
