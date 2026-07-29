import 'package:flutter/material.dart';

import '../../models/staff_member.dart';
import '../../widgets/staff_card.dart';
import '../../widgets/page_header.dart';

class StudentBrowseScreen extends StatelessWidget {
  const StudentBrowseScreen({super.key, required this.staffMembers});

  final List<StaffMember> staffMembers;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageHeader(
                title: 'Browse Staff Members',
                subtitle: 'Explore our staff members and their project ideas.',
              ),
              const SizedBox(height: 6),
              ...staffMembers.map((staff) {
                return StaffCard(staff: staff);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
