/// label : "New"
/// value : 1

class StatusModel {
  StatusModel({
      this.label, 
      this.value,});

  StatusModel.fromJson(dynamic json) {
    label = json['label'];
    value = json['value'];
  }
  String? label;
  int? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = label;
    map['value'] = value;
    return map;
  }

}