class LoginModel {
  String? token;
  User? user;

  LoginModel({this.token, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? password;
  String? address;
  int? role;
  String? userImg;
  int? iV;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.password,
        this.address,
        this.role,
        this.userImg,
        this.iV});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    address = json['address'];
    role = json['role'];
    userImg = json['userImg'];
    iV = json['__v'];
  }
}