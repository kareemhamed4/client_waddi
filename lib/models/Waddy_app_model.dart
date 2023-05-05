class LoginRequestModel {
  late String email;
  late String password;

  LoginRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email,
      'password': password,
    };
    return map;
  }
}

class LoginResponseModel {
  final String token;
  final String user;

  LoginResponseModel({required this.token, required this.user});

  factory LoginResponseModel.fromJason(Map<String, dynamic> json) {
    return LoginResponseModel(token: json['token'], user: json['error']);
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData({
    this.email,
    this.name,
    this.phone,
    this.id,
    this.image,
    this.points,
    this.credit,
    this.token,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
    email = json['email'];
  }
}
