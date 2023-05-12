class UserModel {
  String? name;
  String? companyName;
  String? image;
  String? email;
  String? phone;
  String? uId;

  UserModel({this.name,this.email,this.uId,this.companyName,this.image,this.phone});

  UserModel.fromJson(Map<String,dynamic> json){
    name = json["name"];
    companyName = json["companyName"];
    email = json["email"];
    image = json["image"];
    phone = json["phone"];
    uId = json["uId"];
  }

  Map<String,dynamic> toMap(){
    return {
      "name": name,
      "companyName": companyName,
      "email": email,
      "image": image,
      "phone": phone,
      "uId": uId,
    };
  }
}