class UserModel {
  final String id;
  final String name;
  final String email;
  final double height;
  final double weight;
  final double goalWeight;
  final double goalProtein;
  final double goalCalories;
  final List<String> allergies;
  final List<String> foodPreferences;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.height,
    required this.weight,
    required this.goalWeight,
    required this.goalProtein,
    required this.goalCalories,
    required this.allergies,
    required this.foodPreferences,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'height': height,
      'weight': weight,
      'goalWeight': goalWeight,
      'goalProtein': goalProtein,
      'goalCalories': goalCalories,
      'allergies': allergies,
      'foodPreferences': foodPreferences,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      height: json['height'].toDouble(),
      weight: json['weight'].toDouble(),
      goalWeight: json['goalWeight'].toDouble(),
      goalProtein: json['goalProtein'].toDouble(),
      goalCalories: json['goalCalories'].toDouble(),
      allergies: List<String>.from(json['allergies']),
      foodPreferences: List<String>.from(json['foodPreferences']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
