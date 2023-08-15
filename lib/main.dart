
import 'package:flutter/material.dart';
import 'package:todos/screens/home.dart';
import 'package:todos/screens/noteMaker.dart';
import 'package:todos/themes/themes.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: const HomePage(),
     darkTheme: darkTheme,
     theme: lightTheme,
     themeMode: ThemeMode.system,
     debugShowCheckedModeBanner: false,
     routes: {
      '/homepage' :(context) => const HomePage(),
      '/noteMaker':(context) => const NoteMaker(),
     },
    );
  }
}
