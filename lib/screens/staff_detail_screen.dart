import 'package:flutter/material.dart';

import '../../models/staff_member.dart';
import '../../widgets/specialisation_chip.dart';

class StaffDetailScreen extends StatelessWidget {
  const StaffDetailScreen({super.key, required this.staff});

  final StaffMember staff;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(staff.name)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              staff.name,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(staff.department),
            Text(staff.email),
            const SizedBox(height: 24),
            Text(staff.biography, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            const Text(
              'Specialisations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: staff.specialisations.map((specialisation) {
                return SpecialisationChip(label: specialisation);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
