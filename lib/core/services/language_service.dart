import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class LanguageService {
 static Locale getDeviceLanguage() {
   Locale  locale = const Locale("ru");
   bool isFromDevice  = false;
    if (ui.window.locales.isEmpty) {
      locale =  const Locale('ru');
    } else {

      isFromDevice = true;
     locale =  ui.window.locales.first;
    }

    debugPrint("Locale ${isFromDevice ?  "from device" :"not from device" } is cc:${locale.countryCode} lg:${locale.languageCode}");
    return locale;
  }
}
