class UserOrders {
  String? sId;
  int? originalIndex;
  User? user;
  String? trackId;
  String? senderName;
  String? senderPhone;
  String? senderEmail;
  String? senderPostalCode;
  String? senderAddress;
  String? receivedName;
  String? receivedPhone;
  String? receivedEmail;
  String? receivedPostalCode;
  String? receivedAddress;
  String? category;
  int? weight;
  List<String>? dimension;
  int? services;
  String? deliverTime;
  String? status;
  int? paymentId;
  String? notes;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserOrders(
      {this.sId,
        this.user,
        this.originalIndex,
        this.trackId,
        this.senderName,
        this.senderPhone,
        this.senderEmail,
        this.senderPostalCode,
        this.senderAddress,
        this.receivedName,
        this.receivedPhone,
        this.receivedEmail,
        this.receivedPostalCode,
        this.receivedAddress,
        this.category,
        this.weight,
        this.dimension,
        this.services,
        this.deliverTime,
        this.status,
        this.paymentId,
        this.notes,
        this.createdAt,
        this.updatedAt,
        this.iV});

  UserOrders.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    trackId = json['trackId'];
    senderName = json['senderName'];
    senderPhone = json['senderPhone'];
    senderEmail = json['senderEmail'];
    senderPostalCode = json['senderPostalCode'];
    senderAddress = json['senderAddress'];
    receivedName = json['receivedName'];
    receivedPhone = json['receivedPhone'];
    receivedEmail = json['receivedEmail'];
    receivedPostalCode = json['receivedPostalCode'];
    receivedAddress = json['receivedAddress'];
    category = json['category'];
    weight = json['weight'];
    dimension = json['dimension'].cast<String>();
    services = json['services'];
    deliverTime = json['deliverTime'];
    status = json['status'];
    paymentId = json['paymentId'];
    notes = json['notes'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class User {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? address;

  User(
      {this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.address});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
  }
}