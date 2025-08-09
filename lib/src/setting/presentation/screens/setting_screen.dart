import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/src/profile/features/theme/presentation/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Theme Switch
          SwitchListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            tileColor: context.color.surfaceContainer,
            title: const Text('Dark Mode'),
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (value) {
              // Replace with your theme provider toggle logic
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),

          const SizedBox(
            height: 12,
          ),

          // Notifications
          SwitchListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            tileColor: context.color.surfaceContainer,
            title: const Text('Enable Notifications'),
            value: true, // You can bind this to a settings provider
            onChanged: (value) {
              // Handle toggle
            },
          ),
          const SizedBox(
            height: 12,
          ),

          // const Divider(),

          // Address Book
          ListTile(
            leading: const Icon(Icons.location_on_outlined),
            title: const Text('Manage Addresses'),
            onTap: () {
              // Navigate to address management
            },
          ),

          // Payment Methods
          ListTile(
            leading: const Icon(Icons.payment_outlined),
            title: const Text('Payment Methods'),
            onTap: () {
              // Navigate to saved payment methods screen
            },
          ),

          // Order History
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Order History'),
            onTap: () {
              // Navigate to order history screen
            },
          ),

          const Divider(),

          // Help & Support
          ListTile(
            leading: const Icon(Icons.support_agent),
            title: const Text('Help & Support'),
            onTap: () {
              // Open support screen or external link
            },
          ),

          // Privacy Policy
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy Policy'),
            onTap: () {
              // Show webview or markdown
            },
          ),

          // Terms & Conditions
          ListTile(
            leading: const Icon(Icons.article_outlined),
            title: const Text('Terms & Conditions'),
            onTap: () {
              // Show webview or markdown
            },
          ),

          const Divider(),

          // Sign Out
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign Out'),
            textColor: theme.colorScheme.error,
            iconColor: theme.colorScheme.error,
            onTap: () {
              // Handle sign out logic
              // Example: authController.logout()
            },
          ),
        ],
      ),
    );
  }
}
