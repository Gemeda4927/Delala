import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

// For home page
TextStyle headingStyle = const TextStyle(
  fontFamily: 'Poppins',
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  shadows: [
    Shadow(color: Colors.black26, offset: Offset(1, 1), blurRadius: 2),
  ],
);

TextStyle subheadingStyle = const TextStyle(
  fontFamily: 'Poppins',
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Colors.black87,
);

TextStyle captionStyle = const TextStyle(
  fontFamily: 'Poppins',
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: Colors.grey,
);

// import 'package:flutter/material.dart';
// import 'package:form_field_validator/form_field_validator.dart';

// Just for demo
const productDemoImg1 = "https://i.imgur.com/CGCyp1d.png";
const productDemoImg2 = "https://i.imgur.com/AkzWQuJ.png";
const productDemoImg3 = "https://i.imgur.com/J7mGZ12.png";
const productDemoImg4 = "https://i.imgur.com/q9oF9Yq.png";
const productDemoImg5 = "https://i.imgur.com/MsppAcx.png";
const productDemoImg6 = "https://i.imgur.com/JfyZlnO.png";

// End For demo

const grandisExtendedFont = "Grandis Extended";

// On color 80, 60.... those means opacity

const Color primaryColor = Color(0xFF7B61FF);

const MaterialColor primaryMaterialColor =
    MaterialColor(0xFF9581FF, <int, Color>{
  50: Color(0xFFEFECFF),
  100: Color(0xFFD7D0FF),
  200: Color(0xFFBDB0FF),
  300: Color(0xFFA390FF),
  400: Color(0xFF8F79FF),
  500: Color(0xFF7B61FF),
  600: Color(0xFF7359FF),
  700: Color(0xFF684FFF),
  800: Color(0xFF5E45FF),
  900: Color(0xFF6C56DD),
});

const Color blackColor = Color(0xFF16161E);
const Color blackColor80 = Color(0xFF45454B);
const Color blackColor60 = Color(0xFF737378);
const Color blackColor40 = Color(0xFFA2A2A5);
const Color blackColor20 = Color(0xFFD0D0D2);
const Color blackColor10 = Color(0xFFE8E8E9);
const Color blackColor5 = Color(0xFFF3F3F4);

const Color whiteColor = Colors.white;
const Color whileColor80 = Color(0xFFCCCCCC);
const Color whileColor60 = Color(0xFF999999);
const Color whileColor40 = Color(0xFF666666);
const Color whileColor20 = Color(0xFF333333);
const Color whileColor10 = Color(0xFF191919);
const Color whileColor5 = Color(0xFF0D0D0D);

const Color greyColor = Color(0xFFB8B5C3);
const Color lightGreyColor = Color(0xFFF8F8F9);
const Color darkGreyColor = Color(0xFF1C1C25);
// const Color greyColor80 = Color(0xFFC6C4CF);
// const Color greyColor60 = Color(0xFFD4D3DB);
// const Color greyColor40 = Color(0xFFE3E1E7);
// const Color greyColor20 = Color(0xFFF1F0F3);
// const Color greyColor10 = Color(0xFFF8F8F9);
// const Color greyColor5 = Color(0xFFFBFBFC);

const Color purpleColor = Color(0xFF7B61FF);
const Color successColor = Color(0xFF2ED573);
const Color warningColor = Color(0xFFFFBE21);
const Color errorColor = Color(0xFFEA5B5B);

const double defaultPadding = 16.0;
const double defaultBorderRadious = 12.0;
const Duration defaultDuration = Duration(milliseconds: 300);

// final passwordValidator = MultiValidator([
//   RequiredValidator(errorText: 'Password is required'),
//   MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
//   PatternValidator(r'(?=.*?[#?!@$%^&*-])',
//       errorText: 'passwords must have at least one special character')
// ]);

// class MultiValidator {
//   MultiValidator(List<dynamic> list);
// }

// final emaildValidator = MultiValidator([
//   RequiredValidator(errorText: 'Email is required'),
//   EmailValidator(errorText: "Enter a valid email address"),
// ]);

const pasNotMatchErrorText = "passwords do not match";

class AppConstants {
  // Colors
  static const Color primaryColor = Color(0xFF0288D1);
  static const Color accentColor = Color(0xFFFF6D00);
  static const Color backgroundColor = Color(0xFFF5F7FA);
  static const Color cardBackgroundColor = Color(0xFFFFFFFF);
  static const Color primaryTextColor = Color(0xFF2D3748);
  static const Color secondaryTextColor = Color(0xFF718096);
  static const Color errorColor = Color(0xFFE53E3E);
  static const Color successColor = Color(0xFF38A169);

  // Typography
  static TextStyle heading1 = GoogleFonts.dmSerifDisplay(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: primaryTextColor,
    letterSpacing: 0.5,
  );

  static TextStyle heading2 = GoogleFonts.dmSerifDisplay(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: primaryTextColor,
    letterSpacing: 0.3,
  );

  static TextStyle bodyText = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: secondaryTextColor,
    height: 1.5,
    letterSpacing: 0.2,
  );

  static TextStyle captionText = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: secondaryTextColor,
    height: 1.4,
  );

  static TextStyle buttonText = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Spacing
  static const double smallPadding = 8.0;
  static const double mediumPadding = 16.0;
  static const double largePadding = 24.0;
  static const double sectionSpacing = 32.0;

  // Border Radius
  static const BorderRadius cardBorderRadius =
      BorderRadius.all(Radius.circular(16));
  static const BorderRadius buttonBorderRadius =
      BorderRadius.all(Radius.circular(12));

  // Shadows
  static const BoxShadow cardShadow = BoxShadow(
    color: Color(0x1A000000),
    blurRadius: 8,
    offset: Offset(0, 4),
  );

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, Color(0xFF0277BD)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accentColor, Color(0xFFF4511E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
