import 'package:dblog/view/style/colors/colorstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/customindicator.dart';
import "package:google_fonts/google_fonts.dart";

class CustomThemes {
  static Color forgroundlight = const Color(0xFFFAFBFD);
  static Color forgrounddark = const Color(0xFF48484A);
  static Color backgroundlight = const Color(0xFFF2F6F9);
  static Color backgrounddark = const Color(0xFF1C1C1E);

  static TextTheme lightTextTheme = TextTheme(
    bodyLarge: GoogleFonts.lora(
      fontSize: 18,
      height: 1.6,
      color: Colors.black87,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: GoogleFonts.lora(
      fontSize: 22,
      color: ColorStyle.black,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.lora(
      fontSize: 16,
      color: ColorStyle.black,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: GoogleFonts.lora(
      fontSize: 13,
      color: ColorStyle.black,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: GoogleFonts.lora(
      fontSize: 15,
      color: ColorStyle.black,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: GoogleFonts.lora(
      fontSize: 12,
      color: ColorStyle.lightgray,
    ),
    labelMedium: GoogleFonts.lora(
      fontSize: 15,
      color: ColorStyle.black,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    bodyLarge: GoogleFonts.lora(
      fontSize: 18,
      height: 1.6,
      color: ColorStyle.white,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: GoogleFonts.lora(
      fontSize: 22,
      color: ColorStyle.white,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.lora(
      fontSize: 16,
      color: ColorStyle.white,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: GoogleFonts.lora(
      fontSize: 13,
      color: ColorStyle.white,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: GoogleFonts.lora(
      fontSize: 15,
      color: ColorStyle.white,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: GoogleFonts.lora(
      fontSize: 12,
      color: ColorStyle.lightgray,
    ),
    labelMedium: GoogleFonts.lora(
      fontSize: 15,
      color: ColorStyle.white,
    ),
  );

  static ThemeData light() {
    return ThemeData(
        brightness: Brightness.light,
        textTheme: lightTextTheme,
        scaffoldBackgroundColor: backgroundlight,
        cardColor: ColorStyle.white,
        canvasColor: Colors.black,
        tabBarTheme: TabBarTheme(
          indicator: const CustomIndicator(color: ColorStyle.black, radius: 3),
          unselectedLabelColor: ColorStyle.black.withOpacity(0.4),
          indicatorColor: ColorStyle.black,
          labelColor: ColorStyle.black,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: forgroundlight,
        ),
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
              iconTheme: const IconThemeData(color: ColorStyle.black),
              elevation: 0.3,
              foregroundColor: forgroundlight,
              backgroundColor: backgroundlight,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: backgroundlight),
            ));
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      textTheme: darkTextTheme,
      scaffoldBackgroundColor: backgrounddark,
      cardColor: Colors.grey[900],
      canvasColor: Colors.white,
      tabBarTheme: TabBarTheme(
        indicator: const CustomIndicator(
          color: ColorStyle.white,
          radius: 3,
        ),
        unselectedLabelColor: ColorStyle.white.withOpacity(0.4),
        indicatorColor: ColorStyle.white,
        labelColor: ColorStyle.white,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: forgrounddark,
      ),
      appBarTheme: ThemeData.dark().appBarTheme.copyWith(
            elevation: 0.3,
            backgroundColor: backgrounddark,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarColor: backgrounddark),
          ),
    );
  }
}
