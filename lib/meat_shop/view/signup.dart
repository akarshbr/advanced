import 'package:advanced/meat_shop/view/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpMeatShop extends StatefulWidget {
  const SignUpMeatShop({super.key});

  @override
  State<SignUpMeatShop> createState() => _SignUpMeatShopState();
}

class _SignUpMeatShopState extends State<SignUpMeatShop> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late SharedPreferences sharedPreferences;
  bool visibility = true;
  String? passwordCheck;
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "SIGN UP",
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
                controller: fullNameController,
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
                    hintText: "Full Name",
                    hintStyle: TextStyle(color: Colors.black45)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
              child: TextFormField(
                validator: (enteredEmail) {
                  if (enteredEmail!.isEmpty || !enteredEmail.contains("@")) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Enter Proper Email Idiot!!"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else {
                    return null;
                  }
                },
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
                controller: passwordController,
                obscureText: visibility,
                obscuringCharacter: "*",
                validator: (enteredPassword) {
                  passwordCheck = enteredPassword;
                  if (enteredPassword!.isEmpty || enteredPassword.length < 6) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Password should not be empty/less than 6 character!"),
                      backgroundColor: Colors.redAccent,
                    ));
                  }
                },
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
                      ),
                    ),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 10),
              child: TextFormField(
                obscureText: visibility,
                obscuringCharacter: "*",
                validator: (confirmPassword) {
                  if (confirmPassword != passwordCheck) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Password Mismatch Dumbass"),
                      backgroundColor: Colors.redAccent,
                    ));
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.black45,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "confirm password",
                    hintStyle: TextStyle(color: Colors.black45)),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  storeDetails();
                },
                child: Text("SignUP")),
          ],
        ),
      ),
    );
  }

  void storeDetails() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String fullName = fullNameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    if (fullName != "" && email != "" && password != "") {
      sharedPreferences.setString("fullName", fullName);
      sharedPreferences.setString("email", email);
      sharedPreferences.setString("password", password);
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginMeatShop()));
    }
    fullNameController.text = "";
    emailController.text = "";
    passwordController.text = "";
  }

  void showTheSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: Colors.redAccent,
    ));
  }
}
