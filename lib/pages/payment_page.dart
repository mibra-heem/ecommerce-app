import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/controller/dashboard_controller.dart';
import 'package:ecommerce_app/helper/detail_data.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        // Get the existing DashBoardController instance
        DashBoardController dashBoardController = Get.find<DashBoardController>();
        dashBoardController.changeIndex(0);
        Get.back();
        return false; // return false to prevent default pop behavior
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Payment'),
          backgroundColor: AppColor.secondaryColor,
        ),
        body: Center(child: Text('Payment Gateway not added yet...',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)))),
    ); 
  }
}




 