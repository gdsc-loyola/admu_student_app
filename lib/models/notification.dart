class Notif {
  int iconType;
  String title;
  String message;

  DateTime date;
  bool isRead;

  Notif(
    this.iconType,
    this.title,
    this.message,
    this.date,
    this.isRead,
  );

  // ?
  factory Notif.fromMap(Map<String, dynamic> map) {
    return Notif(
      map['iconType'],
      map['title'],
      map['message'],
      DateTime.parse(map['date']),
      map['isRead'],
    );
  }
}
