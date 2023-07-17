import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/webview_cubit.dart';
import '../pages/main_screen.dart';
import '../pages/placeholder_page.dart';
import '../pages/webview_page.dart';

class Application extends StatelessWidget {
  const  Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WebviewCubit(),
        ),
        // BlocProvider(
        //   create: (context) => SubjectBloc(),
        // ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainScreen(),
        routes: {
          WebviewPage.routeName: (ctx) => const WebviewPage(),
          PlaceholderPage.routeName: (ctx) => const PlaceholderPage(),
        },
      ),
    );
  }
}
