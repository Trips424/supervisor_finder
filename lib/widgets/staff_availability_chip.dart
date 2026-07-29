import 'package:flutter/material.dart';

class StaffAvailabilityChip extends StatelessWidget {
  const StaffAvailabilityChip({super.key, required this.acceptingStudents});

  final bool acceptingStudents;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        acceptingStudents ? 'Accepting students' : 'Not accepting students',
      ),
      avatar: Icon(
        acceptingStudents ? Icons.check_circle : Icons.cancel,
        size: 18,
      ),
    );
  }
}
