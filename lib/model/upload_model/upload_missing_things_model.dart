class UploadMissingThings {
  String? status;
  String? message;
  Data? data;

  UploadMissingThings.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }


}

class Data {
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
  String? sId;
  int? iV;



  Data.fromJson(Map<String, dynamic> json) {
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
    sId = json['_id'];
    iV = json['__v'];
  }

}
