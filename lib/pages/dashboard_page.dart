import 'package:ecommerce_app/controller/dashboard_controller.dart';
import 'package:ecommerce_app/pages/add_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import 'cart_page.dart';
import 'home_page.dart';

class DashBoardPage extends GetView<DashBoardController> {

  DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    List _pages = [HomePage(), CartPage(), AddProductView()];

    return  GetBuilder<DashBoardController>(builder: (dashBoardController){
      return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: dashBoardController.selectedIndex,
        selectedItemColor: AppColor.secondaryColor,
        unselectedItemColor: AppColor.textColor2,
        onTap: (index) {
          dashBoardController.changeIndex(index);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                // color: AppColor.secondaryColor,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                // color: AppColor.secondaryColor,
              ),
              label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                // color: AppColor.secondaryColor,
              ),
              label: 'Products')
        ],
      ),
      body: _pages[dashBoardController.selectedIndex]
    );
    });
  }
}
