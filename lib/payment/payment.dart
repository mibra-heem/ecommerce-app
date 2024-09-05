import 'package:ecommerce_app/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../pages/dashboard_page.dart';
import '../pages/detail_page.dart';
import '../utils/dimensions.dart';

class CartPage extends StatelessWidget {
  int pageId;
  int size;
  CartPage({super.key, this.pageId = 0, this.size = 0});

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print(pageId.toString() + "from cartData page");
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.secondaryColor,
          centerTitle: true,
          title: Text(
            'Shopping Cart',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: GetBuilder<CartController>(
          builder: ((cartController) {
            return cartController.cartData.length != 0
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: Get.context!.width * 0.9,
                      child: ListView.builder(
                        
                        itemCount: cartController.cartData.length,
                        itemBuilder: (context, index) {

                          print(cartController.cartData[index]["shoeData"].length);
                          return Container(
                            width: 100,
                            margin: EdgeInsets.only(top: Dimensions.height45),
                            padding: EdgeInsets.all(Dimensions.height15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              
                              boxShadow: [
                                BoxShadow(
                                    color: const Color.fromARGB(
                                        255, 210, 210, 210),
                                    blurRadius: 10,
                                    offset: Offset(4, 4))
                              ],
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius15),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.back();
                                        Get.off(() => DetailPage(
                                            pageId: cartController
                                                .cartData[index]["pageId"]));
                                      },
                                      child: Container(
                                        width: Get.context!.width * 0.25,
                                        height: Get.context!.width * 0.25,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'assets/images/${cartController.cartData[index]['image']}')),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius15),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: const Color.fromARGB(
                                                      255, 210, 210, 210),
                                                  blurRadius: 10,
                                                  offset: Offset(4, 4))
                                            ]),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimensions.height10,
                                    ),
                                    Container(
                                      width: Get.context!.width * 0.5481,
                            
                                      // color: Colors.amberAccent,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: Dimensions.width45 * 4,
                                                child: Text(
                                                  cartController
                                                      .cartData[index]["name"],
                                                  style: TextStyle(
                                                      fontSize:
                                                          Dimensions.font14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              ),
                                              Text(
                                                  cartController
                                                      .cartData[index]["brand"],
                                                  style: TextStyle(
                                                      fontSize:
                                                          Dimensions.font14,
                                                      color: Colors.black38,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Text(
                                                  'Rs. ${cartController.cartData[index]["price"]}',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Dimensions.font14,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              SizedBox(
                                                height: Dimensions.height10,
                                              ),
                                              SizedBox(
                                                height: Dimensions.height45 * 3,
                                                child: ListView.builder(
                                                  itemCount: cartController.cartData[index]["shoeData"].length,
                                                  itemBuilder: (context, i){
                                                  return Container(
                                                  height: Dimensions.height20,
                                                  width: Dimensions.width20,
                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      // shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: Colors.black),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                      .radius10 *
                                                                  0.5)),
                                                  child: Center(
                                                    child: Text(
                                                      "${cartController.cartData[index]["shoeData"][i]}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              Dimensions.font14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                );
                                                }),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  cartController
                                                      .removeCart(
                                                          cartController
                                                              .cartData[index]);
                                                  print("Remove cartData");
                                                  print(cartController
                                                      .cartData.length);
                                                },
                                                child: Container(
                                                    padding: EdgeInsets.all(
                                                        Dimensions.height5),
                                                    decoration: BoxDecoration(
                                                        color: AppColor
                                                            .secondaryColor,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  210,
                                                                  210,
                                                                  210),
                                                              // spreadRadius:10,
                                                              blurRadius: 4,
                                                              offset:
                                                                  Offset(2, 2))
                                                        ]),
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                    ))),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return AlertDialog(
                                              backgroundColor: Colors.white,
                                              surfaceTintColor: Colors.white,
                                              title: Text(
                                                cartController.cartData[index]
                                                    ["name"],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    // fontFamily: 'Balsamiq Sans',
                                                    color: AppColor.textColor1,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        Dimensions.font16 *
                                                            1.2),
                                              ),
                                              // icon: Icon(Icons.person_2),
                                              content: Container(
                                                margin: EdgeInsets.only(
                                                    top: Dimensions.height15),
                                                height:
                                                    Dimensions.height30 * 11,
                                                width: Dimensions.height45 * 10,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: Dimensions
                                                                  .height30 *
                                                              3.5,
                                                          width: Dimensions
                                                                  .height30 *
                                                              3.5,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      Dimensions
                                                                          .radius12),
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/images/${cartController.cartData[index]['image']}'),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        ),
                                                        SizedBox(
                                                          width: Dimensions
                                                              .width10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                'Rs. ${cartController.cartData[index]["price"]}',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        Dimensions
                                                                            .font14)),
                                                            SizedBox(
                                                              height: Dimensions
                                                                  .height5,
                                                            ),
                                                            Text(
                                                                cartController
                                                                            .cartData[
                                                                        index]
                                                                    ["brand"],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black38,
                                                                    fontSize:
                                                                        Dimensions
                                                                            .font14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                            SizedBox(
                                                              height: Dimensions
                                                                  .height5,
                                                            ),
                                                            Wrap(
                                                              children:
                                                                  List.generate(
                                                                      5,
                                                                      (index) =>
                                                                          Icon(
                                                                            index < 3
                                                                                ? Icons.star
                                                                                : Icons.star_border_sharp,
                                                                            color: index < 3
                                                                                ? AppColor.secondaryColor
                                                                                : AppColor.textColor2,
                                                                            size:
                                                                                Dimensions.iconSize16,
                                                                          )),
                                                            ),
                                                            SizedBox(
                                                              height: Dimensions
                                                                  .height5,
                                                            ),
                                                            Container(
                                                              height: Dimensions
                                                                  .height20,
                                                              width: Dimensions
                                                                  .width20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .black,
                                                                      // shape: BoxShape.circle,
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .black),
                                                                      borderRadius:
                                                                          BorderRadius.circular(Dimensions.radius10 *
                                                                              0.5)),
                                                              child: Center(
                                                                child: Text(
                                                                  "${cartController.cartData[index]["size"]}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          Dimensions
                                                                              .font14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Dimensions.height20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Size',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Dimensions
                                                                      .font14),
                                                        ),
                                                        Text(
                                                          '${cartController.cartData[index]["size"]}',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Dimensions
                                                                      .font14),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Dimensions.height5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Total price ',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Dimensions
                                                                      .font14,
                                                              color: AppColor
                                                                  .textColor1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          'Rs. ${cartController.cartData[index]["price"]}',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Dimensions
                                                                      .font14,
                                                              color: AppColor
                                                                  .textColor1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Dimensions.height45,
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Get.back();
                                                          cartController
                                                              .removeCart(
                                                                  cartController
                                                                          .cartData[
                                                                      index]);
                                                          print(
                                                              cartController
                                                                  .cartData
                                                                  .length);
                            
