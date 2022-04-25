class UserThingsCaseModel {
  String? status;
  Null? message;
  List<ThingsCaseData>? data;
  UserThingsCaseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ThingsCaseData>[];
      json['data'].forEach((v) {
        data!.add( ThingsCaseData.fromJson(v));
      });
    }
  }

}

class ThingsCaseData {
  String? sId;
  String? name;
  String? type;
  String? state;
  String? model;
  String? color;
  String? carNumber;
  String? description;
  String? photo;
  String? date;
  String? location;
  String? phone;
  String? whatsNamber;
  String? messengerUserName;
  String? userID;
  bool? accept;
  String? castDate;
  int? iV;

  ThingsCaseData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    state = json['state'];
    model = json['model'];
    color = json['color'];
    carNumber = json['car_number'];
    description = json['description'];
    photo = json['photo'];
    date = json['date'];
    location = json['location'];
    phone = json['phone'];
    whatsNamber = json['whatsNamber'];
    messengerUserName = json['messengerUserName'];
    userID = json['userID'];
    accept = json['Accept'];
    castDate = json['castDate'];
    iV = json['__v'];
  }

}
