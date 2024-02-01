import 'package:advanced/api/api_http&getx/controller/product_controller.dart';
import 'package:advanced/api/api_http&getx/view/widget/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    home: ApiHome(),
  ));
}

class ApiHome extends StatelessWidget {
  const ApiHome({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("API http GetX"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        centerTitle: true,
      ),
      body: SizedBox(
        child: Obx(() {
          if (productController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return GridView.builder(
                itemCount: productController.productList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {}, child: ProductTile(productController.productList[index]));
                });
          }
        }),
      ),
    );
  }
}
