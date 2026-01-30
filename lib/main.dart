import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad_tech/core/constants/api_constants.dart';
import 'package:tharad_tech/features/layout/view/layout.dart';
import 'package:tharad_tech/features/login/view/login.dart';
import '/core/services/dio_helper.dart';
import '/core/services/get_storage_helper.dart';
import '/core/style/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  token = CacheHelper.getData<String>(key: tokenK) ?? '';
  log('token : $token');

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: AppTheme.currentTheme,
          home: child,
        );
      },
      child: (token == null || token == '')
          ? const LoginView()
          : const LayoutView(),
    );
  }
}
