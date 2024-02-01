class Product {
  final String name;
  final String image;
  final double price;
  int count;

  Product({required this.name, required this.image, required this.price, this.count = 0});
}
