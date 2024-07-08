// ignore: file_names
class Userattendancehistory {
  String? staffID;
  DateTime? date;
  int? month;
  int? year;
  DateTime? entryTime;
  DateTime? exitTime;

  Userattendancehistory({
    required this.staffID,
    required this.date,
    required this.month,
    required this.year,
    required this.entryTime,
    required this.exitTime,
  });

  factory Userattendancehistory.fromJson(Map<String, dynamic> json) {
    return Userattendancehistory(
      staffID: json['staff_ID'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      month: json['month'],
      year: json['year'],
      entryTime:
          json['entryTime'] != null ? DateTime.parse(json['entryTime']) : null,
      exitTime:
          json['exitTime'] != null ? DateTime.parse(json['exitTime']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['staff_ID'] = staffID;
    data['date'] = date?.toIso8601String();
    data['month'] = month;
    data['year'] = year;
    data['entryTime'] = entryTime?.toIso8601String();
    data['exitTime'] = exitTime?.toIso8601String();
    return data;
  }

  static List<Userattendancehistory> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => Userattendancehistory.fromJson(json))
        .toList();
  }
}
