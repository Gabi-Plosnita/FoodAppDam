import 'package:food_app/models/food.dart';

class CartItem {
  Food food;
  List<Addon> selectedAddons;
  int quantity;

  CartItem({
    required this.food,
    required this.selectedAddons,
    this.quantity = 1,
  });

  double get totalPrice {
    double total = food.price;
    for (Addon addon in selectedAddons) {
      total += addon.price;
    }
    return total * quantity;
  }
}