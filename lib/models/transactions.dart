// ignore: file_names
class Transactions {
  late int? id;
  String title;
  String detail;
  String writer;
  String date;
  String time;

  Transactions(
      {this.id,
      required this.title,
      required this.detail,
      required this.writer,
      required this.date,
      required this.time});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'detail': detail,
      'writer': writer,
      'date': date,
      'time': time,
    };
  }
}
