// ignore: file_names
class Transactions {
  late int? id;
  String title;
  String detail;
  String writer;
  String date;

  Transactions(
      {this.id,
      required this.title,
      required this.detail,
      required this.writer,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'detail': detail,
      'writer': writer,
      'date': date
    };
  }
}
