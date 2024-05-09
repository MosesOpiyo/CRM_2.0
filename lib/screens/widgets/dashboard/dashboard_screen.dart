import 'package:admin/responsive.dart';
import 'package:admin/screens/components/my_fields.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../components/header.dart';

import '../../components/recent_files.dart';
import '../../components/storage_details.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(Page: "Dashboard"),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Overalls(
                        overalls: "Sales Overalls",
                      ),
                      SizedBox(height: defaultPadding),
                      RecentFiles(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) SupplierDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: SupplierDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
