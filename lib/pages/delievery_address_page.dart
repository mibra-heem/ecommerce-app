import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/controller/checkout_controller.dart';
import 'package:ecommerce_app/route/app_routes.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DelieveryAddressPage extends StatelessWidget {

CheckoutController checkoutController = CheckoutController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.secondaryColor,
          centerTitle: true,
          title: Text(
            'Add Delivery Address',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Postal Code',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
             Center(
                child: Container(
                                      height: Dimensions.height30 * 2,
                                      width: Dimensions.height30 * 8,
                                      decoration: BoxDecoration(
                                        color: AppColor.secondaryColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius12),
                                      ),
                                      
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                               onTap: () {
                                           Get.snackbar('Address added sucessfully','',backgroundColor: AppColor.green);
                                    Get.toNamed(AppRoutes.getCheckoutPage());


                                                  // print('Selected Payment Method: ${checkoutController.selectedPaymentMethod.value}');
                                                },
                                              child: Text(
                                                "Add Address",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: Dimensions.font24 * 0.9,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            // SizedBox(
                                            //   width: Dimensions.width10,
                                            // ),
                                            // Icon(
                                            //   Icons.shopping_cart_checkout_outlined,
                                            //   color: AppColor.white,
                                            // )
                                          ],
                                        ),
                                      ),
              ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     foregroundColor: AppColor.white , backgroundColor:AppColor.secondaryColor, // Text color
            //   ),
            //   onPressed: () {
            //    Get.snackbar('Address added sucessfully','',backgroundColor: AppColor.secondaryColor);
            //   },
            //   child: Text('Add Address'),
            // ),
          ],
        ),
      ),
    );
  }
}
