import 'package:flutter/material.dart';

import '../../models/staff_member.dart';
import '../../widgets/staff_card.dart';

class StudentBrowseScreen extends StatelessWidget {
  const StudentBrowseScreen({
    super.key,
    required this.staffMembers,
  });

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
              const Text(
                'Find a Final Year Project Supervisor',