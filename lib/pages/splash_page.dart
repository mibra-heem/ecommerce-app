import 'dart:async';
import 'package:ecommerce_app/controller/product_controller.dart';
import 'package:ecommerce_app/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController controller;


  _loadResources()async{
    await Get.find<ProductController>().getProducts();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadResources();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Future.delayed(Duration(seconds: 2), () { 

      Get.offNamed(AppRoutes.getInitial());

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaleTransition(
        scale: animation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                // color: AppColor.mainColor,
                height: 200,
                width: 300,
                // color: AppColor.secondaryColor,
                image: AssetImage("assets/images/shoe_logo_1.png")
              ),
              Text("Wearium", style: TextStyle(
                fontSize: 32,
                color: AppColor.mainColor,
                fontFamily: "Balsamiq Sans"
              ),)
            ],
          ),
        ),
      ),
    );
  }
}