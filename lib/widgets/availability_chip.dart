import 'package:flutter/material.dart';

class AvailabilityChip extends StatelessWidget {
  const AvailabilityChip({super.key, required this.isAvailable});

  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(isAvailable ? 'Available' : 'Not Available'),

      avatar: Icon(isAvailable ? Icons.check_circle : Icons.cancel, size: 18),
    );
  }
}
