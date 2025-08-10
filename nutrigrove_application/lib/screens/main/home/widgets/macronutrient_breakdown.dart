// screens/main/home/widgets/macronutrient_breakdown.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/colors.dart';
import '../../../../services/mock_data_service.dart';

class MacronutrientBreakdown extends StatelessWidget {
  const MacronutrientBreakdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MockDataService>(
      builder: (context, dataService, child) {
        final protein = dataService.getTotalProtein();
        final carbs = 150.0; // TODO: Get from service
        final fat = 65.0; // TODO: Get from service

        return Card(
          elevation: 4,
          shadowColor: AppColors.primary.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Macronutrients',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 20),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildMacroItem(
                        context,
                        'Carbs',
                        '${carbs.toInt()}g',
                        '150g',
                        carbs / 150,
                        AppColors.warning,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildMacroItem(
                        context,
                        'Protein',
                        '${protein.toInt()}g',
                        '120g',
                        protein / 120,
                        AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildMacroItem(
                        context,
                        'Fat',
                        '${fat.toInt()}g',
                        '65g',
                        fat / 65,
                        AppColors.info,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMacroItem(
    BuildContext context,
    String label,
    String current,
    String target,
    double progress,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: current,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              TextSpan(
                text: ' / $target',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textLight,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 8),
        
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: color.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}
