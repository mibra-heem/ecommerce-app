import 'package:ecommerce_app/pages/checkout_page.dart';

class AppRoutes{
  static const String initial = '/';
  static const String splashScreen = '/splash';
  static const String homePage = '/home';
  static const String detailPage = '/detail';
  static const String cartPage = '/cart';
  static const String profilePage = '/profile';
  static const String checkoutpage= '/checkout';
  static const String delieveryaddresspage = '/delieveryaddress';
  static const String paymentPage= '/paymentPage';


  static String getInitial()=> '$initial' ;
  static String getSplashScreen()=> '$splashScreen' ;
  static String getHomePage()=> '$homePage';
  static String getDetailPage(int pageId)=> '$detailPage?pageId=$pageId';
  static String getCartPage()=> '$cartPage';
  static String getProfilePage()=> '$profilePage';
  static String getCheckoutPage()=> '$checkoutpage';
  static String getdelieveryaddresspage()=> '$delieveryaddresspage';
  static String getpaymentPage()=> '$checkoutpage';


}