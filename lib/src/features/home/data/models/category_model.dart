/// id : 1
/// type_id : 2
/// parent_id : 0
/// title : "{\"oz\":\"Rahbariyat\",\"uz\":\"Раҳбарият\",\"ru\":\"Руководство\",\"en\":\"Leaderships\"}"
/// slug : "leaderships"
/// image : ""
/// status : 1
/// created_at : 1599540330
/// updated_at : 1599637269
/// creator_id : 1
/// modifier_id : 2

class CategoryModel {
  CategoryModel({
    this.id,
    this.typeId,
    this.parentId,
    this.title,
    this.slug,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.creatorId,
    this.modifierId,
  });

  CategoryModel.fromJson(dynamic json) {
    id = json['id'];
    typeId = json['type_id'];
    parentId = json['parent_id'];
    title = json['title'];
    slug = json['slug'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    creatorId = json['creator_id'];
    modifierId = json['modifier_id'];
  }

  int? id;
  int? typeId;
  int? parentId;
  String? title;
  String? slug;
  String? image;
  int? status;
  int? createdAt;
  int? updatedAt;
  int? creatorId;
  int? modifierId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type_id'] = typeId;
    map['parent_id'] = parentId;
    map['title'] = title;
    map['slug'] = slug;
    map['image'] = image;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['creator_id'] = creatorId;
    map['modifier_id'] = modifierId;
    return map;
  }
}
