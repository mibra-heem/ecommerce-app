import 'package:get/get.dart';

class DetailController extends GetxController {
  Map<int, Map<int, double>> pageData = {};

  Map<int, List<int>> shoeSize = {};
  bool isFavourite = false;

  void setSize(int pageId, int size) {
  if (!shoeSize.containsKey(pageId)) {
    shoeSize[pageId] = [];
  }
  if (!shoeSize[pageId]!.contains(size)) {
    shoeSize[pageId]!.add(size);
    pageData[pageId] = pageData[pageId] ?? {};
    pageData[pageId]![size] = 0.0;
    print("Page Data Map : $pageData");
  } else {
    shoeSize[pageId]!.remove(size);
    pageData[pageId]?.remove(size);
    print("Page Data Map : $pageData");
  }
  update();
}

  void setFavourite() {
    isFavourite = !isFavourite;
    update();
  }

  void increment(int size, int pageId) {
    if (pageData[pageId] != null) {
      pageData[pageId]![size] = (pageData[pageId]![size] ?? 0) + 0.5;
      print("Incremented : $pageData");
      update();
    }
  }

  void decrement(int size, int pageId) {
    if (pageData[pageId] != null) {
      if ((pageData[pageId]![size] ?? 0) > 0) {
        pageData[pageId]![size] = (pageData[pageId]![size] ?? 0) - 0.5;
        print("Decremented : $pageData");
        update();
      }
    }
  }
}
