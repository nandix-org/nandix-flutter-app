import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class StoreDashboard extends StatefulWidget {
  const StoreDashboard({super.key});

  @override
  State<StoreDashboard> createState() => _StoreDashboardState();
}

class _StoreDashboardState extends State<StoreDashboard> {
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
              decoration: BoxDecoration(
                color: AppTheme.pearl,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Nx',
                  style: TextStyle(
                    fontFamily: 'Playfair Display',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.navy,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text('NANDIX Store'),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.person_outline), onPressed: () {}),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeView(),
          _buildPOSView(),
          _buildInventoryView(),
          _buildCustomersView(),
          _buildReportsView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), activeIcon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.point_of_sale_outlined), activeIcon: Icon(Icons.point_of_sale), label: 'POS'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), activeIcon: Icon(Icons.inventory_2), label: 'Inventory'),
          BottomNavigationBarItem(icon: Icon(Icons.people_outline), activeIcon: Icon(Icons.people), label: 'Customers'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), activeIcon: Icon(Icons.analytics), label: 'Reports'),
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
          Row(
            children: [
              Expanded(child: _StatCard(icon: Icons.receipt_long, label: "Today's Sales", value: '₹24,500', color: AppTheme.success)),
              const SizedBox(width: 12),
              Expanded(child: _StatCard(icon: Icons.shopping_cart, label: 'Orders', value: '18', color: AppTheme.info)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _StatCard(icon: Icons.account_balance_wallet, label: 'Outstanding', value: '₹12,800', color: AppTheme.warning)),
              const SizedBox(width: 12),
              Expanded(child: _StatCard(icon: Icons.inventory, label: 'Low Stock', value: '5', color: AppTheme.error)),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Quick Actions', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.navy)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _QuickActionCard(icon: Icons.add_shopping_cart, label: 'New Sale', onTap: () => setState(() => _currentIndex = 1))),
              const SizedBox(width: 12),
              Expanded(child: _QuickActionCard(icon: Icons.person_add, label: 'Add Customer', onTap: () {})),
              const SizedBox(width: 12),
              Expanded(child: _QuickActionCard(icon: Icons.add_box, label: 'Add Stock', onTap: () {})),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Recent Transactions', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.navy)),
              TextButton(onPressed: () {}, child: const Text('View All')),
            ],
          ),
          const SizedBox(height: 8),
          _TransactionTile(name: 'Customer #1234', amount: '₹1,250', time: '2 mins ago', status: 'Paid'),
          _TransactionTile(name: 'Customer #1233', amount: '₹3,500', time: '15 mins ago', status: 'Credit'),
          _TransactionTile(name: 'Customer #1232', amount: '₹850', time: '1 hour ago', status: 'Paid'),
        ],
      ),
    );
  }

  Widget _buildPOSView() => const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.point_of_sale, size: 64, color: AppTheme.navy), SizedBox(height: 16), Text('POS Screen', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 24, color: AppTheme.navy))]));
  Widget _buildInventoryView() => const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.inventory_2, size: 64, color: AppTheme.navy), SizedBox(height: 16), Text('Inventory', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 24, color: AppTheme.navy))]));
  Widget _buildCustomersView() => const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.people, size: 64, color: AppTheme.navy), SizedBox(height: 16), Text('Customers', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 24, color: AppTheme.navy))]));
  Widget _buildReportsView() => const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.analytics, size: 64, color: AppTheme.navy), SizedBox(height: 16), Text('Reports', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 24, color: AppTheme.navy))]));
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.navy)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: AppTheme.navy.withOpacity(0.6))),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionCard({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(color: AppTheme.navy, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.pearl, size: 24),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.w500, color: AppTheme.pearl), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final String name;
  final String amount;
  final String time;
  final String status;

  const _TransactionTile({required this.name, required this.amount, required this.time, required this.status});

  @override
  Widget build(BuildContext context) {
    final isPaid = status == 'Paid';
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: AppTheme.navy.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.receipt_long, color: AppTheme.navy, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, color: AppTheme.navy)),
                Text(time, style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: AppTheme.navy.withOpacity(0.5))),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold, color: AppTheme.navy)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: isPaid ? AppTheme.success.withOpacity(0.1) : AppTheme.warning.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                child: Text(status, style: TextStyle(fontFamily: 'Inter', fontSize: 10, fontWeight: FontWeight.w600, color: isPaid ? AppTheme.success : AppTheme.warning)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
