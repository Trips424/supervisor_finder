import 'package:flutter/material.dart';

import '../../models/staff_member.dart';
import '../../widgets/specialisation_chip.dart';
import '../../widgets/project_idea_card.dart';

class StaffDetailScreen extends StatelessWidget {
  const StaffDetailScreen({super.key, required this.staff});

  final StaffMember staff;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(staff.name)),
      body: SingleChildScrollView(
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
            const SizedBox(height: 24),
            const Text(
              'Project Ideas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (staff.projectIdeas.isEmpty)
              const Text('No project ideas have been added.')
            else
              ...staff.projectIdeas.map((project) {
                return ProjectIdeaCard(projectIdea: project);
              }),
          ],
        ),
      ),
    );
  }
}
