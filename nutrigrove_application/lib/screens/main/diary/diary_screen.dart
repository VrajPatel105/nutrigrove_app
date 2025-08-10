import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../services/mock_data_service.dart';
import '../../../models/meal_model.dart';
import 'widgets/meal_card.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Food Diary'),
            Text(
              _formatDate(_selectedDate),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: _selectDate,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Breakfast'),
            Tab(text: 'Lunch'),
            Tab(text: 'Dinner'),
          ],
        ),
      ),
      body: Consumer<MockDataService>(
        builder: (context, dataService, child) {
          return Column(
            children: [
              // Daily summary card
              Container(
                margin: const EdgeInsets.all(AppConstants.paddingMedium),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingMedium),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSummaryItem(
                          'Calories',
                          '${dataService.getTotalCalories().toInt()}',
                          '/${AppConstants.defaultCalories.toInt()}',
                          AppColors.primary,
                        ),
                        _buildSummaryItem(
                          'Protein',
                          '${dataService.getTotalProtein().toInt()}g',
                          '/${AppConstants.defaultProtein.toInt()}g',
                          AppColors.info,
                        ),
                        _buildSummaryItem(
                          'Logged',
                          '${_getLoggedMealsCount(dataService)}',
                          '/3 meals',
                          AppColors.success,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Meal tabs content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildMealTab(dataService, MealType.breakfast),
                    _buildMealTab(dataService, MealType.lunch),
                    _buildMealTab(dataService, MealType.dinner),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCustomMeal,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, String total, Color color) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              TextSpan(
                text: total,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildMealTab(MockDataService dataService, MealType mealType) {
    final meals = dataService.getMealsByType(mealType);
    
    if (meals.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_outlined,
              size: 64,
              color: AppColors.textLight,
            ),
            const SizedBox(height: 16),
            Text(
              'No meals available',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Check back later for meal options',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textLight,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      itemCount: meals.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
          child: MealCard(
            meal: meals[index],
            onToggleLogged: () {
              dataService.toggleMealLogged(meals[index].id);
            },
          ),
        );
      },
    );
  }

  int _getLoggedMealsCount(MockDataService dataService) {
    return dataService.getTodaysMeals()
        .where((meal) => meal.isLogged)
        .length;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.day == now.day && date.month == now.month && date.year == now.year) {
      return 'Today';
    } else if (date.day == now.day - 1 && date.month == now.month && date.year == now.year) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addCustomMeal() {
    // TODO: Implement add custom meal functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Add custom meal feature coming soon!'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
