class AlreadyMissingFoundModel {
  String? status;
  String? message;
  List<AlreadyFoundData>? data;

  AlreadyMissingFoundModel({this.status, this.message, this.data});

  AlreadyMissingFoundModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AlreadyFoundData>[];
      json['data'].forEach((v) {
        data!.add( AlreadyFoundData.fromJson(v));
      });
    }
  }

}

class AlreadyFoundData {
  bool? accept;
  String? name;
  int? iV;
  String? sId;
  String? caseN;
  String? characteristics;
  String? circumstances;
  String? city;
  String? country;
  String? currentUser;
  String? date;
  String? fatherName;
  String? gender;
  int? height;
  String? messangerUserName;
  String? motherName;
  String? nationality;
  String? phone;
  String? photo;
  String? state;
  String? stateType;
  int? weight;
  String? whatsApp;
  int? yearOfBirth;

  AlreadyFoundData(
      {this.accept,
        this.name,
        this.iV,
        this.sId,
        this.caseN,
        this.characteristics,
        this.circumstances,
        this.city,
        this.country,
        this.currentUser,
        this.date,
        this.fatherName,
        this.gender,
        this.height,
        this.messangerUserName,
        this.motherName,
        this.nationality,
        this.phone,
        this.photo,
        this.state,
        this.stateType,
        this.weight,
        this.whatsApp,
        this.yearOfBirth});

  AlreadyFoundData.fromJson(Map<String, dynamic> json) {
    accept = json['Accept'];
    name = json['Name'];
    iV = json['__v'];
    sId = json['_id'];
    caseN = json['caseN'];
    characteristics = json['characteristics'];
    circumstances = json['circumstances'];
    city = json['city'];
    country = json['country'];
    currentUser = json['currentUser'];
    date = json['date'];
    fatherName = json['fatherName'];
    gender = json['gender'];
    height = json['height'];
    messangerUserName = json['messangerUserName'];
    motherName = json['motherName'];
    nationality = json['nationality'];
    phone = json['phone'];
    photo = json['photo'];
    state = json['state'];
    stateType = json['stateType'];
    weight = json['weight'];
    whatsApp = json['whatsApp'];
    yearOfBirth = json['yearOfBirth'];
  }

}
