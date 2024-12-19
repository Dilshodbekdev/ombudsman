import 'package:ombudsman/src/features/home/data/models/questionnaire_model.dart';

/// endquestion : {"id":5,"description":{"en":"en","oz":"oz","ru":"ru","uz":"uz"},"is_active":1,"created_at":"2024-06-20T10:47:30.000000Z","updated_at":"2024-06-20T10:47:30.000000Z","answers":[{"id":8,"description":{"en":"en javob","oz":"oz javob","ru":"ru javob","uz":"uz javob"},"is_active":1,"question_id":5,"created_at":"2024-06-20T10:48:24.000000Z","updated_at":"2024-06-20T10:48:24.000000Z"}]}

class EndQuestionModel {
  EndQuestionModel({
      this.endquestion,});

  EndQuestionModel.fromJson(dynamic json) {
    endquestion = json['endquestion'] != null ? QuestionnaireModel.fromJson(json['endquestion']) : null;
  }
  QuestionnaireModel? endquestion;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (endquestion != null) {
      map['endquestion'] = endquestion?.toJson();
    }
    return map;
  }

}