class Report {
  final String uid;
  final String rid;
  final String type;
  final String date;
  final String time;
  final String storagePath;
  final String downloadUrl;
  final Map<String, dynamic> coordinates;
  bool finished;
  bool addressed;
  String desc;
  String addressedBy;
  String address;

  Report(
      {required this.uid,
      required this.rid,
      required this.type,
      this.addressed = false,
      this.finished = false,
      this.desc = '',
      required this.storagePath,
      required this.downloadUrl,
      required this.date,
      required this.time,
      required this.coordinates,
      this.addressedBy = '',
      required this.address
      });

  Report.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        rid = data['rid'],
        type = data['type'],
        addressed = data['addressed'],
        finished = data['finished'],
        desc = data['desc'],
        storagePath = data['storagePath'],
        downloadUrl = data['downloadUrl'],
        date = data['date'],
        time = data['time'],
        coordinates = data['coordinates'],
        addressedBy = data['addressedBy'],
        address = data['address'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'rid': rid,
      'type': type,
      'desc': desc,
      'storagePath': storagePath,
      'downloadUrl': downloadUrl,
      'date': date,
      'time': time,
      'coordinates': coordinates,
      'addressed': addressed,
      'finished': finished,
      'addressedBy':addressedBy,
      'address': address
    };
  }
}
