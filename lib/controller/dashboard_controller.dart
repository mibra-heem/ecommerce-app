import 'package:get/get.dart';

class DashBoardController extends GetxController{

  int selectedIndex = 0;

  changeIndex(index){

    selectedIndex = index;
    update();
    print("Selected Index : ${selectedIndex}");
  }

}