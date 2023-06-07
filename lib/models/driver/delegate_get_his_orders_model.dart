class DelegateGetHisOrders {
  List<Orders>? orders;

  DelegateGetHisOrders({this.orders});

  DelegateGetHisOrders.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
  }
}

class Orders {
  String? sId;
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
  num? weight;
  List<String>? dimension;
  int? services;
  String? deliverTime;
  String? status;
  int? paymentId;
  String? notes;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? delegate;
  String? supervisor;

  Orders(
      {this.sId,
        this.user,
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
        this.iV,
        this.delegate,
        this.supervisor});

  Orders.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    delegate = json['delegate'];
    supervisor = json['supervisor'];
  }
}
