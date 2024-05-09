import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/widgets/dashboard/dashboard_screen.dart';
import 'package:admin/screens/widgets/stock/stock_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> screens = [DashboardScreen(), StockScreen()];
  Widget current = DashboardScreen();

  void selectScreen(Widget selected) {
    setState(() {
      current = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(
        onTap: selectScreen,
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(
                  onTap: selectScreen,
                ),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: current,
            ),
          ],
        ),
      ),
    );
  }
}
