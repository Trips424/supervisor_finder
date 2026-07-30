import 'package:flutter/material.dart';

import '../../widgets/page_header.dart';
import '../../models/staff_member.dart';
import '../../widgets/section_card.dart';

class StaffDashboardScreen extends StatefulWidget {
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
  final void Function(StaffMember staff) onStaffUpdated;

  @override
  State<StaffDashboardScreen> createState() => _StaffDashboardScreenState();
}

class _StaffDashboardScreenState extends State<StaffDashboardScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _departmentController;
  late final TextEditingController _biographyController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.selectedStaff.name);
    _emailController = TextEditingController(text: widget.selectedStaff.email);
    _departmentController = TextEditingController(
      text: widget.selectedStaff.department,
    );
    _biographyController = TextEditingController(
      text: widget.selectedStaff.biography,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _departmentController.dispose();
    _biographyController.dispose();
    super.dispose();
  }

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
            initValue: widget.selectedStaff.id,
            decoration: const InputDecoration(
              labelText: 'Select staff profile',
              border: OutlineInputBorder(),
            ),
            items: widget.staffMembers.map((staff) {
              return DropdownMenuItem(value: staff.id, child: Text(staff.name));
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                widget.onStaffSelected(value);
              }
            },
          ),
          const SizedBox(height: 24),
          SectionCard(
            title: 'Selected Staff Profile',
            child: Text(
              'Editing: ${widget.selectedStaff.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
