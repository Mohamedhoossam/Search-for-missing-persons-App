class UpdatePasswordModel {
  String? status;
  String? message;
  String? token;
  Data? data;

  UpdatePasswordModel({this.status, this.message, this.token, this.data});

  UpdatePasswordModel.fromJson(Map<String, dynamic> json) {
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

  Data(
      {this.sId,
        this.name,
        this.email,
        this.photo,
        this.backGroundPhoto,
        this.role,
        this.iV});

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
