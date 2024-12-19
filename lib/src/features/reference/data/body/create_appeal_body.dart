import 'dart:async';
import 'dart:io';

class CreateAppealBody {
  CreateAppealBody({
    this.email,
    this.phone,
    this.text,
    this.gender,
    this.juridical_name,
    this.is_juridical,
    this.status,
    this.citizenship,
    this.marital_status,
    this.region_id,
    this.district_id,
    this.appeal_type,
    this.address,
    this.file,
  });

  String? email;
  String? phone;
  String? text;
  String? gender;
  String? juridical_name;
  String? is_juridical;
  String? address;
  int? status;
  int? citizenship;
  int? marital_status;
  int? region_id;
  int? district_id;
  String? appeal_type;
  File? file;
}
