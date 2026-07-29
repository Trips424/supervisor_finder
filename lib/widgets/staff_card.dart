import 'package:flutter/material.dart';
import '../models/staff_member.dart';
import 'availability_chip.dart';
import 'specialisation_chip.dart';

class StaffCard extends StatelessWidget {
  const StaffCard({
    super.key, 
    required this.staff
  });

  final StaffMember staff;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Text(
              staff.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(staff.department),
            Text(staff.email),
            const SizedBox(height: 12),
            Text(staff.biography),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: staff.specialisations.map((specialisation) {
                return SpecialisationChip(label: specialisation);
              }).toList(),
            ),
            const SizedBox(height: 12),
            AvailabilityChip(isAvailable: staff.acceptingStudents),
          ],
        ),
      ),
    );
  }
}


