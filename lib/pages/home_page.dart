import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/controller/home_controller.dart';
import 'package:ecommerce_app/route/app_routes.dart';
import 'package:ecommerce_app/utils/app_constants.dart';
import 'package:ecommerce_app/widgets/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../utils/dimensions.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final double height = Dimensions.pageViewContainer;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.fetchBannerData();
        controller.fetchPopularData();
        controller.fetchExploreData();
      },
      child: WillPopScope(
        onWillPop: () async {
          bool shouldPop = await showDialog(
            context: context,
            builder: (context) {
              return DialogBox(
                title: 'Exit App',
                message: 'Are you sure? you want to exit the app.',
                onCancel: () => Navigator.of(context).pop(false),
                onConfirm: () => Navigator.of(context).pop(true),
              );
            },
          );
          return shouldPop;
        },
        child: Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
              backgroundColor: Colors.white,
              child: ListView(
                children: [
                  DrawerHeader(
                    padding: EdgeInsets.zero,
                    child: UserAccountsDrawerHeader(
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 255, 254, 206),
                                  Color.fromARGB(255, 218, 209, 115),
                                ]),
                            image: DecorationImage(
                              image: AssetImage("assets/images/shoe_logo.png"),
                              fit: BoxFit.cover,
                            )),
                        accountName: Text(''),
                        accountEmail: Text(''),
                        currentAccountPicture: Image(
                            image: AssetImage(
                                "assets/images/man_travel_profile.webp"))),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: InkWell(onTap: () {}, child: Text('Logout')),
                  )
                ],
              )),
          body: Padding(
            padding: EdgeInsets.only(top: 50.h, left: 15.h, right: 15.h),
            child: SizedBox(
              height: Get.context!.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.sp),
                        border:
                            Border.all(color: AppColor.textColor1, width: 1.w),
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(255, 210, 210, 210),
                              blurRadius: 10.sp,
                              offset: Offset(4.w, 4.h))
                        ]),
                    padding: EdgeInsets.only(right: 16.w, left: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  scaffoldKey.currentState!.openDrawer();
                                },
                                child: Icon(
                                  Icons.menu_outlined,
                                  size: 26.sp,
                                  color: AppColor.textColor1,
                                )),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "Menu",
                              style: TextStyle(
                                  color: AppColor.textColor1, fontSize: 18.sp),
                            ),
                          ],
                        ),
                        Container(
                          height: 50.h,
                          width: 50.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/man_travel_profile.webp"),
                                fit: BoxFit.cover,
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GetBuilder<HomeController>(builder: (homeController) {
                            return Container(
                              height: 200.h,
                              child: PageView.builder(
                                  controller: homeController.pageController,
                                  itemCount: homeController.bannerData.length,
                                  itemBuilder: (context, position) {
                                    return Transform(
                                        transform:
                                            homeController.transformPageView(
                                                position, height),
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 5.w, right: 5.w),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.h),
                                              color: AppColor.secondaryColor,
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      homeController.bannerData[
                                                          position]["image"]))),
                                        ));
                                  }),
                            );
                          }),
                          SizedBox(
                            height: 30.h,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: GetBuilder<HomeController>(
                              builder: (homeController) {
                                return homeController.bannerData.isNotEmpty
                                    ? DotsIndicator(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        dotsCount:
                                            homeController.bannerData.length,
                                        position: homeController
                                            .currPageValue
                                            .round(),
                                        decorator: DotsDecorator(
                                          activeColor: AppColor.secondaryColor,
                                          size: Size.square(10.sp),
                                          activeSize: Size(25.0.w, 10.0.h),
                                          activeShape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.sp)),
                                        ),
                                      )
                                    : Container(); // Display an empty container when there are no banners
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            "Popular",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Container(
                            height: 300.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.productController.productList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 240.h,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        GestureDetector(
                                          onTap: () => Get.toNamed(
                                              AppRoutes.getDetailPage(index)),
                                          child: Container(
                                            height: 180.h,
                                            margin:
                                                EdgeInsets.only(right: 15.h),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20),
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  "${AppConstants.BASE_URL}${controller.productController.productList[index].pimage!}",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 5.w,
                                          left: 5.w,
                                          bottom: 20.h,
                                          child: Container(
                                            height: 120.h,
                                            margin: EdgeInsets.only(
                                              right: 15.h,
                                            ),
                                            padding: EdgeInsets.only(
                                                top: 10.h,
                                                right: 10.w,
                                                left: 10.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 210, 210, 210),
                                                  blurRadius: 10,
                                                  offset: Offset(3, 3),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 120.w,
                                                        child: Text(
                                                          controller.productController.productList[index].pname!,
                                                          style: TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              color: AppColor
                                                                  .textColor1,
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Text(
                                                        "Wearium",
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .textColor2,
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Wrap(
                                                        children: List.generate(
                                                          5,
                                                          (index) => Icon(
                                                            index < 3
                                                                ? Icons.star
                                                                : Icons
                                                                    .star_border_sharp,
                                                            color: index < 3
                                                                ? AppColor
                                                                    .secondaryColor
                                                                : AppColor
                                                                    .textColor2,
                                                            size: Dimensions
                                                                .iconSize16,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 100.w,
                                                  child: Text(
                                                    textAlign: TextAlign.right,
                                                    'Rs ${controller.productController.productList[index].price!}',
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color:
                                                            AppColor.textColor1,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            "Explore",
                            style: TextStyle(
                                color: AppColor.textColor1,
                                fontSize: Dimensions.font24 * 1.1,
                                fontWeight: FontWeight.w500),
                          ),
                          MasonryGridView.builder(
                              crossAxisSpacing: 10.w,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemCount: controller.exploreData.length,
                              itemBuilder: (context, index) => Container(
                                    height: 300.h,
                                    width: 240.h,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        GestureDetector(
                                          onTap: () => Get.toNamed(
                                              AppRoutes.getDetailPage(index)),
                                          child: Container(
                                            height: 180.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20),
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  controller.popularData[index]
                                                      ["image"],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 5.w,
                                          left: 5.w,
                                          bottom: 25.h,
                                          child: Container(
                                            height: 120.h,
                                            padding: EdgeInsets.only(
                                                top: 10.h,
                                                right: 10.w,
                                                left: 10.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 210, 210, 210),
                                                  blurRadius: 10,
                                                  offset: Offset(3, 3),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 120.w,
                                                  child: Text(
                                                    controller
                                                            .popularData[index]
                                                        ["name"],
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color:
                                                            AppColor.textColor1,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                SizedBox(
                                                  width: 120.w,
                                                  child: Text(
                                                    'Rs ${controller.popularData[index]["price"]}',
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color:
                                                            AppColor.textColor1,
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                  controller.popularData[index]
                                                      ["brand"],
                                                  style: TextStyle(
                                                      color:
                                                          AppColor.textColor2,
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Wrap(
                                                  children: List.generate(
                                                    5,
                                                    (index) => Icon(
                                                        index < 3
                                                            ? Icons.star
                                                            : Icons
                                                                .star_border_sharp,
                                                        color: index < 3
                                                            ? AppColor
                                                                .secondaryColor
                                                            : AppColor
                                                                .textColor2,
                                                        size: 14.sp),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
