import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primaryColor = Color(0xFF6C63FF);
  static const secondaryColor = Color(0xFFFF6584);
  static const accentColor = Color(0xFF4DCCC6);
  static const darkColor = Color(0xFF1E1E2C);
  static const lightColor = Color(0xFFF7F7FF);

  static const backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF7F7FF), Color(0xFFE6E6FA)],
    stops: [0.1, 0.9],
  );

  static const cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF2F2FF)],
  );

  static const buttonGradient = LinearGradient(
    colors: [primaryColor, Color(0xFF8A82FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const shadowGradient = LinearGradient(
    colors: [Colors.black12, Colors.black26],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const cardShadow = [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 16,
      offset: Offset(0, 6),
      spreadRadius: 0,
    )
  ];

  static const buttonShadow = [
    BoxShadow(
      color: Color(0x406C63FF),
      blurRadius: 12,
      offset: Offset(0, 4),
      spreadRadius: 0,
    )
  ];

  static const borderRadius = BorderRadius.all(Radius.circular(24));
  static const smallBorderRadius = BorderRadius.all(Radius.circular(12));

  static TextStyle heading1 = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: darkColor,
    height: 1.2,
  );

  static TextStyle heading2 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: darkColor,
    height: 1.3,
  );

  static TextStyle heading3 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: darkColor,
    height: 1.4,
  );

  static TextStyle bodyText = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: darkColor.withOpacity(0.8),
    height: 1.6,
  );

  static TextStyle buttonText = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: lightColor,
    height: 1.6,
  );

  static TextStyle caption = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: darkColor.withOpacity(0.6),
    height: 1.5,
  );

  static var greyColor;
}
