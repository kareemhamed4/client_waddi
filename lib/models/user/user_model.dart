class UserModel {
  String? name;
  String? email;
  String? uId;
  String? phone;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;

  UserModel({this.name,this.email,this.phone,this.image,this.cover,this.bio,this.uId,this.isEmailVerified});

  UserModel.fromJson(Map<String,dynamic> json){
    name = json["name"];
    email = json["email"];
    uId = json["uId"];
    phone = json["phone"];
    image = json["image"];
    cover = json["cover"];
    bio = json["bio"];
    isEmailVerified = json["isEmailVerified"];
  }

  Map<String,dynamic> toMap(){
    return {
      "name": name,
      "email": email,
      "uId": uId,
      "phone": phone,
      "image": image,
      "cover": cover,
      "bio": bio,
      "isEmailVerified": isEmailVerified,
    };
  }
}