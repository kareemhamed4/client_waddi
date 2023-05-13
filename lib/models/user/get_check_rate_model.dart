class CheckRateModel {
  String? from;
  String? to;
  Regular? regular;
  Regular? express;

  CheckRateModel({this.from, this.to, this.regular, this.express});

  CheckRateModel.fromJson(Map<String, dynamic> json) {
    from = json['From'];
    to = json['To'];
    regular =
    json['Regular'] != null ? Regular.fromJson(json['Regular']) : null;
    express =
    json['Express'] != null ? Regular.fromJson(json['Express']) : null;
  }
}

class Regular {
  int? cost;
  String? date;

  Regular({this.cost, this.date});

  Regular.fromJson(Map<String, dynamic> json) {
    cost = json['cost'];
    date = json['date'];
  }
}
