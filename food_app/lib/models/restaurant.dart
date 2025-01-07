import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/cart_item.dart';
import 'package:food_app/models/food.dart';
import 'package:intl/intl.dart';

class Restaurant extends ChangeNotifier {
  final List<Food> _menu = [
    Food(
        name: "Bacon Burger",
        description:
            "Juicy beef patty topped with crispy bacon and melted cheese.",
        imagePath: "lib/images/burgers/bacon_burger.png",
        price: 10.99,
        category: FoodCategory.burger,
        availableAddons: [
          Addon(name: "Extra bacon", price: 1.49),
          Addon(name: "Avocado", price: 1.99),
          Addon(name: "Onion rings", price: 1.49),
        ]),
    Food(
        name: "Veggie Burger",
        description:
            "A healthy veggie patty with lettuce, tomato, and avocado.",
        imagePath: "lib/images/burgers/veggie_burger.png",
        price: 8.99,
        category: FoodCategory.burger,
        availableAddons: [
          Addon(name: "Extra avocado", price: 1.99),
          Addon(name: "Grilled mushrooms", price: 1.49),
          Addon(name: "Cheese", price: 0.99),
        ]),
    Food(
        name: "BBQ Burger",
        description:
            "Grilled beef patty with BBQ sauce, cheddar cheese, and fried onions.",
        imagePath: "lib/images/burgers/bbq_burger.jpg",
        price: 11.49,
        category: FoodCategory.burger,
        availableAddons: [
          Addon(name: "Extra BBQ sauce", price: 0.75),
          Addon(name: "Jalapeños", price: 1.25),
          Addon(name: "Coleslaw", price: 1.00),
        ]),
    Food(
        name: "Double Cheeseburger",
        description:
            "Two beef patties with double the cheese, lettuce, and tomato.",
        imagePath: "lib/images/burgers/cheeseburger.jpg",
        price: 12.99,
        category: FoodCategory.burger,
        availableAddons: [
          Addon(name: "Extra patty", price: 2.99),
          Addon(name: "Bacon", price: 1.99),
          Addon(name: "Pickles", price: 0.75),
        ]),
    Food(
        name: "Pepperoni Pizza",
        description:
            "Classic pizza topped with spicy pepperoni and mozzarella cheese.",
        imagePath: "lib/images/pizza/pepperoni.png",
        price: 10.49,
        category: FoodCategory.pizza,
        availableAddons: [
          Addon(name: "Extra pepperoni", price: 2.00),
          Addon(name: "Black olives", price: 1.25),
          Addon(name: "Extra cheese", price: 1.50),
        ]),
    Food(
        name: "Quattro Stagioni Pizza",
        description:
            "Four seasons pizza with mushrooms, ham, artichokes, and olives, divided into four sections.",
        imagePath: "lib/images/pizza/quattro_stagioni.jpg",
        price: 12.49,
        category: FoodCategory.pizza,
        availableAddons: [
          Addon(name: "Extra mushrooms", price: 1.50),
          Addon(name: "Extra ham", price: 1.75),
          Addon(name: "Basil leaves", price: 0.75),
        ]),
    Food(
        name: "Quattro Formaggi Pizza",
        description:
            "A blend of four cheeses: mozzarella, gorgonzola, parmesan, and ricotta.",
        imagePath: "lib/images/pizza/quattro_formaggi.jpg",
        price: 11.99,
        category: FoodCategory.pizza,
        availableAddons: [
          Addon(name: "Extra gorgonzola", price: 1.50),
          Addon(name: "Truffle oil", price: 2.00),
          Addon(name: "Fresh arugula", price: 1.25),
        ]),
    Food(
        name: "Prosciutto Pizza",
        description:
            "Pizza topped with thinly sliced prosciutto, fresh mozzarella, and arugula.",
        imagePath: "lib/images/pizza/prosciutto.jpg",
        price: 13.49,
        category: FoodCategory.pizza,
        availableAddons: [
          Addon(name: "Extra prosciutto", price: 2.50),
          Addon(name: "Parmesan flakes", price: 1.25),
          Addon(name: "Cherry tomatoes", price: 1.00),
        ]),
    Food(
        name: "Cola",
        description: "Refreshing cola drink served chilled.",
        imagePath: "lib/images/drinks/cola.jpg",
        price: 2.99,
        category: FoodCategory.drink,
        availableAddons: [
          Addon(name: "Extra ice", price: 0.50),
          Addon(name: "Lemon slice", price: 0.25),
          Addon(name: "Large size", price: 1.00),
        ]),
    Food(
        name: "Fanta",
        description: "Sweet and fizzy orange-flavored soda.",
        imagePath: "lib/images/drinks/fanta.jpg",
        price: 2.99,
        category: FoodCategory.drink,
        availableAddons: [
          Addon(name: "Extra ice", price: 0.50),
          Addon(name: "Orange slice", price: 0.25),
          Addon(name: "Large size", price: 1.00),
        ]),
    Food(
        name: "Sprite",
        description: "Crisp lemon-lime soda with a refreshing taste.",
        imagePath: "lib/images/drinks/sprite.jpg",
        price: 2.99,
        category: FoodCategory.drink,
        availableAddons: [
          Addon(name: "Extra ice", price: 0.50),
          Addon(name: "Mint leaves", price: 0.25),
          Addon(name: "Large size", price: 1.00),
        ]),
  ];

  final List<CartItem> _cart = [];

  String _deliveryAdress = 'Brasov, Carpatilor, nr25';

  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAdress => _deliveryAdress;

  void addToCart(Food food, List<Addon> selectedAddons) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      bool isSameFood = item.food == food;

      bool isSameAddons =
          ListEquality().equals(item.selectedAddons, selectedAddons);

      return isSameFood && isSameAddons;
    });

    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(
        CartItem(food: food, selectedAddons: selectedAddons),
      );
    }

    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }

    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectedAddons) {
        total += addon.price;
      }

      total += itemTotal * cartItem.quantity;
    }

    return total;
  }

  int getTotalItemCount(){
    int totalItemCount = 0;

    for(CartItem cartItem in _cart){
      totalItemCount += cartItem.quantity;
    }

    return totalItemCount;
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  String displayCartReceipt(){
    final receipt = StringBuffer();
    receipt.writeln("Here's your order:");
    receipt.writeln();

    String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
    receipt.writeln("Date: $formattedDate");
    receipt.writeln();
    receipt.writeln("----------------------------------------");

    for(final cartItem in _cart){
      receipt.writeln(
        "${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}",);

      if(cartItem.selectedAddons.isNotEmpty){
        receipt.writeln("  Add-ons: ${_formatAddons(cartItem.selectedAddons)}");
      }
      receipt.writeln();
    }

    receipt.writeln("----------------------------------------");
    receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");
    receipt.writeln();
    receipt.writeln("Delivery Address: $_deliveryAdress");

    return receipt.toString();
  }

  String _formatPrice(double price) {
    return "\$${price.toStringAsFixed(2)}";
  }

  String _formatAddons(List<Addon> addons){
    return addons.map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
                 .join(", ");
  }

  void updateDeliveryAdress(String adress){
    _deliveryAdress = adress;
    notifyListeners();
  }
}
