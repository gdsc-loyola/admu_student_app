class Course {
  String courseCode;
  int units;
  double qpi;
  bool isIncludedInQPI;

  // String get code => _courseCode;
  // int get units => _units;
  // double get qpi => _qpi;
  // bool get isIncludedInQPI => _isIncludedInQPI;

  // set qpi(double newQPI) {
  //   _qpi = newQPI;
  // }

  Course(String courseCode, int units, double qpi, bool isIncludedInQPI) {
    this.courseCode = courseCode;
    this.units = units;
    this.qpi = qpi;
    this.isIncludedInQPI = isIncludedInQPI;
  }
}
