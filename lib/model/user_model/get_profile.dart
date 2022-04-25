class GetProfileModel {
  String? status;
  String? message;
  String? token;
  Data? data;



  GetProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? sId;
  String? name;
  String? email;
  String? photo;
  String? backGroundPhoto;
  String? role;
  int? iV;


  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
    backGroundPhoto = json['backGroundPhoto'];
    role = json['role'];
    iV = json['__v'];
  }

}
