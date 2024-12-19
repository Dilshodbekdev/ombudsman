/// id : 4
/// parent_id : null
/// title_uz : "Қашқадарё вилояти"
/// order : 500
/// default_value : null
/// enabled : 1
/// title_ru : null
/// title_oz : null
/// title_en : null

class RegionModel {
  RegionModel({
      this.id, 
      this.parentId, 
      this.titleUz, 
      this.order, 
      this.defaultValue, 
      this.enabled, 
      this.titleRu, 
      this.titleOz, 
      this.titleEn,});

  RegionModel.fromJson(dynamic json) {
    id = json['id'];
    parentId = json['parent_id'];
    titleUz = json['title_uz'];
    order = json['order'];
    defaultValue = json['default_value'];
    enabled = json['enabled'];
    titleRu = json['title_ru'];
    titleOz = json['title_oz'];
    titleEn = json['title_en'];
  }
  int? id;
  dynamic parentId;
  String? titleUz;
  int? order;
  dynamic defaultValue;
  int? enabled;
  dynamic titleRu;
  dynamic titleOz;
  dynamic titleEn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['parent_id'] = parentId;
    map['title_uz'] = titleUz;
    map['order'] = order;
    map['default_value'] = defaultValue;
    map['enabled'] = enabled;
    map['title_ru'] = titleRu;
    map['title_oz'] = titleOz;
    map['title_en'] = titleEn;
    return map;
  }

}