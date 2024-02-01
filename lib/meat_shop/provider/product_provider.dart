import 'package:flutter/cupertino.dart';
import '../model/product.dart';

List<Product> fishList = [
  Product(name: "Pomfret/ആവോലി", image: "assets/product/avoli.png", price: 700),
  Product(name: "KingvFish/നെയ്മീൻ/ഐക്കൂര", image: "assets/product/ayakoora.png", price: 850),
  Product(name: "Mackerel/അയല", image: "assets/product/ayla.png", price: 300),
  Product(name: "Prawns/ചെമ്മീൻ", image: "assets/product/chemmeen.png", price: 500),
  Product(name: "Crab/ഞണ്ട്", image: "assets/product/crab.png", price: 550),
  Product(name: "Mussel/കല്ലുമ്മക്കായ", image: "assets/product/kallumakaya.png", price: 400),
  Product(name: "Pearl Spot/കരിമീൻ", image: "assets/product/karimeen.png", price: 609),
  Product(name: "Squid/കൂന്തൽ", image: "assets/product/koonthal.png", price: 280),
  Product(name: "Pink Perch/കിളിമീൻ", image: "assets/product/kuyyapla_kilimeen.png", price: 350),
  Product(name: "Sardine/മത്തി", image: "assets/product/mathi.png", price: 200),
  Product(name: "Anchovy/നത്തോലി", image: "assets/product/netholi.png", price: 250),
  Product(name: "Shark,സ്രാവ്", image: "assets/product/sraavu.png", price: 720)
];

List<Product> meatList = [
  Product(name: "Beef/പോത്ത് ഇറച്ചി", image: "assets/product/beef.png", price: 250),
  Product(name: "Chicken", image: "assets/product/chicken.png", price: 210),
  Product(name: "Mutton/മട്ടൺ", image: "assets/product/muttton.png", price: 450)
];

class ProductProvider extends ChangeNotifier {
  int tprice = 0;
  int total = 0;

  final List<Product> _fish = fishList;

  List<Product> get fish => _fish;

  final List<Product> _meat = meatList;

  List<Product> get meat => _meat;

  final List<Product> _cart = [];

  List<Product> get cart => _cart;

  void addToList(Product productFromCart) {
    if (productFromCart.count != 0) {
      productFromCart.count += 1;
      notifyListeners();
    } else {
      _cart.add(productFromCart);
      productFromCart.count += 1;
      notifyListeners();
    }
  }

  void removeFromList(Product removeProduct) {
    if (removeProduct.count > 1) {
      removeProduct.count -= 1;
      notifyListeners();
    } else {
      _cart.remove(removeProduct);
      notifyListeners();
    }
  }
}
