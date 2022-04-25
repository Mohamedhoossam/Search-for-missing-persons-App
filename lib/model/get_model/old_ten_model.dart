class OldTenModel {
  String? status;
  String? message;
  List<Data>? data;


  OldTenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }


}
class Data {
  String? sId;
  String? fullName;
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
  String? messengerUserName;
  bool? accept;
  int? iV;
  String? name;
  String? headColor;


  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
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
    messengerUserName = json['messangerUserName'];
    accept = json['Accept'];
    iV = json['__v'];
    name = json['Name'];
    headColor = json['headColor'];
  }

}
