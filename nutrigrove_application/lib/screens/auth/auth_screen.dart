import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/gradient_container.dart';
import '../preferences/preferences_screen.dart';
import 'widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.lightGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            child: Column(
              children: [
                const SizedBox(height: 40),
                
                // Logo and app name
                GradientContainer(
                  gradient: AppColors.freshFoodGradient,
                  borderRadius: 30,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.eco,
                      size: 30,
                      color: AppColors.white,
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                Text(
                  'NutriGrove',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  'Your meal planning companion',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                
                const SizedBox(height: 48),
                
                // Tab bar
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: AppColors.textPrimary,
                    unselectedLabelColor: AppColors.textSecondary,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    tabs: const [
                      Tab(text: 'Sign In'),
                      Tab(text: 'Sign Up'),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Tab bar view
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      AuthForm(
                        isSignUp: false,
                        onSubmit: _handleAuth, // ✅ Fixed: This now properly calls navigation
                      ),
                      AuthForm(
                        isSignUp: true,
                        onSubmit: _handleAuth, // ✅ Fixed: This now properly calls navigation
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ✅ Fixed: Simplified authentication handler
  void _handleAuth() {
    // For now, just navigate to preferences (later replace with actual auth)
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const PreferencesScreen()),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
