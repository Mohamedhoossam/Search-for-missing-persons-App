class VerifyCodeDataModel {
  String? status;
  String? message;
  Null? data;


  VerifyCodeDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }


}
