class ThingsCaseFound {
  String? status;
  String? message;
  ThingsFoundData? data;


  ThingsCaseFound.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  ThingsFoundData.fromJson(json['data']) : null;
  }

}

class ThingsFoundData {
  String? sId;
  int? iV;
  int? personFound;
  int? thingsFound;


  ThingsFoundData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    iV = json['__v'];
    personFound = json['personFound'];
    thingsFound = json['thingsFound'];
  }

}
