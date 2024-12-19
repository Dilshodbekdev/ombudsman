/// email : "dilshod1845@gmail.com"
/// phone : "999483624"
/// marital_status : "1"
/// is_juridical : "1"
/// text : "hello world"
/// gender : "m"
/// juridical_name : "Technocorp LLC"
/// status : "1"
/// citizenship : "2"
/// region_id : "1"
/// district_id : "1"
/// address : "Tashkeny, Uzbekistan"
/// fio : "Nurullayev Dilshod"
/// file : {}
/// updated_at : "2024-06-06"
/// created_at : "2024-06-06"
/// id : 87
/// request_code : "1-87-mob24"
/// check_code : 1356
/// application_file : "/var/www/ombudsmanmob/storage/app/public/applications/2024-06-06-mbckI.pdf"
/// document_code : "66615203aa7ddd00017389bc"

class CreateAppealModel {
  CreateAppealModel({
      this.email, 
      this.phone, 
      this.maritalStatus, 
      this.isJuridical, 
      this.text, 
      this.gender, 
      this.juridicalName, 
      this.status, 
      this.citizenship, 
      this.regionId, 
      this.districtId, 
      this.address, 
      this.fio,
      this.updatedAt, 
      this.createdAt, 
      this.id, 
      this.requestCode, 
      this.checkCode, 
      this.applicationFile, 
      this.documentCode,
      this.message,
  });

  CreateAppealModel.fromJson(dynamic json) {
    email = json['email'];
    phone = json['phone'];
    maritalStatus = json['marital_status'];
    isJuridical = json['is_juridical'];
    text = json['text'];
    gender = json['gender'];
    juridicalName = json['juridical_name'];
    status = json['status'];
    citizenship = json['citizenship'];
    regionId = json['region_id'];
    districtId = json['district_id'];
    address = json['address'];
    fio = json['fio'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    requestCode = json['request_code'];
    checkCode = json['check_code'];
    applicationFile = json['application_file'];
    documentCode = json['document_code'];
    message = json['message'];
  }
  String? email;
  String? phone;
  String? maritalStatus;
  String? isJuridical;
  String? text;
  String? gender;
  String? juridicalName;
  String? status;
  String? citizenship;
  String? regionId;
  String? districtId;
  String? address;
  String? fio;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? requestCode;
  int? checkCode;
  String? applicationFile;
  String? documentCode;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['phone'] = phone;
    map['marital_status'] = maritalStatus;
    map['is_juridical'] = isJuridical;
    map['text'] = text;
    map['gender'] = gender;
    map['juridical_name'] = juridicalName;
    map['status'] = status;
    map['citizenship'] = citizenship;
    map['region_id'] = regionId;
    map['district_id'] = districtId;
    map['address'] = address;
    map['fio'] = fio;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    map['request_code'] = requestCode;
    map['check_code'] = checkCode;
    map['application_file'] = applicationFile;
    map['document_code'] = documentCode;
    map['message'] = message;
    return map;
  }

}