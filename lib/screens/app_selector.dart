import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'webview_screen.dart';

class AppSelector extends StatefulWidget {
  const AppSelector({super.key});

  @override
  State<AppSelector> createState() => _AppSelectorState();
}

class _AppSelectorState extends State<AppSelector> {
  static const Color navy = Color(0xFF102E4A);
  static const Color pearl = Color(0xFFFFF7E6);
  static const Color cream = Color(0xFFF5F0E8);

  @override
  void initState() {
    super.initState();
    _checkSavedApp();
  }

  Future<void> _checkSavedApp() async {
    final prefs = await SharedPreferences.getInstance();
    final savedApp = prefs.getString('selected_app');
    if (savedApp != null && mounted) {
      _launchApp(savedApp, remember: false);
    }
  }

  void _launchApp(String appType, {bool remember = false}) async {
    if (remember) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selected_app', appType);
    }

    String url;
    String title;
    
    switch (appType) {
      case 'store':
        url = 'https://nandix.app';
        title = 'NANDIX Store';
        break;
      case 'admin':
        url = 'https://nandix-admin.web.app';
        title = 'NANDIX Admin';
        break;
      case 'customer':
        url = 'https://nandix-customer.web.app';
        title = 'NANDIX';
        break;
      default:
        return;
    }

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewScreen(url: url, title: title),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 60),
              // Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: navy,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: navy.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Nx',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: pearl,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'NANDIX',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: navy,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Smart Business OS',
                style: TextStyle(
                  fontSize: 14,
                  color: navy.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 60),
              const Text(
                'Select Your Portal',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: navy,
                ),
              ),
              const SizedBox(height: 24),
              // App Cards
              _AppCard(
                icon: Icons.store,
                title: 'Store Portal',
                subtitle: 'POS, Inventory, Bills',
                onTap: () => _launchApp('store', remember: true),
              ),
              const SizedBox(height: 16),
              _AppCard(
                icon: Icons.admin_panel_settings,
                title: 'Admin Portal',
                subtitle: 'Manage stores & network',
                onTap: () => _launchApp('admin', remember: true),
              ),
              const SizedBox(height: 16),
              _AppCard(
                icon: Icons.person,
                title: 'Customer Portal',
                subtitle: 'NX Points, Credit Score',
                onTap: () => _launchApp('customer', remember: true),
              ),
              const Spacer(),
              Text(
                'v1.0.0',
                style: TextStyle(
                  fontSize: 12,
                  color: navy.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _AppCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  static const Color navy = Color(0xFF102E4A);
  static const Color pearl = Color(0xFFFFF7E6);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: navy.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: navy,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: pearl, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: navy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: navy.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: navy.withOpacity(0.3),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
