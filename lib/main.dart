import 'package:flutter/material.dart';
import 'package:weatherapp/weather_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  // await dotenv.load();
  runApp(DevicePreview(builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      splitScreenMode: true,
      minTextAdapt: true,
      builder:
          (context, child) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData.dark(useMaterial3: true),
            home: WeatherScreen(),
          ),
    );
  }
}
