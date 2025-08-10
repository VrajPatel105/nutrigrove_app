import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import '../models/preference_model.dart';

class MockDataService extends ChangeNotifier {
  List<MealModel> _meals = [];
  int _currentStreak = 0;
  List<DateTime> _loggedDays = [];
  Map<DateTime, bool> _monthlyProgress = {};

  List<MealModel> get meals => _meals;
  int get currentStreak => _currentStreak;
  List<DateTime> get loggedDays => _loggedDays;
  Map<DateTime, bool> get monthlyProgress => _monthlyProgress;

  MockDataService() {
    _initializeMockData();
  }

  void _initializeMockData() {
    _meals = [
      // Breakfast options
      MealModel(
        id: '1',
        name: 'Protein Pancakes',
        description: 'Fluffy pancakes with protein powder and berries',
        calories: 420,
        protein: 25,
        carbs: 45,
        fat: 12,
        type: MealType.breakfast,
        ingredients: ['Oats', 'Protein Powder', 'Banana', 'Berries'],
        allergens: ['Gluten'],
      ),
      MealModel(
        id: '2',
        name: 'Greek Yogurt Bowl',
        description: 'Greek yogurt with granola and fresh fruits',
        calories: 350,
        protein: 20,
        carbs: 40,
        fat: 10,
        type: MealType.breakfast,
        ingredients: ['Greek Yogurt', 'Granola', 'Strawberries', 'Honey'],
        allergens: ['Dairy'],
      ),
      
      // Lunch options
      MealModel(
        id: '3',
        name: 'Grilled Chicken Salad',
        description: 'Fresh mixed greens with grilled chicken breast',
        calories: 480,
        protein: 35,
        carbs: 20,
        fat: 25,
        type: MealType.lunch,
        ingredients: ['Chicken Breast', 'Mixed Greens', 'Cherry Tomatoes', 'Avocado'],
        allergens: [],
      ),
      MealModel(
        id: '4',
        name: 'Quinoa Power Bowl',
        description: 'Quinoa with roasted vegetables and tahini dressing',
        calories: 520,
        protein: 18,
        carbs: 65,
        fat: 20,
        type: MealType.lunch,
        ingredients: ['Quinoa', 'Roasted Vegetables', 'Chickpeas', 'Tahini'],
        allergens: ['Sesame'],
      ),
      
      // Dinner options
      MealModel(
        id: '5',
        name: 'Salmon with Sweet Potato',
        description: 'Baked salmon with roasted sweet potato and broccoli',
        calories: 650,
        protein: 45,
        carbs: 35,
        fat: 30,
        type: MealType.dinner,
        ingredients: ['Salmon', 'Sweet Potato', 'Broccoli', 'Olive Oil'],
        allergens: ['Fish'],
      ),
      MealModel(
        id: '6',
        name: 'Veggie Stir Fry',
        description: 'Mixed vegetables stir-fried with tofu and brown rice',
        calories: 580,
        protein: 22,
        carbs: 70,
        fat: 18,
        type: MealType.dinner,
        ingredients: ['Tofu', 'Mixed Vegetables', 'Brown Rice', 'Soy Sauce'],
        allergens: ['Soy'],
      ),
    ];

    // Mock streak data
    _currentStreak = 7;
    
    // Mock logged days for the past week
    final now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      _loggedDays.add(now.subtract(Duration(days: i)));
    }

    // Mock monthly progress data
    _generateMonthlyProgress();
  }

  void _generateMonthlyProgress() {
    final now = DateTime.now();
    final lastDay = DateTime(now.year, now.month + 1, 0);
    
    for (int day = 1; day <= lastDay.day; day++) {
      final date = DateTime(now.year, now.month, day);
      if (date.isBefore(now) || date.isAtSameMomentAs(now)) {
        // 70% success rate for past days
        _monthlyProgress[date] = DateTime.now().millisecondsSinceEpoch % 10 < 7;
      }
    }
  }

  List<MealModel> getMealsByType(MealType type) {
    return _meals.where((meal) => meal.type == type).toList();
  }

  List<MealModel> getTodaysMeals() {
    // Return one meal from each type for today's plan
    return [
      _meals.where((m) => m.type == MealType.breakfast).first,
      _meals.where((m) => m.type == MealType.lunch).first,
      _meals.where((m) => m.type == MealType.dinner).first,
    ];
  }

  void toggleMealLogged(String mealId) {
    final mealIndex = _meals.indexWhere((meal) => meal.id == mealId);
    if (mealIndex != -1) {
      _meals[mealIndex] = _meals[mealIndex].copyWith(
        isLogged: !_meals[mealIndex].isLogged,
      );
      notifyListeners();
    }
  }

  double getTotalCalories() {
    return getTodaysMeals()
        .where((meal) => meal.isLogged)
        .fold(0, (sum, meal) => sum + meal.calories);
  }

  double getTotalProtein() {
    return getTodaysMeals()
        .where((meal) => meal.isLogged)
        .fold(0, (sum, meal) => sum + meal.protein);
  }

  // Preference options
  List<PreferenceModel> getAllergyOptions() {
    return [
      PreferenceModel(label: 'Gluten', value: 'gluten'),
      PreferenceModel(label: 'Dairy', value: 'dairy'),
      PreferenceModel(label: 'Nuts', value: 'nuts'),
      PreferenceModel(label: 'Shellfish', value: 'shellfish'),
      PreferenceModel(label: 'Eggs', value: 'eggs'),
      PreferenceModel(label: 'Soy', value: 'soy'),
      PreferenceModel(label: 'Fish', value: 'fish'),
    ];
  }

  List<PreferenceModel> getDietaryPreferences() {
    return [
      PreferenceModel(label: 'Vegetarian', value: 'vegetarian'),
      PreferenceModel(label: 'Vegan', value: 'vegan'),
      PreferenceModel(label: 'Keto', value: 'keto'),
      PreferenceModel(label: 'Paleo', value: 'paleo'),
      PreferenceModel(label: 'Mediterranean', value: 'mediterranean'),
      PreferenceModel(label: 'Low Carb', value: 'low_carb'),
      PreferenceModel(label: 'High Protein', value: 'high_protein'),
    ];
  }
}
