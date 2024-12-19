

import 'package:ombudsman/src/core/resources/data_state.dart';
import 'package:ombudsman/src/features/auth/data/models/one_id_model.dart';

abstract class AuthRepository {
  Future<DataState<OneIdModel>> oneId(String code);
}
