import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/controller/checkout_controller.dart';
import 'package:ecommerce_app/route/app_routes.dart';
import 'package:ecommerce_app/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutPage extends StatelessWidget {
  final CheckoutController checkoutController = Get.put(CheckoutController());

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
            'Checkout',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox( width: Dimensions.width10,),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
     GestureDetector(
                        onTap: () {
                          checkoutController.isSelected();
                        },
                        child: GetBuilder<CheckoutController>(
                          builder: (detailController) {
                            return Container(
                              height: Dimensions.height30 * 2,
                              width: Dimensions.height30 * 2,
                              decoration: BoxDecoration(
                                color: detailController.selected
                                    ? Colors.white
                                    : AppColor.secondaryColor,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius30),
                                border: Border.all(
                                  color: detailController.selected
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                              child: Center(
                                child: Icon(Icons.local_shipping_outlined,
                                    color: detailController.selected
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            );
                          },
                        ),
                      ),
              SizedBox( width: Dimensions.width10,),
 Container(
  
                                      height: 5,
                                      width: 80,

      child: Divider(color: AppColor.activeColor,
      thickness: 1.5,)
      
      
    ),
           
              SizedBox( width: Dimensions.width10,),
GestureDetector(
                        onTap: () {
                          checkoutController.isSelected1();
                        },
                        child: GetBuilder<CheckoutController>(
                          builder: (detailController) {
                            return Container(
                              height: Dimensions.height30 * 2,
                              width: Dimensions.height30 * 2,
                              decoration: BoxDecoration(
                                color: detailController.selected1
                                    ? Colors.white
                                    : AppColor.secondaryColor,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius30),
                                border: Border.all(
                                  color: detailController.selected1
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                              child: Center(
                                child: Icon(Icons.payment_outlined,
                                    color: detailController.selected1
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            );
                          },
                        ),
                      ),
       SizedBox( width: Dimensions.width10,),
Container(
  
                                      height: 5,
                                      width: 80,

      child: Divider(color: AppColor.activeColor,
      thickness: 1.5,)
      
      
    ),
              SizedBox( width: Dimensions.width10,),
GestureDetector(
                        onTap: () {
                          checkoutController.isSelected2();
                        },
                        child: GetBuilder<CheckoutController>(
                          builder: (detailController) {
                            return Container(
                              height: Dimensions.height30 * 2,
                              width: Dimensions.height30 * 2,
                              decoration: BoxDecoration(
                                color: detailController.selected2
                                    ? Colors.white
                                    : AppColor.secondaryColor,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius30),
                                border: Border.all(
                                  color: detailController.selected2
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                              child: Center(
                                child: Icon(Icons.access_alarm_sharp,
                                    color: detailController.selected2
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            );
                          },
                        ),
                      ),
  ],
),

SizedBox(height: Dimensions.height30,),

Text('Delievered to : Syed Faizan Rasool',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),


SizedBox(height: Dimensions.height20,),

Container(
  height: 60,
  width: 400,
  decoration: BoxDecoration(
  // color: Colors.blue,
border: Border.symmetric(horizontal: BorderSide(width: 0.5))
  ),
  child: InkWell(
    onTap:(){
     Get.toNamed(AppRoutes.getdelieveryaddresspage());
    },
    child: Row(
      children: [
    Text('Add delievery address',style: TextStyle(fontSize: 20),),
    
    SizedBox(width: Dimensions.width45*3.2,),
    
    
        Icon(Icons.arrow_forward_ios_rounded)
      ],
    ),
  ),
),

SizedBox(height: Dimensions.height20,),



Text('Order Summary:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

SizedBox(height: Dimensions.height15,),


Row(
  children: [
Text('Total',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
       SizedBox( width: Dimensions.width30*9.5,),
Text('${checkoutController.price}',style: TextStyle(fontSize: 15),),

  ],
),

SizedBox(height: Dimensions.height20,),

Row(
  children: [
Text('Discount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
       SizedBox( width: Dimensions.width30*9,),
Text('0',style: TextStyle(fontSize: 15),),


  ],
),

SizedBox(height: Dimensions.height20,),

Row(
  children: [
Text('Sub Total',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
      SizedBox( width: Dimensions.width30*8.5,),
Text('${checkoutController.price}',style: TextStyle(fontSize: 15),),


  ],
),

SizedBox(height: Dimensions.height30,),
           Text(
                'Select Payment Method:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Dimensions.height20),
              InkWell(
                child: ListTile(
                  leading: Container(
                    width: 40, // Set the width and height to match the CircleAvatar's size
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color
                      shape: BoxShape.circle, // Ensure the container is circular
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/easypaisa.png",
                        fit: BoxFit.cover, // Ensure the image covers the entire space
                      ),
                    ),
                  ),
                  title: Text('EasyPaisa'),
                ),
              ),

              SizedBox(height: Dimensions.height20),
             ListTile(
  leading: Container(
    width: 40, // Set the width and height to match the CircleAvatar's size
    height: 40,
    decoration: BoxDecoration(
      color: Colors.white, // Background color
      shape: BoxShape.circle, // Ensure the container is circular
    ),
    child: ClipOval(
      child: Image.asset(
        "assets/images/jazzcash.png",
        fit: BoxFit.cover, // Ensure the image covers the entire space
      ),
    ),
  ),
  title: Text('JazzCash'),
),

              SizedBox(height: Dimensions.height20),

ListTile(
  leading: Container(
    width: 40, // Set the width and height to match the CircleAvatar's size
    height: 40,
    decoration: BoxDecoration(
      color: Colors.white, // Background color
      shape: BoxShape.circle, // Ensure the container is circular
    ),
    child: ClipOval(
      child:  Icon(Icons.account_balance_wallet),
    ),
  ),
  title: Text('Bank Account'),
), 

              SizedBox(height: Dimensions.height20),

             ListTile(
                                leading: GestureDetector(
                        onTap: () {
                          checkoutController.isSelected3();
                        },
                        child: GetBuilder<CheckoutController>(
                          builder: (detailController) {
                            return Container(
                              height: Dimensions.height5*5,
                              width: Dimensions.height5*5,
                              decoration: BoxDecoration(
                                color: detailController.selected3
                                    ? Colors.white
                                    : Colors.green,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius30),
                                border: Border.all(
                                  color: detailController.selected3
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                              child: Center(
                                child: Image(image: AssetImage("assets/images/medium dot.png") ,width: 30,height: 30,)
                              ),
                              
                            );
                          },
                        ),
                      ),

                // leading: Icon(Icons.account_balance_wallet),
                title: Text('Cash on Delivery'),
              ),


            //  Obx(() => RadioListTile<PaymentMethod>(
            //     title: Text('Cash on Delivery'),
            //     value: PaymentMethod.cashOnDelivery,
            //     groupValue: checkoutController.selectedPaymentMethod.value,
            //     onChanged: (PaymentMethod? value) {
            //       checkoutController.togglePaymentMethod(value);
            //     },
            //   )),

              // Obx(() => RadioListTile<PaymentMethod>(
              //       title: Text('JazzCash'),
              //       value: PaymentMethod.jazzCash,
              //       groupValue: checkoutController.selectedPaymentMethod.value,
              //       onChanged: (PaymentMethod? value) {
              //         checkoutController.setSelectedPaymentMethod(value!);
              //       },
              //     )),
              // Obx(() =>
              //  RadioListTile<PaymentMethod>(
              //       title: Text('EasyPaisa'),
              //       value: PaymentMethod.easyPaisa,
              //       groupValue: checkoutController.selectedPaymentMethod.value,
              //       onChanged: (PaymentMethod? value) {
              //         checkoutController.setSelectedPaymentMethod(value!);
              //       },
              //     )),
              // Obx(() => RadioListTile<PaymentMethod>(
              //       title: Text('Bank Account'),
              //       value: PaymentMethod.bankAccount,
              //       groupValue: checkoutController.selectedPaymentMethod.value,
              //       onChanged: (PaymentMethod? value) {
              //         checkoutController.setSelectedPaymentMethod(value!);
              //       },
              //     ))'
              
              SizedBox( height: Dimensions.height30,),
        
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
                                                  print('Selected Payment Method: ${checkoutController.selectedPaymentMethod.value}');
                                                Get.toNamed(AppRoutes.paymentPage);
                                                },
                                              child: Text(
                                                "Proceed to Payment",
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
            ],
          ),
        ),
      ),
    );
  }
}
