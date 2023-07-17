import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_app_test/core/services/language_service.dart';

import '../core/config/config.dart';
import '../core/services/sim_service.dart';
import 'placeholder_page.dart';
import 'webview_page.dart';
class MainScreen extends StatefulWidget {

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    initialize();
     super.initState();
  }

  initialize()async {



     await checkConfigs();


  }




   checkConfigs()   async {



    final countryCode  = await SimService.getCountryCode();


    final locale =   LanguageService.getDeviceLanguage();



    print("country code $countryCode");
    bool condition = false;


    if(countryCode.toLowerCase() == Config.targetSimCountry && locale.languageCode.toLowerCase() == Config.targetDeviceLocalization) {
      condition = true;
    }



    navigate(condition);
  }


  void navigate(bool condition)   {

    if (condition) {
      Navigator.of(context).pushReplacementNamed(WebviewPage.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(PlaceholderPage.routeName);
    }
  }


  @override
  Widget build(BuildContext context) {
    return   const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
