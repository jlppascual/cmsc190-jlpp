class Report {
  final String uid;
  final String rid;
  final String type;
  final String date;
  final String time;
  final Map<String, dynamic> coordinates;
  bool finished;
  bool addressed;
  String desc;

  Report(
      {required this.uid,
      required this.rid,
      required this.type,
      this.addressed = false,
      this.finished = false,
      this.desc = '',
      required this.date,
      required this.time,
      required this.coordinates});

  Report.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        rid = data['rid'],
        type = data['type'],
        addressed = data['addressed'],
        finished = data['finished'],
        desc = data['desc'],
        date = data['date'],
        time = data['time'],
        coordinates = data['coordinates'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'rid': rid,
      'type': type,
      'desc': desc,
      'date': date,
      'time': time,
      'coordinates': coordinates,
      'addressed': addressed,
      'finished': finished,
    };
  }
}
