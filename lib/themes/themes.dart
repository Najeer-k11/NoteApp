
import 'package:flutter/material.dart';

const noteb = TextTheme(
  titleLarge: TextStyle(
    fontFamily: 'Inter',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white
  ),
  titleMedium: TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    color: Color(0xfff1f1f1),
    fontWeight: FontWeight.bold
  ),
  bodyMedium: TextStyle(
    fontFamily: 'Inter',
    fontSize: 15,
    color: Color.fromARGB(255, 182, 182, 182)
  )
);


const notel = TextTheme(
  titleLarge: TextStyle(
    fontFamily: 'Inter',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black
  ),
  titleMedium: TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    color: Colors.black,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold
  ),
  bodyMedium: TextStyle(
    fontFamily: 'Inter',
    fontSize: 15,
    color: Color.fromARGB(159, 33, 33, 33)
  )
);




ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xff222222),
  cardColor: const Color(0xff1b1b1b),
  textTheme: noteb,
  iconTheme: const IconThemeData(
    color: Colors.white,
    size: 10
  ),
  highlightColor: Color.fromARGB(255, 62, 62, 64)

);


ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xffe8e8e8),
  cardColor: const Color(0xfffffefe),
  textTheme: notel,
  iconTheme: const IconThemeData(
    color: Colors.black,
    size: 10
  ),
  highlightColor: Color.fromARGB(249, 211, 211, 218)
);