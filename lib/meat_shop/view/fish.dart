import 'package:advanced/meat_shop/provider/product_provider.dart';
import 'package:advanced/meat_shop/view/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FishMeatShop extends StatefulWidget {
  const FishMeatShop({super.key});

  @override
  State<FishMeatShop> createState() => _FishMeatShopState();
}

class _FishMeatShopState extends State<FishMeatShop> {
  @override
  Widget build(BuildContext context) {
    var fishes = context.watch<ProductProvider>().fish;
    final cartItems = context.watch<ProductProvider>().cart;
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: FaIcon(
              CupertinoIcons.back,
              color: Colors.white,
            )),
        title: Text(
          "Meat Shop",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CartMeatShop()));
              },
              icon: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Text("${cartItems.length}",style: TextStyle(color: Colors.red,fontSize: 11),),
                  ),
                  FaIcon(
                    CupertinoIcons.cart,
                    color: Colors.white,
                  ),
                ],
              ))
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(fishList.length, (index) {
          final currentProduct = fishes[index];
          return InkWell(
            onTap: () {},
            child: Card(
              child: Column(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(currentProduct.image), fit: BoxFit.contain)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  currentProduct.name,
                                  maxLines: 1,
                                ),
                              ),
                              Text("${currentProduct.price} ₹/ Kg")
                            ],
                          ),
                        ),
                      ),
                      IconButton(onPressed: () {
                        context.read<ProductProvider>().addToList(currentProduct);
                      }, icon: FaIcon(CupertinoIcons.cart))
                    ],
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
