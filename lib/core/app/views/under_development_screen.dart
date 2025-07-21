import 'package:ecommerce_app/core/app/resources/media.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class UnderDevelopmentScreen extends StatelessWidget {
  const UnderDevelopmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Lottie.asset(Media.underDevelopmentScreen),
              const Text(
                'Page Under Development',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
    );
  }
}
