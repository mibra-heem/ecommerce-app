
import 'package:get/get.dart';
import '../api/api_client.dart';
import '../utils/app_constants.dart';

class ProductRepo extends GetxService{
  final ApiClient apiClient;
  ProductRepo({required this.apiClient});

  Future<Response> getProducts()async{
    return await apiClient.getData(AppConstants.PRODUCTS_URL);
  }

}