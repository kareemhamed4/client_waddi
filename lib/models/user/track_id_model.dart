class TrackIdModel {
  String? trackID;

  TrackIdModel.fromJason({required Map<String, String> json}) {
    trackID = json['trackId'].toString();
  }
}
