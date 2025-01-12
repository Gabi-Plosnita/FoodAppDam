class Food {
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final FoodCategory category;
  List<Addon> availableAddons;

  Food({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.availableAddons,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'imagePath': imagePath,
    'price': price,
    'category': category.toString().split('.').last,
    'availableAddons': availableAddons.map((addon) => addon.toJson()).toList(),
  };

  factory Food.fromJson(Map<String, dynamic> json) => Food(
    name: json['name'],
    description: json['description'],
    imagePath: json['imagePath'],
    price: json['price'],
    category: FoodCategory.values.firstWhere((e) => e.toString().split('.').last == json['category']),
    availableAddons: List<Addon>.from(json['availableAddons'].map((addon) => Addon.fromJson(addon))),
  );
}

enum FoodCategory {
  burger,
  pizza,
  drink,
}

class Addon{
  String name;
  double price;

  Addon({
    required this.name,
    required this.price
  });

   Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
  };

  factory Addon.fromJson(Map<String, dynamic> json) => Addon(
    name: json['name'],
    price: json['price'],
  );
}