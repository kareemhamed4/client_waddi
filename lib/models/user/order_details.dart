class OrderDetails {
  String? user;
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
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  OrderDetails(
      {this.user,
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
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    user = json['user'];
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
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}