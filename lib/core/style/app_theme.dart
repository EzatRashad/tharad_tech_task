import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/style/app_colors.dart';

class AppTheme {
  static bool dTheme = false;
  static ThemeMode currentTheme = ThemeMode.light;
  static ThemeData lightTheme = ThemeData(
    fontFamily: "Tajawal",

    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w700,
        fontFamily: "Tajawal",
        fontSize: 20.sp,
      ),
      titleMedium: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontFamily: "Tajawal",
        fontSize: 12.sp,
      ),
      titleSmall: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.normal,
        fontFamily: "Tajawal",
        fontSize: 10.sp,
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return Colors.grey[400]!;
      }),
    ),
  );
  //-------------------------------------------------------------------------------------------------
  static ThemeData darkTheme = ThemeData(
    fontFamily: "Tajawal",

    //  primaryColor: ColorsManager.white,
    // appBarTheme: AppBarTheme(
    //   backgroundColor: AppColors.black,
    //   elevation: 0,
    //   centerTitle: true,
    //   titleTextStyle: TextStyle(
    //     color: AppColors.white,
    //     fontSize: 19.sp,
    //     fontWeight: FontWeight.w700,
    //   ),
    //   iconTheme: IconThemeData(
    //     color: AppColors.white,
    //   ),
    // ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.white,
        fontFamily: "Tajawal",
        fontWeight: FontWeight.w700,
        fontSize: 20.sp,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontFamily: "Tajawal",
        fontWeight: FontWeight.w600,
        fontSize: 12.sp,
      ),
      titleSmall: TextStyle(
        color: Colors.white,
        fontFamily: "Tajawal",
        fontWeight: FontWeight.w400,
        fontSize: 10.sp,
      ),
    ),
  );
}
