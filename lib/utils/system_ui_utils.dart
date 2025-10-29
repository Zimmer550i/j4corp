import 'package:flutter/services.dart';

/// Sets the status bar icons and text to dark (for light backgrounds).
void setStatusBarDarkIcons() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
}

/// Sets the status bar icons and text to light (for dark backgrounds).
void setStatusBarLightIcons() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
}
