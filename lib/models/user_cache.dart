class UserCache {
  // true = first time: open popup or page
  // false: don't open popup or page
  static bool onboarding = true;
  static bool login = true;

  static bool pomodoro = true;

  static bool calendar = true;
  static bool schedule = true;
  static bool qpi = true;

  static bool enlistment = true;
  static bool lsDirectory = true;

  static List<int> pomodoroTimers = [60 * 5, 60 * 25, 60 * 15];

  static void load() async {
    //
  }

  static void save() async {
    //
  }
}
