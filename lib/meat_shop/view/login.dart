import 'package:advanced/meat_shop/view/home.dart';
import 'package:advanced/meat_shop/view/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/product_provider.dart';

void main() {
  runApp(ChangeNotifierProvider<ProductProvider>(
    create: (context) => ProductProvider(),
    child: MaterialApp(
      home: LoginMeatShop(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class LoginMeatShop extends StatefulWidget {
  const LoginMeatShop({super.key});

  @override
  State<LoginMeatShop> createState() => _LoginMeatShopState();
}

class _LoginMeatShopState extends State<LoginMeatShop> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late SharedPreferences sharedPreferences;
  late bool checkLogged;
  bool visibility = true;

  @override
  void initState() {
    checkUserLogged();
    super.initState();
  }

  void checkUserLogged() async {
    sharedPreferences = await SharedPreferences.getInstance();
    checkLogged = sharedPreferences.getBool("status") ?? false;
    if (checkLogged == true) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeMeatShop()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "LOG IN",
            style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/logo/meat_shop.png"), fit: BoxFit.cover)),
          ),
          Text(
            "meat me to it!",
            style: TextStyle(color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.black45,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "email",
                  hintStyle: TextStyle(color: Colors.black45)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextFormField(
              obscureText: visibility,
              obscuringCharacter: "*",
              controller: passwordController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.password,
                    color: Colors.black45,
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (visibility == true) {
                            visibility = false;
                          } else {
                            visibility = true;
                          }
                        });
                      },
                      icon: Icon(
                        visibility == true ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black45,
                      )),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "password",
                  hintStyle: TextStyle(color: Colors.black45)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                validateLogIn();
              },
              child: Text("LogIN")),
          SizedBox(
            height: 10,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                "Dont have an Account,",
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => SignUpMeatShop()));
                  },
                  child: Text(
                    "Sign UP",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )
        ],
      ),
    );
  }

  void validateLogIn() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String email = emailController.text;
    String password = passwordController.text;
    String? uEmail = sharedPreferences.getString("email") ?? "";
    String? uPassword = sharedPreferences.getString("password") ?? "";
    if (email == uEmail && password == uPassword) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeMeatShop()));
      sharedPreferences.setBool("status", true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Incorect Email or Password stupid"),
        backgroundColor: Colors.redAccent,
      ));
    }
  }
}
