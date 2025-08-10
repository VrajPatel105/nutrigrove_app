// screens/main/home/home_screen.dart
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
// ignore: unused_import
import '../../../core/constants/app_constants.dart';
// ignore: unused_import
import '../../../services/mock_data_service.dart';
import '../../../widgets/gradient_container.dart';
import 'widgets/circular_progress_widget.dart';
import 'widgets/macronutrient_breakdown.dart';
import 'widgets/monthly_tracker.dart';
import 'widgets/streak_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _greetingController;
  late Animation<double> _greetingAnimation;

  @override
  void initState() {
    super.initState();
    _greetingController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _greetingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _greetingController, curve: Curves.easeOut),
    );
    _greetingController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour;
    String greeting;
    if (hour < 12) {
      greeting = 'Good morning';
    } else if (hour < 17) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.surface,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.lightGradient,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: FadeTransition(
                      opacity: _greetingAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '$greeting!',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'USERNAME', //  Replace with actual user name
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    color: AppColors.primary,
                  ),
                ),
                onPressed: () {
                  // TODO: Handle notifications
                },
              ),
              const SizedBox(width: 16),
            ],
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Today's Progress Section
                  _buildSectionHeader('Today\'s Progress', Icons.today),
                  const SizedBox(height: 20),
                  
                  // Main Caloric Progress Circle
                  const CircularProgressWidget(),
                  
                  const SizedBox(height: 32),
                  
                  // Macronutrient Breakdown
                  const MacronutrientBreakdown(),
                  
                  const SizedBox(height: 32),

                  // Streak Section
                  _buildSectionHeader('Your Streak', Icons.local_fire_department),
                  const SizedBox(height: 16),
                  
                  const StreakCard(),
                  
                  const SizedBox(height: 32),

                  // Monthly Progress Section
                  _buildSectionHeader('This Month', Icons.calendar_month),
                  const SizedBox(height: 16),
                  
                  const MonthlyTracker(),
                  
                  const SizedBox(height: 32),

                  // Quick Actions
                  _buildSectionHeader('Quick Actions', Icons.flash_on),
                  const SizedBox(height: 16),
                  
                  _buildQuickActions(),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildQuickActionCard(
            'Log Meal',
            Icons.restaurant,
            AppColors.primaryGradient,
            () {
              // TODO: Navigate to diary or quick log
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Quick log feature coming soon!'),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildQuickActionCard(
            'View Plan',
            Icons.calendar_today,
            AppColors.energyGradient,
            () {
              // TODO: Navigate to meal plan
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Meal plan feature coming soon!'),
                  backgroundColor: AppColors.secondary,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(
    String title,
    IconData icon,
    Gradient gradient,
    VoidCallback onTap,
  ) {
    return GradientContainer(
      gradient: gradient,
      borderRadius: 16,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: AppColors.white,
                  size: 32,
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _greetingController.dispose();
    super.dispose();
  }
}
