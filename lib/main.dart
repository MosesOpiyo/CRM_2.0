import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/screens/main/login.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/widgets/dashboard/dashboard_screen.dart';
import 'package:admin/screens/widgets/stock/stock_screen.dart';
import 'package:admin/screens/widgets/supplier/supllier_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuAppController(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  Future<bool> isAuthenticated() async {
    final storage = const FlutterSecureStorage();
    final accessToken = await storage.read(key: 'access_token');
    return accessToken != null && accessToken.isNotEmpty;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: <RouteBase>[
        GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return Login();
            },
            routes: [
              GoRoute(
                path: 'Sales',
                pageBuilder: (context, state) {
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: MainScreen(currentWidget: DashboardScreen()),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  );
                },
              ),
              GoRoute(
                path: 'Stock',
                pageBuilder: (context, state) {
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: MainScreen(currentWidget: StockScreen()),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  );
                },
              ),
              GoRoute(
                path: 'Suppliers',
                pageBuilder: (context, state) {
                  return CustomTransitionPage<void>(
                    key: state.pageKey,
                    child: MainScreen(currentWidget: SupplierScreen()),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  );
                },
              ),
            ]),
      ],
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      routerConfig: _router,
    );
  }
}
