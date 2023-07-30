import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:todos/screens/home.dart';
import 'package:todos/themes/themes.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
     builder: (context, child) => MaterialApp(
      home: HomePage(),
      darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData.light(useMaterial3: true,),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      themeAnimationCurve: Curves.bounceInOut,
      themeAnimationDuration: Duration(seconds: 1),
     ),
     designSize: const Size(315, 730),
    );
  }
}
