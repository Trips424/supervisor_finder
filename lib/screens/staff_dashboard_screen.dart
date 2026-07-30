import 'package:flutter/material.dart';

import '../../widgets/page_header.dart';

class StaffDashboardScreen extends StatelessWidget {
  const StaffDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: PageHeader(
        title: 'Staff Dashboard',
        subtitle: 'Manage your profile, specialisations and project ideas.',
      ),
    );
  }
}
