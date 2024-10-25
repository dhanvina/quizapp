import 'package:flutter/material.dart';
import 'package:quizapp/presentation/pages/login_page.dart';

import '../presentation/pages/dashboard.dart';

class AppRouter {
  static const String loginRoute = '/';
  static const String dashboardRoute = '/dashboard';

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case dashboardRoute:
        final fullName = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => DashboardPage(fullName));
      default:
        return null;
    }
  }
}
