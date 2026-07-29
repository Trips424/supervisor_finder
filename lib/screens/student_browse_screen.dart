import 'package:flutter/material.dart';

import '../../models/staff_member.dart';
import '../../utils/search_utils.dart';
import '../../widgets/page_header.dart';
import '../../widgets/staff_card.dart';

class StudentBrowseScreen extends StatefulWidget {
  const StudentBrowseScreen({
    super.key,
    required this.staffMembers,
  });

  final List<StaffMember> staffMembers;

  @override
  State<StudentBrowseScreen> createState() => _StudentBrowseScreenState();
}

class _StudentBrowseScreenState extends State<StudentBrowseScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredStaff = widget.staffMembers.where((staff) {
      return staffMemberMatchesQuery(staff, _searchQuery);
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageHeader(
                title: 'Find a Final Year Project Supervisor',
                subtitle:
                    'Browse staff profiles, specialisations and project ideas.',
              ),
              const SizedBox(height: 24),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Search staff, specialisations, or projects',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              if (filteredStaff.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: Text('No matching staff profiles found.'),
                    ),
                  ),
                )
              else
                ...filteredStaff.map((staff) {
                  return StaffCard(staff: staff);
                }),
            ],
          ),
        ),
      ),
    );
  }
}