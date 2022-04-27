class MissingCaseFound {
  String? status;
  String? message;
  MissingFoundData? data;

  MissingCaseFound({this.status, this.message, this.data});

  MissingCaseFound.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  MissingFoundData.fromJson(json['data']) : null;
  }


}

class MissingFoundData {
  String? sId;
  int? iV;
  int? personFound;
  int? thingsFound;


  MissingFoundData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    iV = json['__v'];
    personFound = json['personFound'];
    thingsFound = json['thingsFound'];
  }


}
