import 'package:advanced/meat_shop/provider/product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'cart.dart';

class MeatMeatShop extends StatefulWidget {
  const MeatMeatShop({super.key});

  @override
  State<MeatMeatShop> createState() => _MeatMeatShopState();
}

class _MeatMeatShopState extends State<MeatMeatShop> {
  @override
  Widget build(BuildContext context) {
    var meats = context.watch<ProductProvider>().meat;
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: FaIcon(CupertinoIcons.back,color: Colors.white,)),
          title: Text(
            "Meat Shop",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartMeatShop()));
                },
                icon: FaIcon(
                  CupertinoIcons.cart,
                  color: Colors.white,
                ))
          ]
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(meatList.length, (index) {
          final currentProduct = meats[index];
          return Card(
            child: Column(
              children: [
                Container(
                  height: 134,
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
                            Text(
                              currentProduct.name,
                              maxLines: 1,
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
          );
        }),
      ),
    );
  }
}
