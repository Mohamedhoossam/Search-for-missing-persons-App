class MissingRejectAdmin {
  String? status;
  String? message;
  Null? data;


  MissingRejectAdmin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }


}