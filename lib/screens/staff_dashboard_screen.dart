import 'package:flutter/material.dart';

import '../../widgets/page_header.dart';
import '../../models/staff_member.dart';

class StaffDashboardScreen extends StatelessWidget {
  const StaffDashboardScreen({
    super.key,
    required this.staffMembers,
    required this.selectedStaff,
    required this.onStaffSelected,
  });

  final List<StaffMember> staffMembers;
  final StaffMember selectedStaff;
  final void Function(StaffMember) onStaffSelected;

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
