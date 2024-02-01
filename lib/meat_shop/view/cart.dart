import 'package:advanced/meat_shop/provider/product_provider.dart';
import 'package:advanced/meat_shop/view/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class CartMeatShop extends StatefulWidget {
  @override
  State<CartMeatShop> createState() => _CartMeatShopState();
}

class _CartMeatShopState extends State<CartMeatShop> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    final cartItems = context.watch<ProductProvider>().cart;
    num total = 0;
    for (var item in cartItems) {
      total = total + (item.price * item.count);
    }
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
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
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(cartItems[index].image), fit: BoxFit.contain)),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  cartItems[index].name,
                                  maxLines: 1,
                                )),
                            Text("${cartItems[index].price}₹/ Kg")
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 78, right: 5),
                        child: Wrap(
                          children: [
                            IconButton(
                                onPressed: () {
                                  context.read<ProductProvider>().addToList(cartItems[index]);
                                },
                                icon: FaIcon(CupertinoIcons.add)),
                            Column(
                              children: [
                                Text(
                                  "${cartItems[index].count} Kg",
                                  style: TextStyle(fontSize: 18),
                                ),
                                FaIcon(
                                  CupertinoIcons.cart,
                                  size: 40,
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  context.read<ProductProvider>().removeFromList(cartItems[index]);
                                },
                                icon: FaIcon(CupertinoIcons.minus))
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox();
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: total > 0 ? Text("Pay Now $total") : Text("Pay Now"),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: index,
        selectedItemColor: Colors.purple,
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(
                CupertinoIcons.home,
                color: Colors.white,
              ),
              label: "",
              backgroundColor: Colors.black12),
          BottomNavigationBarItem(
              icon: FaIcon(CupertinoIcons.cart, color: Colors.white),
              label: "",
              backgroundColor: Colors.black12),
          BottomNavigationBarItem(
              icon: FaIcon(CupertinoIcons.profile_circled, color: Colors.white),
              label: "",
              backgroundColor: Colors.black12)
        ],
        onTap: (tapIndex) {
          setState(() {
            index = tapIndex;
            if (index == 0) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeMeatShop()));
            } else if (index == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartMeatShop()));
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileMeatShop()));
            }
          });
        },
      ),
    );
  }
}
