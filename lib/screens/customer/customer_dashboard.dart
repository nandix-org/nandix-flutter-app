import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
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
            const Text('NANDIX'),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.account_circle_outlined), onPressed: () {}),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [_buildHomeView(), _buildPointsView(), _buildStoresView(), _buildBillsView(), _buildProfileView()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.stars_outlined), activeIcon: Icon(Icons.stars), label: 'NX Points'),
          BottomNavigationBarItem(icon: Icon(Icons.store_outlined), activeIcon: Icon(Icons.store), label: 'Stores'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined), activeIcon: Icon(Icons.receipt_long), label: 'Bills'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildHomeView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // NX Credit Score Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppTheme.navy, AppTheme.navy.withOpacity(0.8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: AppTheme.navy.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('NX Credit Score', style: TextStyle(fontFamily: 'Inter', color: AppTheme.pearl.withOpacity(0.7), fontSize: 14)),
                      const SizedBox(height: 4),
                      Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        const Text('785', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 48, fontWeight: FontWeight.bold, color: AppTheme.pearl)),
                        Padding(padding: const EdgeInsets.only(bottom: 8, left: 4), child: Text('/850', style: TextStyle(fontFamily: 'Inter', color: AppTheme.pearl.withOpacity(0.5), fontSize: 16))),
                      ]),
                    ]),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: AppTheme.success.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.verified, color: AppTheme.success.withOpacity(0.8), size: 16),
                        const SizedBox(width: 4),
                        Text('Excellent', style: TextStyle(fontFamily: 'Inter', color: AppTheme.success.withOpacity(0.9), fontWeight: FontWeight.w600, fontSize: 12)),
                      ]),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Available Credit', style: TextStyle(fontFamily: 'Inter', color: AppTheme.pearl.withOpacity(0.7), fontSize: 13)),
                    const Text('₹25,000', style: TextStyle(fontFamily: 'Inter', color: AppTheme.pearl, fontWeight: FontWeight.bold, fontSize: 18)),
                  ]),
                ),
              ],
            ),
          ),
          // NX Points Balance
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Row(children: [
                Container(width: 48, height: 48, decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(12)), child: Icon(Icons.stars, color: Colors.amber.shade700, size: 24)),
                const SizedBox(width: 16),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('NX Points', style: TextStyle(fontFamily: 'Inter', color: AppTheme.navy.withOpacity(0.6), fontSize: 13)),
                  const Text('1,250 pts', style: TextStyle(fontFamily: 'Inter', color: AppTheme.navy, fontWeight: FontWeight.bold, fontSize: 20)),
                ])),
                TextButton(onPressed: () {}, child: const Text('Redeem')),
              ]),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text('Outstanding Dues', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.navy)),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(children: [
                _DueItem(storeName: 'SuperMart', amount: '₹2,500', dueDate: 'Due in 5 days'),
                const Divider(height: 24),
                _DueItem(storeName: 'QuickStop', amount: '₹1,200', dueDate: 'Due in 12 days'),
              ]),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Recent Purchases', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.navy)),
              TextButton(onPressed: () {}, child: const Text('View All')),
            ]),
          ),
          const SizedBox(height: 8),
          _PurchaseTile(storeName: 'SuperMart', items: '5 items', amount: '₹850', date: 'Today'),
          _PurchaseTile(storeName: 'QuickStop', items: '3 items', amount: '₹320', date: 'Yesterday'),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildPointsView() => const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.stars, size: 64, color: Colors.amber), SizedBox(height: 16), Text('NX Points & Rewards', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 24, color: AppTheme.navy))]));
  Widget _buildStoresView() => const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.store, size: 64, color: AppTheme.navy), SizedBox(height: 16), Text('Connected Stores', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 24, color: AppTheme.navy))]));
  Widget _buildBillsView() => const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.receipt_long, size: 64, color: AppTheme.navy), SizedBox(height: 16), Text('Bills & Transactions', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 24, color: AppTheme.navy))]));
  Widget _buildProfileView() => const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.person, size: 64, color: AppTheme.navy), SizedBox(height: 16), Text('Profile Settings', style: TextStyle(fontFamily: 'Playfair Display', fontSize: 24, color: AppTheme.navy))]));
}

class _DueItem extends StatelessWidget {
  final String storeName;
  final String amount;
  final String dueDate;

  const _DueItem({required this.storeName, required this.amount, required this.dueDate});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(width: 40, height: 40, decoration: BoxDecoration(color: AppTheme.navy.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.store, color: AppTheme.navy, size: 20)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(storeName, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, color: AppTheme.navy)),
        Text(dueDate, style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: AppTheme.warning)),
      ])),
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(amount, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold, color: AppTheme.navy)),
        TextButton(onPressed: () {}, style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap), child: const Text('Pay Now', style: TextStyle(fontSize: 12))),
      ]),
    ]);
  }
}

class _PurchaseTile extends StatelessWidget {
  final String storeName;
  final String items;
  final String amount;
  final String date;

  const _PurchaseTile({required this.storeName, required this.items, required this.amount, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Container(width: 44, height: 44, decoration: BoxDecoration(color: AppTheme.navy.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.receipt_long, color: AppTheme.navy, size: 20)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(storeName, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, color: AppTheme.navy)),
          Text('$items • $date', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: AppTheme.navy.withOpacity(0.5))),
        ])),
        Text(amount, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold, color: AppTheme.navy)),
      ]),
    );
  }
}
