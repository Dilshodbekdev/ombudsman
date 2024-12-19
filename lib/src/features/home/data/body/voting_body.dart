/// question_id : "1"
/// answer_id : "3"

class VotingBody {
  VotingBody({
    this.questionId,
    this.answerId,
  });

  VotingBody.fromJson(dynamic json) {
    questionId = json['question_id'];
    answerId = json['answer_id'];
  }

  String? questionId;
  String? answerId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question_id'] = questionId;
    map['answer_id'] = answerId;
    return map;
  }
}
