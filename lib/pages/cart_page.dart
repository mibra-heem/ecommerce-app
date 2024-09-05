import 'package:ecommerce_app/controller/cart_controller.dart';
import 'package:ecommerce_app/controller/dashboard_controller.dart';
import 'package:ecommerce_app/pages/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../route/app_routes.dart';
import '../utils/dimensions.dart';

class CartPage extends GetView<CartController> {
  final int pageId;

  CartPage({Key? key, this.pageId = 0}) : super(key: key);

  final DashBoardController dashBoardController = Get.find<DashBoardController>();

  @override
  Widget build(BuildContext context) {

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        dashBoardController.changeIndex(0);
        // Get.offAndToNamed(AppRoutes.getDetailPage(pageId));
        Get.back(result: true);
        return false; // return false to prevent default pop behavior
      },
      child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                dashBoardController.changeIndex(0);
                Get.back(result: true);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            // automaticallyImplyLeading: false,
            backgroundColor: AppColor.secondaryColor,
            centerTitle: true,
            title: Text(
              'Shopping Cart',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          body: GetBuilder<CartController>(
            builder: (cartController) {
              cartController.getTotalPrice();
              return cartController.cartData.isNotEmpty
                  ? Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          bottom: Dimensions.height45 * 2,
                          child: ListView.builder(
                            itemCount: cartController.cartData.length,
                            itemBuilder: (context, index) {
                              // Extract shoeData map for current item
                              Map<dynamic, dynamic> shoeData =
                                  cartController.cartData[index]["shoeData"];
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: Get.context!.width * 0.9,
                                    margin:
                                        EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height20),
                                    padding: EdgeInsets.all(Dimensions.height15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromARGB(255, 210, 210, 210),
                                          blurRadius: 10,
                                          offset: Offset(4, 4),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius15),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.offNamedUntil(AppRoutes.getDetailPage(cartController.cartData[index]["pageId"]),
                                                 (route) {
                                                  
                                                  if(route.settings.name == AppRoutes.getDetailPage(cartController.cartData[index]["pageId"])){
                                                    print('Route name : ${route.settings.name}');
                                                    return false;
                                                  }
                                                  print("false");
                                                  return true;
                                                 }
                                                );
                                                // Get.offNamed(AppRoutes.getDetailPage(cartController.cartData[index]["pageId"]));
                                                print("Go to Page Id ${cartController.cartData[index]["pageId"]}");
                                                print("Image on this page id ${cartController.cartData[index]["image"]}");
                                                // Get.back();
                                              },
                                              child: Container(
                                                width: Get.context!.width * 0.25,
                                                height: Get.context!.width * 0.25,
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                        cartController.cartData[index]['image']),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius15),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromARGB(
                                                          255, 210, 210, 210),
                                                      blurRadius: 10,
                                                      offset: Offset(4, 4),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.height10),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      cartController.cartData[index]
                                                          ["name"],
                                                      style: TextStyle(
                                                        fontSize: Dimensions.font14,
                                                        fontWeight: FontWeight.w500,
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions.height5,
                                                  ),
                                                  Text(
                                                    cartController.cartData[index]
                                                        ["brand"],
                                                    style: TextStyle(
                                                      fontSize: Dimensions.font14,
                                                      color: Colors.black38,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions.height5,
                                                  ),
                                                  Text(
                                                    'Rs. ${cartController.cartData[index]["price"]}',
                                                    style: TextStyle(
                                                      fontSize: Dimensions.font14,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions.height20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: Dimensions.width10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                cartController.removeCart(
                                                    cartController.cartData[index]);
                                                print("Remove cartData");
                                                print(
                                                    cartController.cartData.length);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(
                                                    Dimensions.height5),
                                                decoration: BoxDecoration(
                                                  color: AppColor.secondaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromARGB(
                                                          255, 210, 210, 210),
                                                      blurRadius: 4,
                                                      offset: Offset(2, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.delete_outline_outlined,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Dimensions.height20,
                                        ),
                                        Table(
                                          border: TableBorder(
                                              // horizontalInside: BorderSide(
                                              //   // color: AppColor.textColor1
                                              // )
                                              ),
                                          children: [
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Center(
                                                    child: Text(
                                                      "Size",
                                                      style: TextStyle(
                                                        color: AppColor.textColor1,
                                                        fontSize: Dimensions.font14,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Center(
                                                    child: Text(
                                                      "Qty (dozens)",
                                                      style: TextStyle(
                                                        color: AppColor.textColor1,
                                                        fontSize: Dimensions.font14,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Center(
                                                    child: Text(
                                                      "Price",
                                                      style: TextStyle(
                                                        color: AppColor.textColor1,
                                                        fontSize: Dimensions.font14,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ...shoeData.keys.map((size) {
                                              print("Sizes : ${cartController.cartData[index]["shoeData"][size]}");
                                              // Convert size to string if necessary
                                              String sizeString = size.toString();
                                              return TableRow(
                                                decoration: BoxDecoration(
                                                    color: AppColor.white),
                                                children: [
                                                  TableCell(
                                                    // verticalAlignment: TableCellVerticalAlignment.top,
                                                    child: Center(
                                                      child: Text(
                                                        sizeString,
                                                        style: TextStyle(
                                                          color:
                                                              AppColor.textColor1,
                                                          fontSize:
                                                              Dimensions.font14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  TableCell(
                                                    child: Center(
                                                      child: Text(
                                                        "${shoeData[size]}",
                                                        style: TextStyle(
                                                          color:
                                                              AppColor.textColor1,
                                                          fontSize:
                                                              Dimensions.font14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  TableCell(
                                                    child: Center(
                                                      child: Text(
                                                        "${(12 * cartController.cartData[index]["shoeData"][size]) * int.parse(cartController.cartData[index]["price"])}",
                                                        style: TextStyle(
                                                          color:
                                                              AppColor.textColor1,
                                                          fontSize:
                                                              Dimensions.font14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }).toList(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
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
                                RichText(
                                  text: TextSpan(
                                    text: 'Subtotal : ',
                                    style: TextStyle(
                                      color: Colors.black
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Rs ${cartController.formatAmountWithCommas(cartController.totalPrice)}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                        )
                                      )
                                    ]
                                  )
                                ),
                                InkWell(
                                  onTap: () {
                                    // Get.to(()=>CheckoutPage());
                                  },
                                  child: Container(
                                    height: Dimensions.height30 * 2,
                                    width: Dimensions.height30 * 6,
                                    decoration: BoxDecoration(
                                      color: AppColor.secondaryColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius12),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Checkout",
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
                                          Icons.shopping_cart_checkout_outlined,
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
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 400,
                          width: 500,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/shoe_logo.png'))),
                        ),
                        Text(
                          "Cart is empty",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: Dimensions.font26,
                              fontFamily: 'Balsamiq Sans'),
                        )
                      ],
                    );
            },
          )),
    );
  }



}
