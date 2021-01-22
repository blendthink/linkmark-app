abstract class AppException implements Exception {
  String get message;

  String toString() {
    String message = this.message;
    if (message == null) return "AppException";
    return "AppException: $message";
  }
}
