// screens/main/home/widgets/monthly_tracker_widget.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

class MonthlyTrackerWidget extends StatefulWidget {
  const MonthlyTrackerWidget({super.key});

  @override
  State<MonthlyTrackerWidget> createState() => _MonthlyTrackerWidgetState();
}

class _MonthlyTrackerWidgetState extends State<MonthlyTrackerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Mock data - replace with actual data from service
  final List<bool> _monthlyData = List.generate(30, (index) {
    // Simulate some days tracked, some not
    return index % 3 != 0 || index < 5;
  });

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final trackedDays = _monthlyData.where((tracked) => tracked).length;
    final totalDays = _monthlyData.length;
    final percentage = (trackedDays / totalDays * 100).round();

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Card(
        elevation: 4,
        shadowColor: AppColors.primary.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                AppColors.surface,
                AppColors.primary.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Monthly Progress',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$percentage%',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Calendar grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: totalDays,
                itemBuilder: (context, index) {
                  final isTracked = _monthlyData[index];
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 100 + (index * 20)),
                    curve: Curves.easeOut,
                    decoration: BoxDecoration(
                      color: isTracked 
                          ? AppColors.success 
                          : AppColors.error.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: isTracked
                          ? [
                              BoxShadow(
                                color: AppColors.success.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 16),
              
              // Stats
              Row(
                children: [
                  _buildStatItem(
                    context,
                    'Days Tracked',
                    '$trackedDays',
                    AppColors.success,
                    Icons.check_circle,
                  ),
                  const Spacer(),
                  _buildStatItem(
                    context,
                    'Missed Days',
                    '${totalDays - trackedDays}',
                    AppColors.error,
                    Icons.cancel,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          '$value $label',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
