class ForgetPasswordDataModel {
  String? status;
  String? message;
  Null? data;


  ForgetPasswordDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }


}
