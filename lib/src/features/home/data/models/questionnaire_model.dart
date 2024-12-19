/// id : 1
/// description : {"oz":"sdfsdfdsf","ru":"fdsfdsfds"}
/// is_active : 1
/// created_at : "2024-06-20T07:12:56.000000Z"
/// updated_at : "2024-06-20T07:12:56.000000Z"
/// answers : [{"id":3,"description":{"oz":"bnbnbnbn","ru":"nbnbnb"},"is_active":1,"question_id":1,"created_at":"2024-06-20T07:13:45.000000Z","updated_at":"2024-06-20T07:13:45.000000Z"},{"id":4,"description":{"oz":"nmnmnm","ru":"nmn"},"is_active":1,"question_id":1,"created_at":"2024-06-20T07:13:52.000000Z","updated_at":"2024-06-20T07:13:52.000000Z"}]

class QuestionnaireModel {
  QuestionnaireModel({
    this.id,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.answers,
  });

  QuestionnaireModel.fromJson(dynamic json) {
    id = json['id'];
    description = json['description'] != null
        ? Description.fromJson(json['description'])
        : null;
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['answers'] != null) {
      answers = [];
      json['answers'].forEach((v) {
        answers?.add(Answers.fromJson(v));
      });
    }
  }

  int? id;
  Description? description;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  List<Answers>? answers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (description != null) {
      map['description'] = description?.toJson();
    }
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (answers != null) {
      map['answers'] = answers?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 3
/// description : {"oz":"bnbnbnbn","ru":"nbnbnb"}
/// is_active : 1
/// question_id : 1
/// created_at : "2024-06-20T07:13:45.000000Z"
/// updated_at : "2024-06-20T07:13:45.000000Z"

class Answers {
  Answers({
    this.id,
    this.description,
    this.isActive,
    this.questionId,
    this.createdAt,
    this.updatedAt,
  });

  Answers.fromJson(dynamic json) {
    id = json['id'];
    description = json['description'] != null
        ? Description.fromJson(json['description'])
        : null;
    isActive = json['is_active'];
    questionId = json['question_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  int? id;
  Description? description;
  int? isActive;
  int? questionId;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (description != null) {
      map['description'] = description?.toJson();
    }
    map['is_active'] = isActive;
    map['question_id'] = questionId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

/// oz : "bnbnbnbn"
/// ru : "nbnbnb"

class Description {
  Description({
    this.oz,
    this.ru,
    this.uz,
    this.en,
  });

  Description.fromJson(dynamic json) {
    oz = json['oz'];
    ru = json['ru'];
    uz = json['uz'];
    en = json['en'];
  }

  String? oz;
  String? ru;
  String? uz;
  String? en;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['oz'] = oz;
    map['ru'] = ru;
    map['uz'] = uz;
    map['en'] = en;
    return map;
  }
}
