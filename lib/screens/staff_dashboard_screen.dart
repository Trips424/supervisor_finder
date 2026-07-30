import 'package:flutter/material.dart';

import '../../widgets/page_header.dart';
import '../../models/staff_member.dart';
import '../../widgets/section_card.dart';

class StaffDashboardScreen extends StatefulWidget {
  const StaffDashboardScreen({
    super.key,
    required this.staffMembers,
    required this.selectedStaff,
    required this.onStaffSelected,
    required this.onStaffUpdated,
  });

  final List<StaffMember> staffMembers;
  final StaffMember selectedStaff;
  final void Function(String staffId) onStaffSelected;
  final void Function(StaffMember staff) onStaffUpdated;

  @override
  State<StaffDashboardScreen> createState() => _StaffDashboardScreenState();
}

class _StaffDashboardScreenState extends State<StaffDashboardScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _departmentController;
  late final TextEditingController _biographyController;
  late bool _acceptingStudents;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.selectedStaff.name);
    _emailController = TextEditingController(text: widget.selectedStaff.email);
    _departmentController = TextEditingController(
      text: widget.selectedStaff.department,
    );
    _biographyController = TextEditingController(
      text: widget.selectedStaff.biography,
    );
    _acceptingStudents = widget.selectedStaff.acceptingStudents;
  }

  @override
  void didUpdateWidget(covariant StaffDashboardScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedStaff.id != widget.selectedStaff.id) {
      _nameController.text = widget.selectedStaff.name;
      _emailController.text = widget.selectedStaff.email;
      _departmentController.text = widget.selectedStaff.department;
      _biographyController.text = widget.selectedStaff.biography;
      _acceptingStudents = widget.selectedStaff.acceptingStudents;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _departmentController.dispose();
    _biographyController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _addSpecialisation() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add specialisation'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Specialisation',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final specialisation = controller.text.trim();

                if (specialisation.isEmpty) {
                  _showMessage('Specialisation cannot be empty.');
                  return;
                }

                final updatedSpecialisations = List<String>.from(
                  widget.selectedStaff.specialisations,
                );

                updatedSpecialisations.add(specialisation);

                widget.onStaffUpdated(
                  widget.selectedStaff.copyWith(
                    specialisations: updatedSpecialisations,
                  ),
                );

                Navigator.of(context).pop();
                _showMessage('Specialisation added.');
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteSpecialisation(int index) {
    final updatedSpecialisations = List<String>.from(
      widget.selectedStaff.specialisations,
    );
    updatedSpecialisations.removeAt(index);

    widget.onStaffUpdated(
      widget.selectedStaff.copyWith(specialisations: updatedSpecialisations),
    );

    _showMessage('Specialisation deleted.');
  }

  void _saveProfile() {
    if (_nameController.text.trim().isEmpty) {
      _showMessage('Name cannot be empty.');
      return;
    }

    if (_emailController.text.trim().isEmpty) {
      _showMessage('Email cannot be empty.');
      return;
    }

    if (!_emailController.text.contains('@port.ac.uk')) {
      _showMessage('Please enter a valid uni email address.');
      return;
    }

    if (_departmentController.text.trim().isEmpty) {
      _showMessage('Department cannot be empty.');
      return;
    }

    if (_biographyController.text.trim().isEmpty) {
      _showMessage('Biography cannot be empty.');
      return;
    }

    final updatedStaff = widget.selectedStaff.copyWith(
      name: _nameController.text,
      email: _emailController.text,
      department: _departmentController.text,
      biography: _biographyController.text,
      acceptingStudents: _acceptingStudents,
    );

    widget.onStaffUpdated(updatedStaff);
    _showMessage('Profile updated successfully!');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Staff Dashboard',
            subtitle: 'Manage your profile, specialisations and project ideas.',
          ),
          const SizedBox(height: 24),
          DropdownButtonFormField<String>(
            initialValue: widget.selectedStaff.id,
            decoration: const InputDecoration(
              labelText: 'Select staff profile',
              border: OutlineInputBorder(),
            ),
            items: widget.staffMembers.map((staff) {
              return DropdownMenuItem<String>(
                value: staff.id,
                child: Text(staff.name),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                widget.onStaffSelected(value);
              }
            },
          ),
          const SizedBox(height: 24),
          SectionCard(
            title: 'Selected Staff Profile',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Editing: ${widget.selectedStaff.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                SectionCard(
                  title: 'Specialisations',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilledButton.icon(
                        onPressed: _addSpecialisation,
                        icon: const Icon(Icons.add),
                        label: const Text('Add specialisation'),
                      ),
                      const SizedBox(height: 12),
                      ...widget.selectedStaff.specialisations
                          .asMap()
                          .entries
                          .map((entry) {
                            final index = entry.key;
                            final specialisation = entry.value;

                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(specialisation),
                              trailing: IconButton(
                                onPressed: () {
                                  _deleteSpecialisation(index);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _departmentController,
                  decoration: const InputDecoration(
                    labelText: 'Department',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _biographyController,
                  decoration: const InputDecoration(
                    labelText: 'Biography',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),

                const SizedBox(height: 12),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Accepting Students'),
                  value: _acceptingStudents,
                  onChanged: (value) {
                    setState(() {
                      _acceptingStudents = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _saveProfile,
                  icon: const Icon(Icons.save),
                  label: const Text('Save Profile'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
