class UpdateProfileModel {
  String? status;
  String? message;
  UpdateUser? user;


  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ?  UpdateUser.fromJson(json['user']) : null;
  }

}

class UpdateUser {
  String? sId;
  String? name;
  String? email;
  String? photo;
  String? backGroundPhoto;
  String? role;
  int? iV;


  UpdateUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
    backGroundPhoto = json['backGroundPhoto'];
    role = json['role'];
    iV = json['__v'];
  }


}
