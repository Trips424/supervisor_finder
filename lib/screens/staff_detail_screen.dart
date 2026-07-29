import 'package:flutter/material.dart';

import '../../models/staff_member.dart';

class StaffDetailScreen extends StatelessWidget {
  const StaffDetailScreen({
    super.key,
    required this.staff,
  });

  final StaffMember staff;

