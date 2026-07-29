import 'package:flutter/material.dart';
import '../models/staff_member.dart';
import '../screens/staff_detail_screen.dart';
import 'specialisation_chip.dart';
import 'staff_availability_chip.dart';

class StaffCard extends StatelessWidget {
  const StaffCard({super.key, required this.staff});

  final StaffMember staff;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              staff.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            StaffAvailabilityChip(acceptingStudents: staff.acceptingStudents),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => StaffDetailScreen(staff: staff),
                    ),
                  );
                },
                icon: const Icon(Icons.open_in_new),
                label: const Text('View profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
