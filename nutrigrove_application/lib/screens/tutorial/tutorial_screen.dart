// screens/tutorial/tutorial_screen.dart
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/constants/colors.dart';
// ignore: unused_import
import '../../core/constants/app_constants.dart';
import '../../widgets/custom_button.dart';
import '../auth/auth_screen.dart';

class TutorialPageData {
  final String title;
  final String description;
  final IconData icon;
  final Gradient gradient;
  final String subtitle;

  TutorialPageData({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
    required this.subtitle,
  });
}

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<TutorialPageData> _pages = [
    TutorialPageData(
      title: 'Welcome to NutriGrove',
      subtitle: 'Your campus nutrition companion',
      description: 'Smart meal planning designed specifically for university dining halls and student life',
      icon: Icons.eco,
      gradient: AppColors.primaryGradient,
    ),
    TutorialPageData(
      title: 'Smart Meal Planning',
      subtitle: 'AI-powered recommendations',
      description: 'Get personalized meal suggestions based on your preferences, dietary restrictions, and nutritional goals',
      icon: Icons.psychology,
      gradient: AppColors.energyGradient,
    ),
    TutorialPageData(
      title: 'Track Your Progress',
      subtitle: 'Growing health journey',
      description: 'Build healthy habits with streaks, progress tracking, and achievements that keep you motivated',
      icon: Icons.trending_up,
      gradient: AppColors.monthlyGradient,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.lightGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with skip button
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'NutriGrove',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    TextButton(
                      onPressed: _navigateToAuth,
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Page view
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                    _fadeController.reset();
                    _fadeController.forward();
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildTutorialPage(_pages[index]);
                  },
                ),
              ),
              
              // Page indicator
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: _pages.length,
                  effect: WormEffect(
                    dotColor: AppColors.lightGrey,
                    activeDotColor: AppColors.primary,
                    dotHeight: 12,
                    dotWidth: 12,
                    spacing: 16,
                    radius: 16,
                  ),
                ),
              ),
              
              // Navigation buttons
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    if (_currentPage > 0)
                      Expanded(
                        child: CustomButton(
                          text: 'Back',
                          onPressed: _previousPage,
                          isOutlined: true,
                          backgroundColor: AppColors.textSecondary,
                        ),
                      ),
                    if (_currentPage > 0) const SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        text: _currentPage == _pages.length - 1
                            ? 'Get Started'
                            : 'Continue',
                        onPressed: _currentPage == _pages.length - 1
                            ? _navigateToAuth
                            : _nextPage,
                        gradient: AppColors.primaryGradient,
                        icon: _currentPage == _pages.length - 1
                            ? Icons.arrow_forward
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTutorialPage(TutorialPageData page) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with gradient background
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: page.gradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                page.icon,
                size: 60,
                color: AppColors.white,
              ),
            ),
            
            const SizedBox(height: 48),
            
            // Title
            Text(
              page.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 12),
            
            // Subtitle
            Text(
              page.subtitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 24),
            
            // Description
            Text(
              page.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToAuth() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AuthScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    super.dispose();
  }
}
