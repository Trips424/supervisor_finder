import 'package:flutter/material.dart';

import '../../models/staff_member.dart';
import '../../widgets/staff_card.dart';
import '../../widgets/page_header.dart';

class StudentBrowseScreen extends StatefulWidget {
  const StudentBrowseScreen({super.key, required this.staffMembers});

  final List<StaffMember> staffMembers;

  @override
  State<StudentBrowseScreen> createState() => _StudentBrowseScreenState();
}

class _StudentBrowseScreenState extends State<StudentBrowseScreen> {
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
              const SizedBox(height: 25),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Search by name, department, or specialisation',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
                return StaffCard(staff: staff);
              ),
              const SizedBox(height: 20),
              ...widget.staffMembers
                  .where((staff) =>
                      staff.name.toLowerCase().contains(_searchQuery) ||
                      staff.department.toLowerCase().contains(_searchQuery) ||
                      staff.specialisations.any((specialisation) =>
                          specialisation.toLowerCase().contains(_searchQuery)))
                  .map((staff) => StaffCard(staff: staff))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
