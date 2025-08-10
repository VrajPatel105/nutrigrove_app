// screens/main/home/widgets/streak_card.dart
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../widgets/gradient_container.dart';

class StreakCard extends StatefulWidget {
  const StreakCard({super.key});

  @override
  State<StreakCard> createState() => _StreakCardState();
}

class _StreakCardState extends State<StreakCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  // Mock data - replace with actual streak data
  final int currentStreak = 14;
  final int bestStreak = 28;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
      ),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GradientContainer(
            gradient: AppColors.energyGradient,
            borderRadius: 16,
            padding: const EdgeInsets.all(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
            child: Row(
              children: [
                // Streak flame icon with animation
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Transform.rotate(
                    angle: _rotationAnimation.value * 0.1,
                    child: const Icon(
                      Icons.local_fire_department,
                      color: AppColors.white,
                      size: 32,
                    ),
                  ),
                ),
                
                const SizedBox(width: 20),
                
                // Streak information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Streak',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      
                      Row(
                        children: [
                          Text(
                            '$currentStreak',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'days',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 8),
                      
                      Text(
                        'Best: $bestStreak days',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Achievement badge
                if (currentStreak >= 7)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          color: AppColors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Great!',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
