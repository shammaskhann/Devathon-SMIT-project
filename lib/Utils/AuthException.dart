import 'Utils.dart';

class AuthException {
  static authExceptionToast(error) {
    switch (error.code) {
      case "invalid-email":
        Utils.toastMessage("Your email address appears to be malformed.");
        break;
      case "wrong-password":
        Utils.toastMessage("Your password is wrong.");
        break;
      case "user-not-found":
        Utils.toastMessage("User with this email doesn't exist.");
        break;
      case "user-disabled":
        Utils.toastMessage("User with this email has been disabled.");
        break;
      case "too-many-requests":
        Utils.toastMessage("Too many requests. Try again later.");
        break;
      case "operation-not-allowed":
        Utils.toastMessage(
            "Signing in with Email and Password is not enabled.");
        break;
      default:
        Utils.toastMessage("An undefined Error happened.");
    }
  }
}
