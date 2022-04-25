class ContactUsModel{
  String? status;
  String? message;
  ContactUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}