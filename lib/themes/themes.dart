import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const scaffoldbg = Color(0xff1f2626);
const primarycolor = Color(0xff004646);
const secondarycolor = Color(0xff00c2c2);

const textdark = Color(0xffffffff);
const textlight = Color(0xff121232);
const textshade2light = Colors.black45;
const textshade2dark = Colors.white60;


ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  shadowColor: Colors.black.withOpacity(0.1),
  focusColor: Colors.black,
  disabledColor: Colors.grey,
  textTheme: TextTheme(
    displayMedium: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 35),
    bodyMedium: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500),
    bodySmall: GoogleFonts.poppins(color: Colors.black45,fontWeight: FontWeight.w400)
  ),
  iconTheme: const IconThemeData(
    color: Colors.black
  )
);


ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  focusColor: Colors.white,
  disabledColor: Colors.grey,
  shadowColor: Colors.white.withOpacity(0.3),
  textTheme: TextTheme(
    displayMedium: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 35),
    bodyMedium: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w500),
    bodySmall: GoogleFonts.poppins(color: Colors.white70,fontWeight: FontWeight.w400)
  ),
  iconTheme: const IconThemeData(
    color: Colors.white
  )
);