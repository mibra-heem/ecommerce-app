import 'package:ecommerce_app/pages/cart_page.dart';
import 'package:ecommerce_app/pages/checkout_page.dart';
import 'package:ecommerce_app/pages/dashboard_page.dart';
import 'package:ecommerce_app/pages/delievery_address_page.dart';
import 'package:ecommerce_app/pages/detail_page.dart';
import 'package:ecommerce_app/pages/home_page.dart';
import 'package:ecommerce_app/pages/payment_page.dart';
import 'package:ecommerce_app/pages/splash_page.dart';
import 'package:get/get.dart';
import '../pages/add_product.dart';
import 'app_routes.dart';

class AppPages{

  static final List<GetPage> routes = [

    GetPage(
      name: AppRoutes.homePage,
      page: () => HomePage(),
      transition: Transition.fadeIn
    ),

    GetPage(
      name: AppRoutes.initial,
      page: () => DashBoardPage(),
      transition: Transition.fadeIn
    ),
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => SplashPage(),
      // binding: DashBoardBinding()
      transition: Transition.fadeIn
    ),
    
    GetPage(
      name: AppRoutes.detailPage,
      page: () { 
        var pageId = Get.parameters["pageId"];
        return DetailPage(pageId: int.parse(pageId!),);
      },
      transition: Transition.fadeIn
    ),
    GetPage(
      name: AppRoutes.cartPage,
      page: () => CartPage(),
      transition: Transition.fadeIn
    ),
    GetPage(
      name: AppRoutes.profilePage,
      page: () => AddProductView(),
      transition: Transition.fadeIn
    ),
    GetPage(
      name: AppRoutes.checkoutpage,
      page: () => CheckoutPage(),
      transition: Transition.fadeIn
    ),
    
     GetPage(
      name: AppRoutes.delieveryaddresspage,
      page: () => DelieveryAddressPage(),
      transition: Transition.fadeIn
    ),
    GetPage(
      name: AppRoutes.paymentPage,
      page: () => PaymentPage(),
      transition: Transition.fadeIn
    )
  ];

}