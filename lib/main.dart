import 'package:ecommerce_app/controller/product_controller.dart';
import 'package:ecommerce_app/global.dart';
import 'package:ecommerce_app/route/app_pages.dart';
import 'package:ecommerce_app/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; 
import 'package:get/get.dart';

Future<void> main() async {
  await Global.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(392.72, 856.72),
      builder: (context, child) => GetMaterialApp(
        // themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashScreen,
        getPages: AppPages.routes,
      ),
    );
  }
}
