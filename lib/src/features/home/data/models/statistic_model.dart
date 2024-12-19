/// all : {"label":"{}","count":39}
/// new : {"label":"{}","count":33}
/// registered : {"label":"{}","count":0}
/// review : {"label":"{}","count":0}
/// answered : {"label":"{}","count":6}

class StatisticModel {
  StatisticModel({
      this.all,
      this.new1,
      this.registered,
      this.review,
      this.answered,});

  StatisticModel.fromJson(dynamic json) {
    all = json['all'] != null ? All.fromJson(json['all']) : null;
    new1 = json['new'] != null ? New.fromJson(json['new']) : null;
    registered = json['registered'] != null ? Registered.fromJson(json['registered']) : null;
    review = json['review'] != null ? Review.fromJson(json['review']) : null;
    answered = json['answered'] != null ? Answered.fromJson(json['answered']) : null;
  }
  All? all;
  New? new1;
  Registered? registered;
  Review? review;
  Answered? answered;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (all != null) {
      map['all'] = all?.toJson();
    }
    if (new1 != null) {
      map['new'] = new1?.toJson();
    }
    if (registered != null) {
      map['registered'] = registered?.toJson();
    }
    if (review != null) {
      map['review'] = review?.toJson();
    }
    if (answered != null) {
      map['answered'] = answered?.toJson();
    }
    return map;
  }

}

/// label : "{}"
/// count : 6

class Answered {
  Answered({
      this.label,
      this.count,});

  Answered.fromJson(dynamic json) {
    label = json['label'];
    count = json['count'];
  }
  String? label;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = label;
    map['count'] = count;
    return map;
  }

}

/// label : "{}"
/// count : 0

class Review {
  Review({
      this.label,
      this.count,});

  Review.fromJson(dynamic json) {
    label = json['label'];
    count = json['count'];
  }
  String? label;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = label;
    map['count'] = count;
    return map;
  }

}

/// label : "{}"
/// count : 0

class Registered {
  Registered({
      this.label,
      this.count,});

  Registered.fromJson(dynamic json) {
    label = json['label'];
    count = json['count'];
  }
  String? label;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = label;
    map['count'] = count;
    return map;
  }

}

/// label : "{}"
/// count : 33

class New {
  New({
      this.label,
      this.count,});

  New.fromJson(dynamic json) {
    label = json['label'];
    count = json['count'];
  }
  String? label;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = label;
    map['count'] = count;
    return map;
  }

}

/// label : "{}"
/// count : 39

class All {
  All({
      this.label,
      this.count,});

  All.fromJson(dynamic json) {
    label = json['label'];
    count = json['count'];
  }
  String? label;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = label;
    map['count'] = count;
    return map;
  }

}