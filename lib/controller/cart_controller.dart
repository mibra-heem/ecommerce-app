import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../helper/detail_data.dart';

class CartController extends GetxController {
  List cartData = [];
  List people = [];
  late double totalPrice;

  void setCart(key, value) {
    update();
  }

  String formatAmountWithCommas(double amount) {
    NumberFormat formatter = NumberFormat('#,###');
    return formatter.format(amount);
  }

  void getTotalPrice() {
    totalPrice = 0;
    for (int i = 0; i < cartData.length; i++) {
      cartData[i]["shoeData"].keys.map((size) {
        totalPrice += (cartData[i]["shoeData"][size] * 12) * int.parse(cartData[i]["price"]);
      }).toList();
    }
  }

  void removeCart(id) {
    cartData.remove(id);
    update();
  }

  // void formater(){
  //   totalPrice.toString();
  // }

  void addCart(int pageId, var detailController , homeController) {
    bool found = false;

    for (int i = 0; i < cartData.length; i++) {
      if (cartData[i].containsValue(pageId)) {
        cartData[i] = {
          "pageId": pageId,
          "brand": homeController.popularData[pageId]["brand"],
          "name": homeController.popularData[pageId]["name"],
          "description": homeController.popularData[pageId]["description"],
          "price": homeController.popularData[pageId]["price"],
          "image": homeController.popularData[pageId]["image"],
          "shoeData": detailController.pageData[pageId]
        };
        found = true;
        break;
      }
    }

    if (!found) {
      if (detailController.pageData[pageId].isNotEmpty) {
        cartData.add({
           "pageId": pageId,
          "brand": homeController.popularData[pageId]["brand"],
          "name": homeController.popularData[pageId]["name"],
          "description": homeController.popularData[pageId]["description"],
          "price": homeController.popularData[pageId]["price"],
          "image": homeController.popularData[pageId]["image"],
          "shoeData": detailController.pageData[pageId]
        });
      }
      else{
        Get.snackbar('Plz select the shoe size and quantity', 'Cart should not be empty',backgroundColor: AppColor.green);
      }
    }
    print(cartData.length);
    update();
  }
}
