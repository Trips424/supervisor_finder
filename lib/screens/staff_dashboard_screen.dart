import 'package:flutter/material.dart';

import '../../widgets/page_header.dart';
import '../../models/staff_member.dart';
import '../../widgets/section_card.dart';

class StaffDashboardScreen extends StatelessWidget {
  const StaffDashboardScreen({
    super.key,
    required this.staffMembers,
    required this.selectedStaff,
    required this.onStaffSelected,
    required this.onStaffUpdated,
  });

  final List<StaffMember> staffMembers;
  final StaffMember selectedStaff;
  final void Function(String staffId) onStaffSelected;
  final void Function(StaffMember updatedStaff) onStaffUpdated;

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
          DropdownButtonFormField<String>(
            initialValue: selectedStaff.id,
            decoration: const InputDecoration(
              labelText: 'Select staff profile',
              border: OutlineInputBorder(),
            ),
            items: staffMembers.map((staff) {
              return DropdownMenuItem<String>(
                value: staff.id,
                child: Text(staff.name),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                onStaffSelected(value);
              }
            },
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
