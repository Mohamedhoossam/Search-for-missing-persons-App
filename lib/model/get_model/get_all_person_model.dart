class GetAllPersonModel {
  String? status;
  String? message;
  List<PersonData>? data;


  GetAllPersonModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PersonData>[];
      json['data'].forEach((v) {
        data!.add( PersonData.fromJson(v));
      });
    }
  }

}

class PersonData {
  String? sId;
  String? name;
  String? fatherName;
  String? motherName;
  int? yearOfBirth;
  String? gender;
  String? nationality;
  String? skinColor;
  String? eyeColor;
  String? headColor;
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
  String? messengerUserName;
  bool? accept;
  int? iV;
  String? fullName;
  String? head;
  String? stateType;



  PersonData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['Name'];
    fatherName = json['fatherName'];
    motherName = json['motherName'];
    yearOfBirth = json['yearOfBirth'];
    gender = json['gender'];
    nationality = json['nationality'];
    skinColor = json['skinColor'];
    eyeColor = json['eyeColor'];
    headColor = json['headColor'];
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
    messengerUserName = json['messangerUserName'];
    accept = json['Accept'];
    iV = json['__v'];
    fullName = json['fullName'];
    head = json['head'];
    stateType = json['stateType'];
  }

}
