import 'package:advanced/meat_shop/view/fish.dart';
import 'package:advanced/meat_shop/view/meat.dart';
import 'package:advanced/meat_shop/view/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/product_provider.dart';
import 'cart.dart';

class HomeMeatShop extends StatefulWidget {
  @override
  State<HomeMeatShop> createState() => _HomeMeatShop();
}

class _HomeMeatShop extends State<HomeMeatShop> {
  var mImage = ["assets/product/seafood.jpg", "assets/product/meat.jpg"];
  var mName = ["Fish", "Meat"];
  var pages = [FishMeatShop(), MeatMeatShop()];

  int index = 0;
  late String fullName;
  late String email;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      email = sharedPreferences.getString("email")!;
      fullName = sharedPreferences.getString("fullName")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        title: Text(
          "Meat Shop",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(mName.length, (index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => pages[index]));
            },
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Card(
                margin: EdgeInsets.all(10),
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image:
                              DecorationImage(image: AssetImage(mImage[index]), scale: 2),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        mName[index],
                        style: TextStyle(
                            color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
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
