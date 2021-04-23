class Event {
  String title;
  DateTime startDate;
  DateTime endDate;
  String label;
  String notes;
  bool isTask;

  Event(String title, DateTime startDate, DateTime endDate, String label,
      String notes, bool isTask) {
    this.title = title;
    this.startDate = startDate;
    this.endDate = endDate;
    this.label = label;
    this.notes = notes;
    this.isTask = isTask;
  }
}
