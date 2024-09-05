import 'package:ecommerce_app/api/api_client.dart';
import 'package:ecommerce_app/controller/add_product_controller.dart';
import 'package:ecommerce_app/controller/product_controller.dart';
import 'package:ecommerce_app/repository/products_repo.dart';
import 'package:ecommerce_app/utils/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/cart_controller.dart';
import 'controller/dashboard_controller.dart';
import 'controller/detail_controller.dart';
import 'controller/home_controller.dart';
import 'firebase_options.dart';


class Global{
  static Future init()async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Get.put(ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: sharedPreferences));

    Get.put(ProductRepo(apiClient: Get.find()));

    Get.put(ProductController(productRepo: Get.find()));
    Get.put(DashBoardController());
    Get.put(HomeController(productController: Get.find()));
    Get.put(DetailController());
    Get.put(CartController());
    Get.put(AddProductController());

  }
}