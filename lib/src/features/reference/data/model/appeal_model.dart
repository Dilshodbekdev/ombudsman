/// id : 10
/// document_code : "6673f84efec3400001530a8f"
/// request_code : "1-10-mob24"
/// check_code : "8547"
/// fio : "NURULLAYEV DILSHOD INATILLO UG‘LI"
/// citizenship : 1
/// region_id : 1
/// district_id : 1
/// address : "MurojaatKetdi"
/// email : "JavohirDobilov@gmail.com"
/// phone : "998900000000"
/// marital_status : 1
/// birthday : null
/// is_juridical : "1"
/// juridical_name : "MurojaatKetdi"
/// gender : "m"
/// text : "MurojaatKetdi"
/// appeal_type : null
/// application_file : "/var/www/ombudsmanmob/storage/app/public/applications/2024-06-20-dM5jG.pdf"
/// answer_file : null
/// file : "/tmp/phpTYDChF"
/// status : 1
/// created_at : "1718876237"
/// updated_at : "1718876238"

class AppealModel {
  AppealModel({
    this.id,
    this.documentCode,
    this.requestCode,
    this.checkCode,
    this.fio,
    this.citizenship,
    this.regionId,
    this.districtId,
    this.address,
    this.email,
    this.phone,
    this.maritalStatus,
    this.birthday,
    this.isJuridical,
    this.juridicalName,
    this.gender,
    this.text,
    this.appealType,
    this.applicationFile,
    this.answerFile,
    this.file,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  AppealModel.fromJson(dynamic json) {
    id = json['id'];
    documentCode = json['document_code'];
    requestCode = json['request_code'];
    checkCode = json['check_code'];
    fio = json['fio'];
    citizenship = json['citizenship'];
    regionId = json['region_id'];
    districtId = json['district_id'];
    address = json['address'];
    email = json['email'];
    phone = json['phone'];
    maritalStatus = json['marital_status'];
    birthday = json['birthday'];
    isJuridical = json['is_juridical'];
    juridicalName = json['juridical_name'];
    gender = json['gender'];
    text = json['text'];
    appealType = json['appeal_type'];
    applicationFile = json['application_file'];
    answerFile = json['answer_file'];
    file = json['file'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  int? id;
  String? documentCode;
  String? requestCode;
  String? checkCode;
  String? fio;
  int? citizenship;
  int? regionId;
  int? districtId;
  String? address;
  String? email;
  String? phone;
  int? maritalStatus;
  String? birthday;
  String? isJuridical;
  String? juridicalName;
  String? gender;
  String? text;
  String? appealType;
  String? applicationFile;
  String? answerFile;
  String? file;
  int? status;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['document_code'] = documentCode;
    map['request_code'] = requestCode;
    map['check_code'] = checkCode;
    map['fio'] = fio;
    map['citizenship'] = citizenship;
    map['region_id'] = regionId;
    map['district_id'] = districtId;
    map['address'] = address;
    map['email'] = email;
    map['phone'] = phone;
    map['marital_status'] = maritalStatus;
    map['birthday'] = birthday;
    map['is_juridical'] = isJuridical;
    map['juridical_name'] = juridicalName;
    map['gender'] = gender;
    map['text'] = text;
    map['appeal_type'] = appealType;
    map['application_file'] = applicationFile;
    map['answer_file'] = answerFile;
    map['file'] = file;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
