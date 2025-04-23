import 'package:toastification/toastification.dart';

class AppSettings {
  static bool _isToastShowing = false;

  static set showToast(bool value) => _isToastShowing = value;

  static bool get isToastShowing => _isToastShowing;

  static ToastificationCallbacks onToastCalls() {
    return ToastificationCallbacks(
      onAutoCompleteCompleted: (value) {
        AppSettings.showToast = false;
      },
      onCloseButtonTap: (value) {
        AppSettings.showToast = false;
      },
      onDismissed: (value) {
        AppSettings.showToast = false;
      },
    );
  }
}
