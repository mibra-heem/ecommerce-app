import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/controller/product_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late PageController _pageController;
  ProductController productController;
  double _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  var bannerData = [].obs;
  var popularData = [].obs;
  var exploreData = [].obs;

  double get currPageValue => _currPageValue;

  HomeController({required this.productController});

  @override
  void onInit() {
    super.onInit();
    // fetchBannerData();
    // fetchPopularData();
    // fetchExploreData();
    _pageController = PageController(viewportFraction: 0.92);
    _pageController.addListener(() {
      _currPageValue = _pageController.page ?? 0.0;
      update();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer.periodic(Duration(seconds: 4), (Timer timer) {
        if (_pageController.hasClients) {
          int nextPage = _pageController.page!.round() + 1;
          if (nextPage >= popularData.length) { // Replace 6 with the actual total number of pages in your PageView
            nextPage = 0;
          }
          _pageController.animateToPage(
            nextPage,
            duration: Duration(milliseconds: 500),
            curve: Curves.linear,
          );
        }
      });
    });
  }

  PageController get pageController => _pageController;

  @override
  void onClose() {
    _pageController.dispose();
    super.onClose();
  }


  void fetchBannerData() async {
    var snapshot = await fireStore.collection('products').get();
    bannerData.value = snapshot.docs.map((doc) => doc.data()).toList();
  }

  void fetchPopularData() async {
    var snapshot = await fireStore.collection('products').get();
    popularData.value = snapshot.docs.map((doc) => doc.data()).toList();
  }

  void fetchExploreData() async {
    var snapshot = await fireStore.collection('products').get();
    exploreData.value = snapshot.docs.map((doc) => doc.data()).toList();
  }

  Matrix4 transformPageView(int index, double height) {
    Matrix4 matrix = Matrix4.identity();
    if (index == currPageValue.floor()) {
      var currScale = 1 - (currPageValue - index) * (1 - _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currPageValue.floor() + 1) {
      var currScale = _scaleFactor + (currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currPageValue.floor() - 1) {
      var currScale = 1 - (currPageValue - index) * (1 - _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = _scaleFactor;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, height * (1 - _scaleFactor) / 2, 1);
    }
    return matrix;
  }
}

