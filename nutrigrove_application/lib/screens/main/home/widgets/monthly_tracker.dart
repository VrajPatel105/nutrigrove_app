import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../services/mock_data_service.dart';

class MonthlyTracker extends StatelessWidget {
  const MonthlyTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MockDataService>(
      builder: (context, dataService, child) {
        final now = DateTime.now();
        final monthName = DateFormat('MMMM').format(now);
        final progress = dataService.monthlyProgress;
        
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      monthName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${_getSuccessCount(progress)}/${progress.length} days',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Calendar grid
                _buildCalendarGrid(context, progress, now),
                
                const SizedBox(height: 16),
                
                // Legend
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLegendItem('Success', AppColors.trackerGreen),
                    const SizedBox(width: 16),
                    _buildLegendItem('Missed', AppColors.trackerRed),
                    const SizedBox(width: 16),
                    _buildLegendItem('Future', AppColors.trackerBlank),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCalendarGrid(
    BuildContext context,
    Map<DateTime, bool> progress,
    DateTime currentMonth,
  ) {
    final firstDay = DateTime(currentMonth.year, currentMonth.month, 1);
    // ignore: unused_local_variable
    final lastDay = DateTime(currentMonth.year, currentMonth.month + 1, 0);
    final startOfWeek = firstDay.subtract(Duration(days: firstDay.weekday % 7));
    
    const weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    
    return Column(
      children: [
        // Week day headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: weekDays.map((day) => 
            SizedBox(
              width: 32,
              child: Text(
                day,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ).toList(),
        ),
        
        const SizedBox(height: 8),
        
        // Calendar days
        ...List.generate(6, (weekIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(7, (dayIndex) {
                final date = startOfWeek.add(Duration(days: weekIndex * 7 + dayIndex));
                final isCurrentMonth = date.month == currentMonth.month;
                final isToday = date.day == DateTime.now().day && 
                               date.month == DateTime.now().month && 
                               date.year == DateTime.now().year;
                
                if (!isCurrentMonth) {
                  return const SizedBox(width: 32, height: 32);
                }
                
                return _buildDaySquare(context, date, progress[date], isToday);
              }),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDaySquare(BuildContext context, DateTime date, bool? isSuccess, bool isToday) {
    Color backgroundColor;
    Color textColor = AppColors.textPrimary;
    
    if (date.isAfter(DateTime.now())) {
      backgroundColor = AppColors.trackerBlank;
      textColor = AppColors.textLight;
    } else if (isSuccess == true) {
      backgroundColor = AppColors.trackerGreen;
      textColor = AppColors.white;
    } else {
      backgroundColor = AppColors.trackerRed;
      textColor = AppColors.white;
    }
    
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: isToday ? Border.all(color: AppColors.primary, width: 2) : null,
      ),
      child: Center(
        child: Text(
          '${date.day}',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  int _getSuccessCount(Map<DateTime, bool> progress) {
    return progress.values.where((success) => success == true).length;
  }
}
