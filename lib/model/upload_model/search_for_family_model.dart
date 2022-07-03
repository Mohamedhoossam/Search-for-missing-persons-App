class SearchForFamilyModel {
  String? status;
  String? message;
  Data? data;


  SearchForFamilyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? name;
  String? fatherName;
  String? motherName;
  int? yearOfBirth;
  String? gender;
  String? nationality;
  String? skinColor;
  String? eyeColor;
  String? head;
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
  String? messangerUserName;
  bool? accept;
  String? sId;
  int? iV;
  String? longitude;
  String? latitude;

  Data.fromJson(Map<String, dynamic> json) {
    longitude =json['longitude'];
    latitude =json['latitude'];
    name = json['Name'];
    fatherName = json['fatherName'];
    motherName = json['motherName'];
    yearOfBirth = json['yearOfBirth'];
    gender = json['gender'];
    nationality = json['nationality'];
    skinColor = json['skinColor'];
    eyeColor = json['eyeColor'];
    head = json['head'];
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
    messangerUserName = json['messangerUserName'];
    accept = json['Accept'];
    sId = json['_id'];
    iV = json['__v'];
  }

}
