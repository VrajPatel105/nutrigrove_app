// core/constants/colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Nature-inspired greens with energy
  static const Color primary = Color(0xFF4CAF50); // Vibrant green
  static const Color primaryDark = Color(0xFF388E3C);
  static const Color primaryLight = Color(0xFF81C784);
  
  // Secondary Colors - Blues and earth tones
  static const Color secondary = Color(0xFF2196F3); // Energetic blue
  static const Color accent = Color(0xFF8BC34A); // Light green
  static const Color earth = Color(0xFF8D6E63); // Earth tone
  
  // Progress & Status Colors
  static const Color success = Color(0xFF66BB6A);
  static const Color warning = Color(0xFFFFB74D);
  static const Color error = Color(0xFFE57373);
  static const Color info = Color(0xFF64B5F6);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFBDBDBD);
  static const Color white = Color(0xFFFFFFFF);
  
  // Background Colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color lightGrey = Color(0xFFF5F5F5);
  
  // Card Colors - ADD THESE FOR THEME COMPATIBILITY
  static const Color cardBackground = Color(0xFFFFFFFF); // White background for cards
  static const Color cardShadow = Color(0xFF000000);     // Shadow color for cards
  
  // Tracker-specific colors for monthly progress
  static const Color trackerGreen = Color(0xFF66BB6A);  // Success/tracked days
  static const Color trackerRed = Color(0xFFEF5350);    // Missed days
  static const Color trackerBlank = Color(0xFFE0E0E0);  // Future/untracked days
  
  // Additional utility colors
  static const Color grey = Color(0xFF9E9E9E);
  
  // Gradients - Lifesum-inspired with nature colors
  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Gradient energyGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFF4CAF50)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Gradient caloricGradient = LinearGradient(
    colors: [Color(0xFF66BB6A), Color(0xFF81C784), Color(0xFFA5D6A7)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  static const Gradient monthlyGradient = LinearGradient(
    colors: [Color(0xFFE57373), Color(0xFF66BB6A)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  
  // Legacy gradients for backward compatibility
  static const Gradient freshFoodGradient = primaryGradient;
  static const Gradient lightGradient = LinearGradient(
    colors: [Color(0xFFF1F8E9), Color(0xFFE8F5E8)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient groveProgressGradient = LinearGradient(
  colors: [
    Color(0xFF4CAF50), // Vibrant Green
    Color(0xFF2196F3), // Energetic Blue
    Color(0xFFFF9800), // Warm Orange
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
}
