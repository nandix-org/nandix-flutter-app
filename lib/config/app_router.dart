import 'package:go_router/go_router.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/mpin_screen.dart';
import '../screens/store/store_dashboard.dart';
import '../screens/admin/admin_dashboard.dart';
import '../screens/customer/customer_dashboard.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/mpin',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return MPINScreen(
          phone: extra?['phone'],
          isSetup: extra?['isSetup'] ?? false,
        );
      },
    ),
    GoRoute(
      path: '/store',
      builder: (context, state) => const StoreDashboard(),
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminDashboard(),
    ),
    GoRoute(
      path: '/customer',
      builder: (context, state) => const CustomerDashboard(),
    ),
  ],
);
