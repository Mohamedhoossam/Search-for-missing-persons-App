class SearchFamilyRejectAdmin {
  String? status;
  String? message;
  Null? data;



  SearchFamilyRejectAdmin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }


}