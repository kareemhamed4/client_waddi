class ClientModel {
  String? msg;
  String? token;
  User? user;

  ClientModel({this.token, this.user,this.msg});

  ClientModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? password;
  String? address;
  String? companyName;
  String? industry;
  String? governorate;
  int? role;
  String? userImg;
  int? iV;

  User(
      {this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.password,
        this.address,
        this.companyName,
        this.industry,
        this.governorate,
        this.role,
        this.userImg,
        this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    address = json['address'];
    companyName = json['companyName'];
    industry = json['industry'];
    governorate = json['governorate'];
    role = json['role'];
    userImg = json['userImg'];
    iV = json['__v'];
  }
}