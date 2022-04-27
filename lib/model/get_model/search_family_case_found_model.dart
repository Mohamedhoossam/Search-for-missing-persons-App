class SearchFamilyCaseFound {
  String? status;
  String? message;
  SearchFamilyFoundData? data;


  SearchFamilyCaseFound.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  SearchFamilyFoundData.fromJson(json['data']) : null;
  }

}

class SearchFamilyFoundData {
  String? sId;
  int? iV;
  int? personFound;
  int? thingsFound;


  SearchFamilyFoundData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    iV = json['__v'];
    personFound = json['personFound'];
    thingsFound = json['thingsFound'];
  }

}
