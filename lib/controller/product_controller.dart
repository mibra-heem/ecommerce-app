import 'dart:convert';

import 'package:ecommerce_app/repository/products_repo.dart';
import 'package:get/get.dart';

import '../models/products.dart';

class ProductController extends GetxController{

  ProductRepo productRepo;

  late Products products;

  List<Products> _productList = [];

  List<Products> get productList => _productList;


  ProductController({required this.productRepo});

  Future getProducts()async{

    Response response = await productRepo.getProducts();

    print("Response Body : ${response.body}");
      print(response.statusCode);

    try{
      print(response.statusCode);
      if(response.statusCode == 200){

        Map<String, dynamic> data = response.body;

        data['product'].forEach((value){
          _productList.add(Products.fromJson(value));
        });
        // print(_productList[1].pdescr);

      }

      print("here");
    }catch(e){
      print(e.toString());
    }

  }

}