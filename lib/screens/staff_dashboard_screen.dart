import 'package:flutter/material.dart';

import '../../widgets/page_header.dart';
import '../../models/staff_member.dart';

class StaffDashboardScreen extends StatelessWidget {
  const StaffDashboardScreen({super.key, required this.selectedStaff});

  final StaffMember selectedStaff;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Staff Dashboard',
            subtitle: 'Manage your profile, specialisations and project ideas.',
          ),
          const SizedBox(height: 24),
          Text(
            'Editing: ${selectedStaff.name}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
