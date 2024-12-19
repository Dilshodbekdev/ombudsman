import 'package:ombudsman/src/core/resources/data_state.dart';
import 'package:ombudsman/src/core/usecase/use_case.dart';
import 'package:ombudsman/src/features/home/data/models/notification_model.dart';
import 'package:ombudsman/src/features/home/domain/repository/home_repository.dart';

class NotificationsUseCase
    implements UseCase<DataState<List<NotificationModel>>, int> {
  final HomeRepository _repository;

  NotificationsUseCase(this._repository);

  @override
  Future<DataState<List<NotificationModel>>> call(
          {required int params}) async =>
      await _repository.notifications();
}
