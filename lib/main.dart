import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_app_test/internal/application.dart';
import 'package:path_provider/path_provider.dart' as path_provider;


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();




  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(true);
  }



  final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);


    await Permission.phone  .request();

  runApp(const MaterialApp(home:   Application()));
}






