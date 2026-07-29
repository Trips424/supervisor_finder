import 'package:flutter/material.dart';
import '../models/project_idea.dart';
import 'availability_chip.dart';

class ProjectIdeaCard extends StatelessWidget {
  const ProjectIdeaCard({super.key, required this.projectIdea});

  final ProjectIdea projectIdea;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              projectIdea.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(projectIdea.description),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                Chip(label: Text('Area: ${projectIdea.area}')),
                Chip(label: Text('Difficulty: ${projectIdea.difficulty}')),
                AvailabilityChip(isAvailable: projectIdea.availability),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
