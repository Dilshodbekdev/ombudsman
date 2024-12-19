/// id : 127
/// type_id : 3
/// category_id : 38
/// title : "{\"oz\":\"Rashidova Sayyora Sharafovna \",\"uz\":\"Рашидова Сайёра Шарафовна \",\"ru\":\"Рашидова Сайёра Шарафовна \",\"en\":\"Rashidova Sayyora Sharafovna \"}"
/// slug : "ozbekiston-respublikasi-olij-mazhlisining-inson-huquqlari-bojicha-vakili-ombudsman"
/// short_description : null
/// description : "{\"oz\":\"O‘zbekiston Respublikasi Oliy Majlisining Inson huquqlari bo‘yicha vakili (ombudsman)\\r\\n1995-2015 yy.\",\"uz\":\"Ўзбекистон Республикаси Олий Мажлисининг Инсон ҳуқуқлари бўйича вакили (омбудсман)\\r\\n1995-2015 йй.\",\"ru\":\"Уполномоченный Олий Мажлиса Республики Узбекистан по правам человека (Омбудсман)\\r\\n1995-2015 гг.\",\"en\":\"Commission on Human Rights of the Oliy Majlis of the Republic of Uzbekistan (Ombudsman)\\r\\n1995-2015 yy.\"}"
/// content : null
/// pdf : null
/// anons_image : "/uploads/2021/01/ombudsmanlast.jpg"
/// body_image : "NULL"
/// code_utube : "'NULL'"
/// video : null
/// media_type : 0
/// link : "#"
/// link_type : 1
/// main_page : 0
/// right_menu : 0
/// date : "2021-01-11"
/// order : 500
/// count_view : 0
/// status : 1
/// creator_id : 2
/// modifier_id : 2
/// created_at : 1610341347
/// updated_at : 1615790581

class LeadershipModel {
  LeadershipModel({
    this.id,
    this.typeId,
    this.categoryId,
    this.title,
    this.slug,
    this.shortDescription,
    this.description,
    this.content,
    this.pdf,
    this.anonsImage,
    this.bodyImage,
    this.codeUtube,
    this.video,
    this.mediaType,
    this.link,
    this.linkType,
    this.mainPage,
    this.rightMenu,
    this.date,
    this.order,
    this.countView,
    this.status,
    this.creatorId,
    this.modifierId,
    this.createdAt,
    this.updatedAt,
  });

  LeadershipModel.fromJson(dynamic json) {
    id = json['id'];
    typeId = json['type_id'];
    categoryId = json['category_id'];
    title = json['title'];
    slug = json['slug'];
    shortDescription = json['short_description'];
    description = json['description'];
    content = json['content'];
    pdf = json['pdf'];
    anonsImage = json['anons_image'];
    bodyImage = json['body_image'];
    codeUtube = json['code_utube'];
    video = json['video'];
    mediaType = json['media_type'];
    link = json['link'];
    linkType = json['link_type'];
    mainPage = json['main_page'];
    rightMenu = json['right_menu'];
    date = json['date'];
    order = json['order'];
    countView = json['count_view'];
    status = json['status'];
    creatorId = json['creator_id'];
    modifierId = json['modifier_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  int? id;
  int? typeId;
  int? categoryId;
  String? title;
  String? slug;
  dynamic shortDescription;
  String? description;
  dynamic content;
  dynamic pdf;
  String? anonsImage;
  String? bodyImage;
  String? codeUtube;
  dynamic video;
  int? mediaType;
  String? link;
  int? linkType;
  int? mainPage;
  int? rightMenu;
  String? date;
  int? order;
  int? countView;
  int? status;
  int? creatorId;
  int? modifierId;
  int? createdAt;
  int? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type_id'] = typeId;
    map['category_id'] = categoryId;
    map['title'] = title;
    map['slug'] = slug;
    map['short_description'] = shortDescription;
    map['description'] = description;
    map['content'] = content;
    map['pdf'] = pdf;
    map['anons_image'] = anonsImage;
    map['body_image'] = bodyImage;
    map['code_utube'] = codeUtube;
    map['video'] = video;
    map['media_type'] = mediaType;
    map['link'] = link;
    map['link_type'] = linkType;
    map['main_page'] = mainPage;
    map['right_menu'] = rightMenu;
    map['date'] = date;
    map['order'] = order;
    map['count_view'] = countView;
    map['status'] = status;
    map['creator_id'] = creatorId;
    map['modifier_id'] = modifierId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
