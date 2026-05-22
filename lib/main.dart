import 'package:bloc_test/Auth/Login.dart';
import 'package:bloc_test/Auth/Sign.dart';
import 'package:bloc_test/Homo.dart';
import 'package:bloc_test/widget/request_Home.dart' show RequestHome;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Builder,
        MaterialApp,
        MediaQuery,
        Size,
        StatelessWidget,
        Widget,
        WidgetsFlutterBinding,
        runApp;
import 'package:flutter_screenutil/flutter_screenutil.dart' show ScreenUtilInit;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

late SharedPreferences sharedPerf;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPerf = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          final size = MediaQuery.of(context).size;
          print('Width: ${size.width}, Height: ${size.height}');

          return ScreenUtilInit(
            designSize: Size(size.width, size.height),
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                // home: Home(),
                initialRoute: sharedPerf.getString("routes") ?? "Home",
                routes: {
                  "Home": (context) => Home(),
                  "Login": (context) => Login(),
                  "Sign": (context) => Sign(),
                  "HomeRequest": (context) => RequestHome(),
                },
              );
            },
          );
        },
      ),
    );
  }
}
