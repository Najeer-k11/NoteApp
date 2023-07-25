
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
    return MaterialApp(
      theme: lightTheme ,
      themeMode: ThemeMode.system ,
      darkTheme: darkTheme,
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      home: HomePage() ,

    );
  }
}
