import 'package:flutter/material.dart';

class SpecialisationChip extends StatelessWidget {
  const SpecialisationChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label), avatar: const Icon(Icons.star, size: 18));
  }
}
