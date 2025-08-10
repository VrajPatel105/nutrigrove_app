import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/app_constants.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Section
            Container(
              margin: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.paddingLarge),
                  child: Row(
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        child: const Icon(
                          Icons.person,
                          size: 32,
                          color: AppColors.primary,
                        ),
                      ),
                      
                      const SizedBox(width: 16),
                      
                      // User info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'John Doe',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'john.doe@university.edu',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.success.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Premium Member',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Edit button
                      IconButton(
                        onPressed: () => _editProfile(context),
                        icon: const Icon(Icons.edit_outlined),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Menu Items
            _buildMenuSection(
              context,
              'Account',
              [
                _MenuItem(
                  icon: Icons.person_outline,
                  title: 'Edit Profile',
                  subtitle: 'Update your personal information',
                  onTap: () => _editProfile(context),
                ),
                _MenuItem(
                  icon: Icons.fitness_center_outlined,
                  title: 'Preferences',
                  subtitle: 'Dietary preferences and goals',
                  onTap: () => _editPreferences(context),
                ),
                _MenuItem(
                  icon: Icons.security_outlined,
                  title: 'Privacy & Security',
                  subtitle: 'Manage your account security',
                  onTap: () => _privacySecurity(context),
                ),
              ],
            ),

            _buildMenuSection(
              context,
              'App Settings',
              [
                _MenuItem(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  subtitle: 'Meal reminders and updates',
                  onTap: () => _notificationSettings(context),
                ),
                _MenuItem(
                  icon: Icons.dark_mode_outlined,
                  title: 'Appearance',
                  subtitle: 'Theme and display settings',
                  onTap: () => _appearanceSettings(context),
                ),
                _MenuItem(
                  icon: Icons.language_outlined,
                  title: 'Language',
                  subtitle: 'App language preferences',
                  onTap: () => _languageSettings(context),
                ),
              ],
            ),

            _buildMenuSection(
              context,
              'Support',
              [
                _MenuItem(
                  icon: Icons.help_outline,
                  title: 'Help & FAQ',
                  subtitle: 'Get answers to common questions',
                  onTap: () => _helpFaq(context),
                ),
                _MenuItem(
                  icon: Icons.feedback_outlined,
                  title: 'Send Feedback',
                  subtitle: 'Help us improve NutriGrove',
                  onTap: () => _sendFeedback(context),
                ),
                _MenuItem(
                  icon: Icons.info_outline,
                  title: 'About',
                  subtitle: 'App version and information',
                  onTap: () => _aboutApp(context),
                ),
              ],
            ),

            _buildMenuSection(
              context,
              'Account Actions',
              [
                _MenuItem(
                  icon: Icons.logout,
                  title: 'Sign Out',
                  subtitle: 'Sign out of your account',
                  onTap: () => _signOut(context),
                  isDestructive: true,
                ),
              ],
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, String title, List<_MenuItem> items) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            ...items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  if (index > 0) const Divider(height: 1),
                  ListTile(
                    leading: Icon(
                      item.icon,
                      color: item.isDestructive ? AppColors.error : AppColors.textSecondary,
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: item.isDestructive ? AppColors.error : AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(item.subtitle),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.textLight,
                    ),
                    onTap: item.onTap,
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  // Menu action methods
  void _editProfile(BuildContext context) {
    _showComingSoon(context, 'Edit Profile');
  }

  void _editPreferences(BuildContext context) {
    _showComingSoon(context, 'Edit Preferences');
  }

  void _privacySecurity(BuildContext context) {
    _showComingSoon(context, 'Privacy & Security');
  }

  void _notificationSettings(BuildContext context) {
    _showComingSoon(context, 'Notification Settings');
  }

  void _appearanceSettings(BuildContext context) {
    _showComingSoon(context, 'Appearance Settings');
  }

  void _languageSettings(BuildContext context) {
    _showComingSoon(context, 'Language Settings');
  }

  void _helpFaq(BuildContext context) {
    _showComingSoon(context, 'Help & FAQ');
  }

  void _sendFeedback(BuildContext context) {
    _showComingSoon(context, 'Send Feedback');
  }

  void _aboutApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About NutriGrove'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('NutriGrove - Your meal planning companion'),
            const SizedBox(height: 16),
            Text(
              'Version: ${AppConstants.appVersion}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            const Text('Developed for university students to make healthy eating easier and more enjoyable.'),
            const SizedBox(height: 16),
            const Text('© 2024 NutriGrove. All rights reserved.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _signOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out of your account?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement sign out logic
              _showComingSoon(context, 'Sign Out');
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature feature coming soon!'),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  _MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });
}
