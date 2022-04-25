class SearchByImageModel {
  String? status;
  String? message;
  List<SearchImageUserData>? data;

  SearchByImageModel({this.status, this.message, this.data});

  SearchByImageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SearchImageUserData>[];
      json['data'].forEach((v) {
        data!.add( SearchImageUserData.fromJson(v));
      });
    }
  }


}

class SearchImageUserData {
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



  SearchImageUserData.fromJson(Map<String, dynamic> json) {
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
