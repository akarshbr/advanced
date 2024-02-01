import 'package:advanced/meat_shop/view/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart.dart';
import 'home.dart';

class ProfileMeatShop extends StatefulWidget {
  const ProfileMeatShop({super.key});

  @override
  State<ProfileMeatShop> createState() => _ProfileMeatShopState();
}

class _ProfileMeatShopState extends State<ProfileMeatShop> {
  late SharedPreferences sharedPreferences;
  String? uName;
  String? uEmail;
  int index = 2;
  bool visibility = true;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      uName = sharedPreferences.getString("fullName");
      uEmail = sharedPreferences.getString("email");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Profile"),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Icon(
                CupertinoIcons.person_crop_circle_fill,
                size: 200,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "$uName",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "$uEmail",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                  onPressed: () async {
                    sharedPreferences = await SharedPreferences.getInstance();
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => LoginMeatShop()));
                    sharedPreferences.setBool("status", false);
                  },
                  child: Text("LogOut")),
            )
          ],
        ),
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
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomeMeatShop()));
            } else if (index == 1) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => CartMeatShop()));
            } else {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => ProfileMeatShop()));
            }
          });
        },
      ),
    );
  }
}
