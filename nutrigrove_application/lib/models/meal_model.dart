enum MealType { breakfast, lunch, dinner, snack }

class MealModel {
  final String id;
  final String name;
  final String description;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final MealType type;
  final List<String> ingredients;
  final List<String> allergens;
  final bool isLogged;

  MealModel({
    required this.id,
    required this.name,
    required this.description,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.type,
    required this.ingredients,
    required this.allergens,
    this.isLogged = false,
  });

  MealModel copyWith({
    String? id,
    String? name,
    String? description,
    double? calories,
    double? protein,
    double? carbs,
    double? fat,
    MealType? type,
    List<String>? ingredients,
    List<String>? allergens,
    bool? isLogged,
  }) {
    return MealModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      type: type ?? this.type,
      ingredients: ingredients ?? this.ingredients,
      allergens: allergens ?? this.allergens,
      isLogged: isLogged ?? this.isLogged,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'type': type.name,
      'ingredients': ingredients,
      'allergens': allergens,
      'isLogged': isLogged,
    };
  }

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      calories: json['calories'].toDouble(),
      protein: json['protein'].toDouble(),
      carbs: json['carbs'].toDouble(),
      fat: json['fat'].toDouble(),
      type: MealType.values.firstWhere((e) => e.name == json['type']),
      ingredients: List<String>.from(json['ingredients']),
      allergens: List<String>.from(json['allergens']),
      isLogged: json['isLogged'] ?? false,
    );
  }
}
