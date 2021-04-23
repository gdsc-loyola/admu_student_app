class Course {
  String courseCode;
  int units;
  double qpi;
  bool isIncludedInQPI;

  Course(String courseCode, int units, double qpi, bool isIncludedInQPI) {
    this.courseCode = courseCode;
    this.units = units;
    this.qpi = qpi;
    this.isIncludedInQPI = isIncludedInQPI;
  }
}
