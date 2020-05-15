part of alert_dialogs;

// Querying the environment via [Plattform] throws and exception on Flutter web
// This extension adds a new [isWeb] getter that should be used
// before checking for any of the other environments
extension PlatformWeb on Platform {
  static bool get isWeb {
    try {
      if (Platform.isAndroid ||
          Platform.isIOS ||
          Platform.isWindows ||
          Platform.isFuchsia ||
          Platform.isLinux ||
          Platform.isMacOS) {
        return false;
      }
      return true;
    } catch (e) {
      return true;
    }
  }
}
