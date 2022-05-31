class AcceptThingsAdmin {
  String? status;
  String? message;
  Data? data;


  AcceptThingsAdmin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? sId;
  String? name;
  String? type;
  String? state;
  String? model;
  String? color;
  String? description;
  String? photo;
  String? date;
  String? location;
  String? phone;
  String? messengerUserName;
  String? userID;
  bool? accept;
  String? castDate;
  int? iV;



  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    state = json['state'];
    model = json['model'];
    color = json['color'];
    description = json['description'];
    photo = json['photo'];
    date = json['date'];
    location = json['location'];
    phone = json['phone'];
    messengerUserName = json['messengerUserName'];
    userID = json['userID'];
    accept = json['Accept'];
    castDate = json['castDate'];
    iV = json['__v'];
  }


}