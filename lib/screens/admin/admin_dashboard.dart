import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cream,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: AppTheme.pearl, borderRadius: BorderRadius.circular(8)),
              child: const Center(child: Text('Nx', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.navy))),
            ),
            const SizedBox(width: 12),
            const Text('NANDIX Admin'),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () {}),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [_buildHomeView(), _buildStoresView(), _buildUsersView(), _buildNetworkView(), _buildSettingsView()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), activeIcon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.store_outlined), activeIcon: Icon(Icons.store), label: 'Stores'),
          BottomNavigationBarItem(icon: Icon(Icons.people_outline), activeIcon: Icon(Icons.people), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.hub_outlined), activeIcon: Icon(Icons.hub), label: 'Network'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildHomeView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Platform Overview', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.navy)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _AdminStatCard(icon: Icons.store, label: 'Total Stores', value: '156', trend: '+12 this month', color: AppTheme.info)),
              const SizedBox(width: 12),
              Expanded(child: _AdminStatCard(icon: Icons.people, label: 'Active Users', value: '2,340', trend: '+89 this week', color: AppTheme.success)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _AdminStatCard(icon: Icons.receipt_long, label: 'Transactions', value: '45.2K', trend: '+2.1K today', color: Colors.purple)),
              const SizedBox(width: 12),
              Expanded(child: _AdminStatCard(icon: Icons.account_balance_wallet, label: 'Volume', value: '₹8.5Cr', trend: '+₹45L this week', color: AppTheme.warning)),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Network Health', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.navy)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                _HealthRow(label: 'Store Uptime', value: '99.8%', color: AppTheme.success),
                const SizedBox(height: 12),
                _HealthRow(label: 'Sync Status', value: 'Healthy', color: AppTheme.success),
                const SizedBox(height: 12),
                _HealthRow(label: 'Pending Approvals', value: '3', color: AppTheme.warning),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoresView() => const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.store, size: 64, color: AppTheme.navy), SizedBox(height: 16), Text('Store Management', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 24, color: AppTheme.navy))]));
  Widget _buildUsersView() => const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.people, size: 64, color: AppTheme.navy), SizedBox(height: 16), Text('User Management', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 24, color: AppTheme.navy))]));
  Widget _buildNetworkView() => const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.hub, size: 64, color: AppTheme.navy), SizedBox(height: 16), Text('Network Intelligence', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 24, color: AppTheme.navy))]));
  Widget _buildSettingsView() => const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.settings, size: 64, color: AppTheme.navy), SizedBox(height: 16), Text('Platform Settings', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 24, color: AppTheme.navy))]));
}

class _AdminStatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String trend;
  final Color color;

  const _AdminStatCard({required this.icon, required this.label, required this.value, required this.trend, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: color, size: 20)),
            const Icon(Icons.trending_up, color: AppTheme.success, size: 16),
          ]),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontFamily: 'Inter', fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.navy)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: AppTheme.navy.withOpacity(0.6))),
          const SizedBox(height: 4),
          Text(trend, style: const TextStyle(fontFamily: 'Inter', fontSize: 11, color: AppTheme.success, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _HealthRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _HealthRow({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: TextStyle(fontFamily: 'Inter', color: AppTheme.navy.withOpacity(0.7))),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
        child: Text(value, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, color: color, fontSize: 13)),
      ),
    ]);
  }
}
