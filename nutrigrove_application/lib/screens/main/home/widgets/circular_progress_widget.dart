import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/colors.dart';
import '../../../../services/mock_data_service.dart';
import '../../../../widgets/gradient_container.dart';

class CircularProgressWidget extends StatefulWidget {
  const CircularProgressWidget({super.key});

  @override
  State<CircularProgressWidget> createState() => _CircularProgressWidgetState();
}

class _CircularProgressWidgetState extends State<CircularProgressWidget>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeOut),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      _progressController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MockDataService>(
      builder: (context, dataService, child) {
        final totalCalories = dataService.getTotalCalories();
        final targetCalories = 2000.0;
        final progress = (totalCalories / targetCalories).clamp(0.0, 1.0);
        final remainingCalories =
            (targetCalories - totalCalories).clamp(0.0, targetCalories);

        return GradientContainer(
          gradient: AppColors.lightGradient,
          borderRadius: 24,
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              // Circular progress indicator with animation
              SizedBox(
                width: 200,
                height: 200,
                child: AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, _) {
                    return CustomPaint(
                      painter: CircularProgressPainter(
                        progress: progress * _progressAnimation.value,
                        strokeWidth: 12,
                        backgroundColor: AppColors.lightGrey,
                        gradient: AppColors.groveProgressGradient, // ✅ NEW GRADIENT
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${(totalCalories * _progressAnimation.value).toInt()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                    fontSize: 36,
                                  ),
                            ),
                            Text(
                              'CALORIES',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${remainingCalories.toInt()} left',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.textLight),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Quick stats below progress
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildQuickStat(
                    'Eaten',
                    '${totalCalories.toInt()}',
                    AppColors.primary,
                    Icons.restaurant,
                  ),
                  _buildQuickStat(
                    'Burned',
                    '234',
                    AppColors.warning,
                    Icons.local_fire_department,
                  ),
                  _buildQuickStat(
                    'Remaining',
                    '${remainingCalories.toInt()}',
                    AppColors.info,
                    Icons.trending_up,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickStat(
      String label, String value, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Gradient gradient;

  CircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    if (progress > 0) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      final gradientPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      const startAngle = -math.pi / 2;
      final sweepAngle = 2 * math.pi * progress;

      canvas.drawArc(rect, startAngle, sweepAngle, false, gradientPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