                                                          showModalBottomSheet(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return BottomSheet(
                                                                    onClosing:
                                                                        () {},
                                                                    builder:
                                                                        (context) {
                                                                      return Container(
                                                                        height:
                                                                            350,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(Dimensions.radius30),
                                                                        ),
                                                                        child:
                                                                            Stack(
                                                                          clipBehavior:
                                                                              Clip.none,
                                                                          alignment:
                                                                              Alignment.center,
                                                                          children: [
                                                                            Positioned(
                                                                                top: Dimensions.height30 * -2.5,
                                                                                child: Image(height: Dimensions.height45 * 4, width: Dimensions.height45 * 4, image: AssetImage("assets/images/payment_done_icon.png"))),
                                                                            Positioned(
                                                                                top: Dimensions.height45 * 2.5,
                                                                                child: Text(
                                                                                  'Payment Successful',
                                                                                  style: TextStyle(color: AppColor.textColor1, fontSize: Dimensions.font26, fontWeight: FontWeight.bold),
                                                                                )),
                                                                            Positioned(
                                                                              top: Dimensions.height45 * 5,
                                                                              child: GestureDetector(
                                                                                onTap: () {
                                                                                  Get.offAll(DashBoardPage());
                                                                                },
                                                                                child: Container(
                                                                                  height: Dimensions.height30 * 1.8,
                                                                                  width: Get.context!.width * 0.9,
                                                                                  decoration: BoxDecoration(
                                                                                    color: AppColor.secondaryColor,
                                                                                    borderRadius: BorderRadius.circular(Dimensions.radius12),
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      "Back",
                                                                                      style: TextStyle(color: Colors.white, fontSize: Dimensions.font20, fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      );
                                                                    });
                                                              });
                                                        },
                                                        child: Container(
                                                          height: Dimensions
                                                                  .height30 *
                                                              1.8,
                                                          width: Get.context!
                                                                  .width *
                                                              0.9,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColor
                                                                .secondaryColor,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .radius12),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "Pay",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      Dimensions
                                                                          .font20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ));
                                        });
                                  },
                                  child: Container(
                                    height: Dimensions.height30 * 1.8,
                                    width: Get.context!.width * 0.9,
                                    decoration: BoxDecoration(
                                        color: AppColor.secondaryColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius12),
                                        boxShadow: [
                                          BoxShadow(
                                              color: const Color.fromARGB(
                                                  255, 210, 210, 210),
                                              // spreadRadius:10,
                                              blurRadius: 4,
                                              offset: Offset(2, 2))
                                        ]),
                                    child: Center(
                                      child: Text(
                                        "Proceed",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Dimensions.font20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
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
          }),
        ));
  }
}
