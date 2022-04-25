  class UserDataModel {
  String? status;
  String? message;
  String? token;
  Data? data;

  UserDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }


}

class Data {
  String? name;
  String? email;
  String? photo;
  String? sId;
  int? iV;


  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
    sId = json['_id'];
    iV = json['__v'];
  }

}
