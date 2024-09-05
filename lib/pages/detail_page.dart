import 'package:ecommerce_app/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../controller/cart_controller.dart';
import '../controller/detail_controller.dart';
import '../helper/detail_data.dart';
import '../route/app_routes.dart';
import '../utils/dimensions.dart';

class DetailPage extends GetView<DetailController> {
  final int pageId;

  DetailPage({super.key, required this.pageId}) {
    print("Detail Page Id  : $pageId");
    if (!controller.shoeSize.containsKey(pageId)) {
      controller.shoeSize[pageId] = [];
    }
  }

  // final detailController = Get.find<DetailController>();
  final _cartController = Get.find<CartController>();
  final homeController = Get.find<HomeController>();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.until(
          (route) {
            if (route.settings.name == AppRoutes.getInitial() &&
                route.isCurrent) {
              return true;
            }
            return false;
          },
        );

        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    width: double.maxFinite,
                    height: Dimensions.height30 * 12,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            homeController.popularData[pageId]['image']),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: Dimensions.height15,
                  left: Dimensions.height15,
                  top: Dimensions.height30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: Dimensions.height45 * 0.85,
                        width: Dimensions.height45 * 0.85,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        child: IconButton(
                          onPressed: () {
                            Get.until(
                              (route) {
                                if (route.settings.name ==
                                        AppRoutes.getInitial() &&
                                    route.isCurrent) {
                                  return true;
                                }
                                return false;
                              },
                            );
                          },
                          icon: Icon(Icons.arrow_back),
                        ),
                      ),
                      GetBuilder<CartController>(builder: (cartController) {
                        // print("Page Id : ${pageId}");
                        return cartController.cartData.isEmpty
                            ? Container(
                                height: Dimensions.height45 * 0.95,
                                width: Dimensions.height45 * 0.95,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                alignment: Alignment.center,
                                child: IconButton(
                                  onPressed: () {
                                    print("Go to Cart Page");
                                    Get.toNamed(AppRoutes.getCartPage());
                                  },
                                  icon: Icon(Icons.shopping_cart_outlined),
                                ),
                              )
                            : Badge(
                                alignment: Alignment.topRight,
                                label:
                                    Text("${cartController.cartData.length}"),
                                child: Container(
                                  height: Dimensions.height45 * 0.95,
                                  width: Dimensions.height45 * 0.95,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    onPressed: () {
                                      print("Go to Cart Page");
                                      Get.toNamed(AppRoutes.getCartPage());
                                    },
                                    icon: Icon(Icons.shopping_cart_outlined),
                                  ),
                                ),
                              );
                      })
                    ],
                  ),
                ),
                Positioned(
                  top: Dimensions.height30 * 10.6,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.only(
                      right: Dimensions.height20,
                      left: Dimensions.height20,
                      top: Dimensions.height20,
                    ),
                    width: Dimensions.screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius30),
                        topRight: Radius.circular(Dimensions.radius30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.context!.width * 0.5,
                                child: Text(
                                  homeController.popularData[pageId]["name"],
                                  style: TextStyle(
                                    color: AppColor.textColor1,
                                    fontSize: Dimensions.font24 * 0.9,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Text(
                                'Rs. ${homeController.popularData[pageId]["price"]}',
                                style: TextStyle(
                                  color: AppColor.secondaryColor,
                                  fontSize: Dimensions.font24 * 0.9,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.height10),
                          Row(
                            children: [
                              Icon(
                                Icons.branding_watermark,
                                color: AppColor.textColor2,
                                size: Dimensions.iconSize16,
                              ),
                              SizedBox(width: Dimensions.height5),
                              Text(
                                homeController.popularData[pageId]["brand"],
                                style: TextStyle(
                                  color: AppColor.textColor2,
                                  fontSize: Dimensions.font16 * 0.9,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.height10),
                          Wrap(
                            children: List.generate(
                              5,
                              (index) => Icon(
                                index < 3
                                    ? Icons.star
                                    : Icons.star_border_sharp,
                                color: index < 3
                                    ? AppColor.secondaryColor
                                    : AppColor.textColor2,
                                size: Dimensions.iconSize16,
                              ),
                            ),
                          ),
                          SizedBox(height: Dimensions.height20),
                          Text(
                            "Size",
                            style: TextStyle(
                              color: AppColor.textColor1,
                              fontSize: Dimensions.font24 * 0.9,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: Dimensions.height10),
                          Text(
                            "Select the size in dozen",
                            style: TextStyle(
                              color: AppColor.textColor2,
                              fontSize: Dimensions.font12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: Dimensions.height10),
                          GetBuilder<DetailController>(
                            builder: (detailController) {
                              int shoeSize = 7;
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // print("tapped");
                                          int size = shoeSize + index;
                                          detailController.setSize(
                                              pageId, size);
                                          // _bookingController.setPeople(pageId, size);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: Dimensions.height10),
                                          height: Dimensions.height45,
                                          width: Dimensions.width45,
                                          decoration: BoxDecoration(
                                            color: controller
                                                    .shoeSize[pageId]!
                                                    .contains(shoeSize + index)
                                                ? Colors.black
                                                : Colors.white,
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius12),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${shoeSize + index}",
                                              style: TextStyle(
                                                color: detailController
                                                        .shoeSize[pageId]!
                                                        .contains(
                                                            shoeSize + index)
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: Dimensions.font14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: Dimensions.height45,
                                        width: Dimensions.height45 * 3,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.height10),
                                          border: Border.all(
                                              color: detailController
                                                      .shoeSize[pageId]!
                                                      .contains(
                                                          shoeSize + index)
                                                  ? AppColor.activeColor
                                                  : AppColor.inactiveColor),
                                        ),
                                        child: GetBuilder<DetailController>(
                                            builder: (detailController) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  if (detailController
                                                          .shoeSize[pageId]
                                                          ?.contains(shoeSize +
                                                              index) ??
                                                      false) {
                                                    detailController.decrement(
                                                        shoeSize + index,
                                                        pageId);
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.remove,
                                                  color: detailController
                                                              .shoeSize[pageId]
                                                              ?.contains(
                                                                  shoeSize +
                                                                      index) ??
                                                          false
                                                      ? AppColor.activeColor
                                                      : AppColor.inactiveColor,
                                                ),
                                              ),
                                              Text(
                                                detailController.pageData[
                                                                pageId] !=
                                                            null &&
                                                        detailController.pageData[
                                                                    pageId]![
                                                                shoeSize +
                                                                    index] !=
                                                            null
                                                    ? "${detailController.pageData[pageId]![shoeSize + index]}"
                                                    : "0.0",
                                                style: TextStyle(
                                                  color: detailController
                                                              .shoeSize[pageId]
                                                              ?.contains(
                                                                  shoeSize +
                                                                      index) ??
                                                          false
                                                      ? AppColor.activeColor
                                                      : AppColor.inactiveColor,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  if (detailController
                                                          .shoeSize[pageId]
                                                          ?.contains(shoeSize +
                                                              index) ??
                                                      false) {
                                                    detailController.increment(
                                                        shoeSize + index,
                                                        pageId);
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.add,
                                                  color: detailController
                                                              .shoeSize[pageId]
                                                              ?.contains(
                                                                  shoeSize +
                                                                      index) ??
                                                          false
                                                      ? AppColor.activeColor
                                                      : AppColor.inactiveColor,
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(height: Dimensions.height20),
                          Text(
                            "Description",
                            style: TextStyle(
                              color: AppColor.textColor1,
                              fontSize: Dimensions.font24 * 0.9,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: Dimensions.height10),
                          Text(
                            homeController.popularData[pageId]["description"],
                            style: TextStyle(
                              color: AppColor.textColor2,
                              fontSize: Dimensions.font12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: Dimensions.height45 * 2),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: Dimensions.height45 * 2,
                    padding: EdgeInsets.only(
                      right: Dimensions.height20,
                      left: Dimensions.height20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 210, 210, 210),
                          blurRadius: 10,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetBuilder<DetailController>(
                          builder: (detailController) {
                            return InkWell(
                              onTap: () => detailController.setFavourite(),
                              child: Container(
                                height: Dimensions.height30 * 2,
                                width: Dimensions.height30 * 2,
                                decoration: BoxDecoration(
                                  color: detailController.isFavourite
                                      ? Colors.white
                                      : AppColor.secondaryColor,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius12),
                                  border: Border.all(
                                    color: detailController.isFavourite
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(CupertinoIcons.heart_fill,
                                      color: detailController.isFavourite
                                          ? Colors.black
                                          : Colors.white),
                                ),
                              ),
                            );
                          },
                        ),
                        InkWell(
                          onTap: () {
                            print("Data Added to Cart");
                            _cartController.addCart(pageId, controller , homeController);
                          },
                          child: Container(
                            height: Dimensions.height30 * 2,
                            width: Dimensions.height30 * 6,
                            decoration: BoxDecoration(
                              color: AppColor.secondaryColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Add Cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimensions.font24 * 0.9,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.width10,
                                ),
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  color: AppColor.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
