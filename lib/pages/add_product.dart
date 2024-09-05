import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/button.dart';
import 'package:ecommerce_app/constants/textField.dart';
import 'package:ecommerce_app/controller/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/dashboard_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        // Get the existing DashBoardController instance
        DashBoardController dashBoardController =
            Get.find<DashBoardController>();
        dashBoardController.changeIndex(0);
        Get.back();
        return false; // return false to prevent default pop behavior
      },
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [ CustomTextField(
                  controller: controller.productBrandController,
                  prefixIcon: Icons.branding_watermark,
                  labelText: "Enter Product Brand"),
               SizedBox(height: Get.height * 0.01,),
                CustomTextField(
                    controller: controller.productNameController,
                    prefixIcon: Icons.shopping_bag,
                    labelText: "Enter Product Name"),
                SizedBox(height: Get.height * 0.01,),
                CustomTextField(
                    controller: controller.productPriceController,
                    prefixIcon: Icons.money,
                    labelText: "Enter Product Price"),
                SizedBox(height: Get.height * 0.01,),
                CustomTextField(
                    controller: controller.productDescriptionController,
                    prefixIcon: Icons.description,
                    labelText: "Enter Product Description"),
                SizedBox(height: Get.height * 0.01,),
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          controller.selectImage();
                        },
                        child: Text("Select Image")),
                    Obx(()=> controller.selectedImage.value == null
                        ? SizedBox()
                        : GestureDetector(
                      child: Image.file(controller.selectedImage.value!),
                      onTap: (){
                        controller.selectedImage.value = null;
                      },
                    )
                    )
                  ],
                ),
                SizedBox(height: Get.height * 0.03,),
                CustomButton(
                  onPressed: () {
                    controller.addProduct();
                    DashBoardController dashBoardController =
                        Get.find<DashBoardController>();
                    dashBoardController.changeIndex(0);
                    Get.back();
                  },
                  title: "Add Product",
                  color: AppColor.secondaryColor,
                  
                  isLoading: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
