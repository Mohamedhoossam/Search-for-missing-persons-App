class UserMissingCaseModel {
  String? status;
  String? message;
  List<MissingCaseData>? data;

  UserMissingCaseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MissingCaseData>[];
      json['data'].forEach((v) {
        data!.add( MissingCaseData.fromJson(v));
      });
    }
  }

}

class MissingCaseData {
  String? sId;
  String? name;
  String? fatherName;
  String? motherName;
  int? yearOfBirth;
  String? gender;
  String? nationality;
  int? height;
  int? weight;
  String? characteristics;
  String? photo;
  String? date;
  String? country;
  String? state;
  String? city;
  String? circumstances;
  String? phone;
  String? caseN;
  String? currentUser;
  String? whatsApp;
  String? messangerUserName;
  bool? accept;
  String? stateType;
  int? iV;


  MissingCaseData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['Name'];
    fatherName = json['fatherName'];
    motherName = json['motherName'];
    yearOfBirth = json['yearOfBirth'];
    gender = json['gender'];
    nationality = json['nationality'];
    height = json['height'];
    weight = json['weight'];
    characteristics = json['characteristics'];
    photo = json['photo'];
    date = json['date'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    circumstances = json['circumstances'];
    phone = json['phone'];
    caseN = json['caseN'];
    currentUser = json['currentUser'];
    whatsApp = json['whatsApp'];
    messangerUserName = json['messangerUserName'];
    accept = json['Accept'];
    stateType = json['stateType'];
    iV = json['__v'];
  }

}
