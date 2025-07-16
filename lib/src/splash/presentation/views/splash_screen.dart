import 'dart:async';
import 'package:ecommerce_app/core/constants/route_const.dart';
import 'package:ecommerce_app/core/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Future.delayed(const Duration(seconds: 2), () {
      context.go(RoutePath.initial);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaleTransition(
        scale: animation,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  height: 200,
                  width: 300,
                  image: AssetImage('assets/images/shoe_logo_1.png'),),
              Text(
                'Wearium',
                style: TextStyle(
                    fontSize: 32,
                    color: Colours.primary,
                    fontFamily: 'Balsamiq Sans'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
