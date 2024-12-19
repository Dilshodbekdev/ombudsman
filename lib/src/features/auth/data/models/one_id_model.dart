/// token : "11|LZiZ4NxYt7Ip0exGUZzuuSU16t2GJugSaHBjcRo1db90e390"
/// user : {"id":1,"full_name":"NURULLAYEV DILSHOD INATILLO UG‘LI","phone_number":null,"code":null,"birth_date":"1998-09-24","birth_place":"null","citizen":"УЗБЕКИСТАН","email":"dilshod1845@gmail.com","gd":"1","natn":"УЗБЕК/УЗБЕЧКА","address":"ГИРДИҚЎРҒОН ҚФЙ, ЖАВЛОН МФЙ, АРАБХОНА ҚИШЛОҒИ,  uy:Р/С","pin":"32409986060027","pport_expr_date":"2025-01-22","pport_issue_date":"2015-01-23","pport_issue_place":"КАТТАКУРГАНСКИЙ РОВД САМАРКАНДСКОЙ ОБЛАСТИ","pport_no":"AA8456989","tin":"null","sess_id":"2be393c7-2e5c-43b2-a112-45d17a2d33b0","ret_cd":"0","is_one_id":1,"is_verified":1,"one_id_code":"ebd0cdbc-4058-43da-a713-63df515c8583","created_at":"2024-06-03T13:20:42.000000Z","updated_at":"2024-06-05T04:17:23.000000Z"}

class OneIdModel {
  OneIdModel({
    this.token,
    this.user,
  });

  OneIdModel.fromJson(dynamic json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  String? token;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}

/// id : 1
/// full_name : "NURULLAYEV DILSHOD INATILLO UG‘LI"
/// phone_number : null
/// code : null
/// birth_date : "1998-09-24"
/// birth_place : "null"
/// citizen : "УЗБЕКИСТАН"
/// email : "dilshod1845@gmail.com"
/// gd : "1"
/// natn : "УЗБЕК/УЗБЕЧКА"
/// address : "ГИРДИҚЎРҒОН ҚФЙ, ЖАВЛОН МФЙ, АРАБХОНА ҚИШЛОҒИ,  uy:Р/С"
/// pin : "32409986060027"
/// pport_expr_date : "2025-01-22"
/// pport_issue_date : "2015-01-23"
/// pport_issue_place : "КАТТАКУРГАНСКИЙ РОВД САМАРКАНДСКОЙ ОБЛАСТИ"
/// pport_no : "AA8456989"
/// tin : "null"
/// sess_id : "2be393c7-2e5c-43b2-a112-45d17a2d33b0"
/// ret_cd : "0"
/// is_one_id : 1
/// is_verified : 1
/// one_id_code : "ebd0cdbc-4058-43da-a713-63df515c8583"
/// created_at : "2024-06-03T13:20:42.000000Z"
/// updated_at : "2024-06-05T04:17:23.000000Z"

class User {
  User({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.code,
    this.birthDate,
    this.birthPlace,
    this.citizen,
    this.email,
    this.gd,
    this.natn,
    this.address,
    this.pin,
    this.pportExprDate,
    this.pportIssueDate,
    this.pportIssuePlace,
    this.pportNo,
    this.tin,
    this.sessId,
    this.retCd,
    this.isOneId,
    this.isVerified,
    this.oneIdCode,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    code = json['code'];
    birthDate = json['birth_date'];
    birthPlace = json['birth_place'];
    citizen = json['citizen'];
    email = json['email'];
    gd = json['gd'];
    natn = json['natn'];
    address = json['address'];
    pin = json['pin'];
    pportExprDate = json['pport_expr_date'];
    pportIssueDate = json['pport_issue_date'];
    pportIssuePlace = json['pport_issue_place'];
    pportNo = json['pport_no'];
    tin = json['tin'];
    sessId = json['sess_id'];
    retCd = json['ret_cd'];
    isOneId = json['is_one_id'];
    isVerified = json['is_verified'];
    oneIdCode = json['one_id_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  int? id;
  String? fullName;
  String? phoneNumber;
  String? code;
  String? birthDate;
  String? birthPlace;
  String? citizen;
  String? email;
  String? gd;
  String? natn;
  String? address;
  String? pin;
  String? pportExprDate;
  String? pportIssueDate;
  String? pportIssuePlace;
  String? pportNo;
  String? tin;
  String? sessId;
  String? retCd;
  int? isOneId;
  int? isVerified;
  String? oneIdCode;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['full_name'] = fullName;
    map['phone_number'] = phoneNumber;
    map['code'] = code;
    map['birth_date'] = birthDate;
    map['birth_place'] = birthPlace;
    map['citizen'] = citizen;
    map['email'] = email;
    map['gd'] = gd;
    map['natn'] = natn;
    map['address'] = address;
    map['pin'] = pin;
    map['pport_expr_date'] = pportExprDate;
    map['pport_issue_date'] = pportIssueDate;
    map['pport_issue_place'] = pportIssuePlace;
    map['pport_no'] = pportNo;
    map['tin'] = tin;
    map['sess_id'] = sessId;
    map['ret_cd'] = retCd;
    map['is_one_id'] = isOneId;
    map['is_verified'] = isVerified;
    map['one_id_code'] = oneIdCode;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
