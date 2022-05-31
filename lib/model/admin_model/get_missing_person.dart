class AdminMissingPersonModel {
  String? status;
  Null? message;
  List<Data>? data;



  AdminMissingPersonModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data =  <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }


}

class Data {
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
  bool? accept;
  String? stateType;
  int? iV;
  String? whatsApp;
  String? messangerUserName;


  Data.fromJson(Map<String, dynamic> json) {
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
    accept = json['Accept'];
    stateType = json['stateType'];
    iV = json['__v'];
    whatsApp = json['whatsApp'];
    messangerUserName = json['messangerUserName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['Name'] = this.name;
    data['fatherName'] = this.fatherName;
    data['motherName'] = this.motherName;
    data['yearOfBirth'] = this.yearOfBirth;
    data['gender'] = this.gender;
    data['nationality'] = this.nationality;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['characteristics'] = this.characteristics;
    data['photo'] = this.photo;
    data['date'] = this.date;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['circumstances'] = this.circumstances;
    data['phone'] = this.phone;
    data['caseN'] = this.caseN;
    data['currentUser'] = this.currentUser;
    data['Accept'] = this.accept;
    data['stateType'] = this.stateType;
    data['__v'] = this.iV;
    data['whatsApp'] = this.whatsApp;
    data['messangerUserName'] = this.messangerUserName;
    return data;
  }
}
