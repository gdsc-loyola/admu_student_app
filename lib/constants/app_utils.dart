class AppUtils {
  static bool isNumeric(String s) {
    if (s == null) return false;

    return double.tryParse(s) != null;
  }

  static bool isNonNegativeNumeric(String s) {
    if (s == null) return false;

    double val = double.tryParse(s);

    if (val != null && val >= 0)
      return true;
    else
      return false;
  }

  static bool isInteger(String s) {
    if (s == null) return false;

    return int.tryParse(s) != null;
  }

  static bool isPositiveInteger(String s) {
    if (s == null) return false;

    int val = int.tryParse(s);

    if (val != null && val > 0)
      return true;
    else
      return false;
  }
}
