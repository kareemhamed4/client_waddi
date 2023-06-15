class UserModelFB {
  String? name;
  String? companyName;
  String? image;
  String? email;
  String? phone;
  String? uId;
  num? latitude;
  num? longitude;

  UserModelFB({this.name,this.email,this.uId,this.companyName,this.image,this.phone,this.latitude,
    this.longitude,});

  UserModelFB.fromJson(Map<String,dynamic> json){
    name = json["name"];
    companyName = json["companyName"];
    email = json["email"];
    image = json["image"];
    phone = json["phone"];
    uId = json["uId"];
    latitude = json["latitude"];
    longitude = json["longitude"];
  }

  Map<String,dynamic> toMap(){
    return {
      "name": name,
      "companyName": companyName,
      "email": email,
      "image": image,
      "phone": phone,
      "uId": uId,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}