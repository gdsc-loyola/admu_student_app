class Notif {
  int iconType;
  String title;
  String message;
  String calloutMessage;

  DateTime date;
  bool isRead;

  Notif(
    this.iconType,
    this.title,
    this.message,
    this.calloutMessage,
    this.date,
    this.isRead,
  );

  // ?
  factory Notif.fromMap(Map<String, dynamic> map) {
    return Notif(
      map['iconType'],
      map['title'],
      map['message'],
      map['callout'],
      DateTime.parse(map['date']),
      map['isRead'],
    );
  }
}
