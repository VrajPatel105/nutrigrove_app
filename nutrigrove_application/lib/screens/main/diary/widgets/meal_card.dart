import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../models/meal_model.dart';

class MealCard extends StatelessWidget {
  final MealModel meal;
  final VoidCallback onToggleLogged;

  const MealCard({
    super.key,
    required this.meal,
    required this.onToggleLogged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: meal.isLogged ? 4 : 2,
      child: InkWell(
        onTap: () => _showMealDetails(context),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with name and log button
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meal.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: meal.isLogged ? AppColors.primary : AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          meal.description,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  
                  // Log button
                  GestureDetector(
                    onTap: onToggleLogged,
                    child: AnimatedContainer(
                      duration: AppConstants.shortAnimation,
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: meal.isLogged ? AppColors.success : AppColors.lightGrey,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: meal.isLogged ? AppColors.success : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        meal.isLogged ? Icons.check : Icons.add,
                        size: 16,
                        color: meal.isLogged ? AppColors.white : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Nutritional information
              Row(
                children: [
                  _buildNutrientChip('${meal.calories.toInt()} cal', AppColors.primary),
                  const SizedBox(width: 8),
                  _buildNutrientChip('${meal.protein.toInt()}g protein', AppColors.info),
                  const SizedBox(width: 8),
                  _buildNutrientChip('${meal.carbs.toInt()}g carbs', AppColors.warning),
                ],
              ),
              
              // Allergens if any
              if (meal.allergens.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: meal.allergens.map((allergen) => 
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.error.withOpacity(0.3)),
                      ),
                      child: Text(
                        allergen,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.error,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutrientChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _showMealDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _MealDetailsBottomSheet(meal: meal),
    );
  }
}

class _MealDetailsBottomSheet extends StatelessWidget {
  final MealModel meal;

  const _MealDetailsBottomSheet({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Meal name and description
            Text(
              meal.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              meal.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Nutritional information
            Text(
              'Nutritional Information',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _buildDetailedNutrient('Calories', '${meal.calories.toInt()}', 'cal'),
                ),
                Expanded(
                  child: _buildDetailedNutrient('Protein', '${meal.protein.toInt()}', 'g'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDetailedNutrient('Carbs', '${meal.carbs.toInt()}', 'g'),
                ),
                Expanded(
                  child: _buildDetailedNutrient('Fat', '${meal.fat.toInt()}', 'g'),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Ingredients
            if (meal.ingredients.isNotEmpty) ...[
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: meal.ingredients.map((ingredient) => 
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      ingredient,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ).toList(),
              ),
              const SizedBox(height: 24),
            ],
            
            // Close button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedNutrient(String label, String value, String unit) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            '$label ($unit)',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
