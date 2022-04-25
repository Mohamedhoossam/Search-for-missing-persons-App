class ResetPasswordDataModel {
  String? status;
  String? message;
  String? token;
  Data? data;

  ResetPasswordDataModel({this.status, this.message, this.token, this.data});

  ResetPasswordDataModel.fromJson(Map<String, dynamic> json) {
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
  int? iV;
  String? passwordChangedAt;

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
    iV = json['__v'];
    passwordChangedAt = json['passwordChangedAt'];
  }


}
