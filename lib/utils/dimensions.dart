// How to create new dimensions property
// For example,
// screenHeight = 856.7272727272727,
// screenWidth = 392.72727272727275,
// We need height10 first divide screenHeight/10
// Means 10 pixels height the answer will be 85.67
// Then, divide the screenHeight/85.67


import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;


  static double pageView = screenHeight/3.29507;
  static double pageViewContainer = screenHeight/4.2836;
  // static double pageViewTextContainer = screenHeight/7.13;


  // Draggable Widget
  static double draggableWidgetListHeight = screenHeight / 1.903;

  // dynamic height padding and margin
  static double height5 = screenHeight / 171.34;
  static double height10 = screenHeight / 85.67;
  static double height15 = screenHeight / 57.11;
  static double height20 = screenHeight / 42.83;
  static double height30 = screenHeight / 28.55;
  static double height45 = screenHeight / 19.03;

// dynamic width padding and margin
  static double width5 = screenHeight / 171.34;
  static double width10 = screenHeight / 85.67;
  static double width15 = screenHeight / 57.11;
  static double width20 = screenHeight / 42.83;
  static double width30 = screenHeight / 28.55;
  static double width45 = screenHeight / 19.03;

  // Font size
  static double font12 = screenHeight / 71.3939;
  static double font14 = screenHeight / 61.1948;
  static double font16 = screenHeight / 52.54;
  static double font20 = screenHeight / 42.83;
  static double font24 = screenHeight / 35.69;
  static double font26 = screenHeight / 32.95;

  // Radius
  static double radius10 = screenHeight / 85.67;
  static double radius12 = screenHeight / 71.3939;
  static double radius15 = screenHeight / 57.11;
  static double radius20 = screenHeight / 42.83;
  static double radius30 = screenHeight / 28.55;

  // IconSize
  static double iconSize24 = screenHeight / 35.69;
  static double iconSize16 = screenHeight / 53.54;

  // list view size
  // static double listViewImgSize =  screenWidth/3.27;
  // static double listViewTextContSize = screenWidth/3.92;

  // bottom height
  // static double bottomHeightBar = screenHeight/7.13;

  //Splash screen
  // static double splashImg = screenHeight / 3.46;
}
