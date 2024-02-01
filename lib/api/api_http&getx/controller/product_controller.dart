import 'package:advanced/api/api_http&getx/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxBool isLoading = true.obs;
  var productList = [].obs;

  @override
  void onInit() {
    loadProductData(); //to fetch data from service class
    super.onInit();
  }

  void loadProductData() async {
    try {
      isLoading(true);
      var products = await HttpService.fetchProduct();
      if (products != null) {
        productList.value = products;
      }
    } catch (e) {
      Get.snackbar("Error", "$e",backgroundColor: Colors.redAccent);
    } finally {
      isLoading(false);
    }
  }
}
