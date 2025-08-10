import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/app_constants.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../services/mock_data_service.dart';
import '../main/main_screen.dart';
import 'widgets/preference_item.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _goalWeightController = TextEditingController();
  final _goalProteinController = TextEditingController();
  final _goalCaloriesController = TextEditingController(text: '2000');

  List<String> _selectedAllergies = [];
  List<String> _selectedPreferences = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Your Preferences'),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome text
              Text(
                'Let\'s personalize your experience!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tell us about yourself to get the best meal recommendations',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),

              // Physical Information Section
              _buildSectionHeader('Physical Information'),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _heightController,
                      label: 'Height (inches)',
                      keyboardType: TextInputType.number,
                      validator: _validateNumber,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      controller: _weightController,
                      label: 'Weight (lbs)',
                      keyboardType: TextInputType.number,
                      validator: _validateNumber,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              CustomTextField(
                controller: _goalWeightController,
                label: 'Goal Weight (lbs)',
                keyboardType: TextInputType.number,
                validator: _validateNumber,
              ),
              
              const SizedBox(height: 32),

              // Nutritional Goals Section
              _buildSectionHeader('Nutritional Goals'),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _goalCaloriesController,
                      label: 'Daily Calories',
                      keyboardType: TextInputType.number,
                      validator: _validateNumber,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      controller: _goalProteinController,
                      label: 'Protein (g)',
                      keyboardType: TextInputType.number,
                      validator: _validateNumber,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 32),

              // Allergies Section
              _buildSectionHeader('Allergies & Dietary Restrictions'),
              const SizedBox(height: 16),
              
              Consumer<MockDataService>(
                builder: (context, dataService, child) {
                  final allergies = dataService.getAllergyOptions();
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: allergies.map((allergy) {
                      return PreferenceItem(
                        label: allergy.label,
                        value: allergy.value,
                        isSelected: _selectedAllergies.contains(allergy.value),
                        onChanged: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              _selectedAllergies.add(allergy.value);
                            } else {
                              _selectedAllergies.remove(allergy.value);
                            }
                          });
                        },
                      );
                    }).toList(),
                  );
                },
              ),
              
              const SizedBox(height: 32),

              // Dietary Preferences Section
              _buildSectionHeader('Dietary Preferences'),
              const SizedBox(height: 16),
              
              Consumer<MockDataService>(
                builder: (context, dataService, child) {
                  final preferences = dataService.getDietaryPreferences();
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: preferences.map((preference) {
                      return PreferenceItem(
                        label: preference.label,
                        value: preference.value,
                        isSelected: _selectedPreferences.contains(preference.value),
                        onChanged: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              _selectedPreferences.add(preference.value);
                            } else {
                              _selectedPreferences.remove(preference.value);
                            }
                          });
                        },
                      );
                    }).toList(),
                  );
                },
              ),
              
              const SizedBox(height: 48),

              // Continue Button
              CustomButton(
                text: 'Continue to App',
                onPressed: _savePreferences,
                isExpanded: true,
              ),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  void _savePreferences() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Save preferences to backend
      // For now, navigate to main app
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _goalWeightController.dispose();
    _goalProteinController.dispose();
    _goalCaloriesController.dispose();
    super.dispose();
  }
}
