import 'package:flutter/material.dart';

import '../../widgets/page_header.dart';
import '../../models/staff_member.dart';
import '../../models/project_idea.dart';
import '../../widgets/section_card.dart';
import '../../widgets/project_idea_card.dart';

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
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete specialisation'),
          content: const Text(
            'Are you sure you want to delete this specialisation?',
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
                final updatedSpecialisations = List<String>.from(
                  widget.selectedStaff.specialisations,
                );

                updatedSpecialisations.removeAt(index);

                widget.onStaffUpdated(
                  widget.selectedStaff.copyWith(
                    specialisations: updatedSpecialisations,
                  ),
                );

                Navigator.of(context).pop();
                _showMessage('Specialisation deleted.');
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _editSpecialisation(int index) {
    final controller = TextEditingController(
      text: widget.selectedStaff.specialisations[index],
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit specialisation'),
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
                final updatedValue = controller.text.trim();

                if (updatedValue.isEmpty) {
                  _showMessage('Specialisation cannot be empty.');
                  return;
                }

                final updatedSpecialisations = List<String>.from(
                  widget.selectedStaff.specialisations,
                );

                updatedSpecialisations[index] = updatedValue;

                widget.onStaffUpdated(
                  widget.selectedStaff.copyWith(
                    specialisations: updatedSpecialisations,
                  ),
                );

                Navigator.of(context).pop();
                _showMessage('Specialisation updated.');
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _addProjectIdea() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    String selectedArea = 'Machine Learning';
    String difficulty = 'Intermediate';
    String availability = 'Available';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add project idea'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Project title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Project description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: selectedArea,
                decoration: const InputDecoration(
                  labelText: 'Project area',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Machine Learning',
                    child: Text('Machine Learning'),
                  ),
                  DropdownMenuItem(
                    value: 'Data Analysis',
                    child: Text('Data Analysis'),
                  ),
                  DropdownMenuItem(
                    value: 'Software Testing',
                    child: Text('Software Testing'),
                  ),
                  DropdownMenuItem(
                    value: 'Web Development',
                    child: Text('Web Development'),
                  ),
                  DropdownMenuItem(
                    value: 'Graph Theory',
                    child: Text('Graph Theory'),
                  ),
                  DropdownMenuItem(
                    value: 'Databases',
                    child: Text('Databases'),
                  ),
                  DropdownMenuItem(
                    value: 'Cloud Computing',
                    child: Text('Cloud Computing'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    selectedArea = value;
                  }
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: difficulty,
                decoration: const InputDecoration(
                  labelText: 'Difficulty',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Intermediate',
                    child: Text('Intermediate'),
                  ),
                  DropdownMenuItem(value: 'Hard', child: Text('Hard')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    difficulty = value;
                  }
                },
              ),
            ],
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
                final title = titleController.text.trim();
                final description = descriptionController.text.trim();
                final area = selectedArea;

                if (title.isEmpty) {
                  _showMessage('Project title cannot be empty.');
                  return;
                }

                if (description.isEmpty) {
                  _showMessage('Project description cannot be empty.');
                  return;
                }

                if (area.isEmpty) {
                  _showMessage('Project area cannot be empty.');
                  return;
                }

                final updatedProjects = List<ProjectIdea>.from(
                  widget.selectedStaff.projectIdeas,
                );

                updatedProjects.add(
                  ProjectIdea(
                    id: 'project-${DateTime.now().millisecondsSinceEpoch}',
                    title: title,
                    description: description,
                    area: area,
                    difficulty: difficulty,
                    availability: availability == 'Available',
                  ),
                );

                widget.onStaffUpdated(
                  widget.selectedStaff.copyWith(projectIdeas: updatedProjects),
                );

                Navigator.of(context).pop();
                _showMessage('Project idea added.');
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteProjectIdea(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete project idea'),
          content: const Text(
            'Are you sure you want to delete this project idea?',
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
                final updatedProjects = List<ProjectIdea>.from(
                  widget.selectedStaff.projectIdeas,
                );

                updatedProjects.removeAt(index);

                widget.onStaffUpdated(
                  widget.selectedStaff.copyWith(projectIdeas: updatedProjects),
                );

                Navigator.of(context).pop();
                _showMessage('Project idea deleted.');
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _editProjectIdea(int index) {
    final project = widget.selectedStaff.projectIdeas[index];

    final titleController = TextEditingController(text: project.title);
    final descriptionController = TextEditingController(
      text: project.description,
    );

    String selectedArea = project.area;
    String difficulty = project.difficulty;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit project idea'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Project title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Project description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: selectedArea,
                decoration: const InputDecoration(
                  labelText: 'Project area',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Machine Learning',
                    child: Text('Machine Learning'),
                  ),
                  DropdownMenuItem(
                    value: 'Data Analysis',
                    child: Text('Data Analysis'),
                  ),
                  DropdownMenuItem(
                    value: 'Software Testing',
                    child: Text('Software Testing'),
                  ),
                  DropdownMenuItem(
                    value: 'Web Development',
                    child: Text('Web Development'),
                  ),
                  DropdownMenuItem(
                    value: 'Graph Theory',
                    child: Text('Graph Theory'),
                  ),
                  DropdownMenuItem(
                    value: 'Databases',
                    child: Text('Databases'),
                  ),
                  DropdownMenuItem(
                    value: 'Cloud Computing',
                    child: Text('Cloud Computing'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    selectedArea = value;
                  }
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: difficulty,
                decoration: const InputDecoration(
                  labelText: 'Difficulty',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Intermediate',
                    child: Text('Intermediate'),
                  ),
                  DropdownMenuItem(value: 'Hard', child: Text('Hard')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    difficulty = value;
                  }
                },
              ),
            ],
          ),

          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: availability,
            decoration: const InputDecoration(
              labelText: 'Availability',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: 'Available',
                child: Text('Available'),
              ),
              DropdownMenuItem(
                value: 'Unavailable',
                child: Text('Unavailable'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                availability = value;
            }
          },
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
                final title = titleController.text.trim();
                final description = descriptionController.text.trim();

                if (title.isEmpty) {
                  _showMessage('Project title cannot be empty.');
                  return;
                }

                if (description.isEmpty) {
                  _showMessage('Project description cannot be empty.');
                  return;
                }

                final updatedProjects = List<ProjectIdea>.from(
                  widget.selectedStaff.projectIdeas,
                );

                updatedProjects[index] = project.copyWith(
                  title: title,
                  description: description,
                  area: selectedArea,
                  difficulty: difficulty,
                );

                widget.onStaffUpdated(
                  widget.selectedStaff.copyWith(projectIdeas: updatedProjects),
                );

                Navigator.of(context).pop();
                _showMessage('Project idea updated.');
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
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
                              trailing: Wrap(
                                spacing: 8,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _editSpecialisation(index);
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _deleteSpecialisation(index);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SectionCard(
                  title: 'Project Ideas',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilledButton.icon(
                        onPressed: _addProjectIdea,
                        icon: const Icon(Icons.add),
                        label: const Text('Add project idea'),
                      ),
                      const SizedBox(height: 12),
                      if (widget.selectedStaff.projectIdeas.isEmpty)
                        const Text('No project ideas have been added.')
                      else
                        ...widget.selectedStaff.projectIdeas
                            .asMap()
                            .entries
                            .map((entry) {
                              final index = entry.key;
                              final project = entry.value;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProjectIdeaCard(projectIdea: project),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Wrap(
                                      spacing: 8,
                                      children: [
                                        TextButton.icon(
                                          onPressed: () {
                                            _editProjectIdea(index);
                                          },
                                          icon: const Icon(Icons.edit),
                                          label: const Text('Edit project'),
                                        ),
                                        TextButton.icon(
                                          onPressed: () {
                                            _deleteProjectIdea(index);
                                          },
                                          icon: const Icon(Icons.delete),
                                          label: const Text('Delete project'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
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
