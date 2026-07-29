import 'project_idea.dart';

class StaffMember {
  const StaffMember({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
    required this.biography,
    required this.specialisations,
    required this.projectIdeas,
    required this.acceptingStudents,
  });

  final String id;
  final String name;
  final String email;
  final String department;
  final String biography;
  final List<String> specialisations;
  final List<ProjectIdea> projectIdeas;
  final bool acceptingStudents;

  StaffMember copyWith({
    String? id,
    String? name,
    String? email,
    String? department,
    String? biography,
    List<String>? specialisations,
    List<ProjectIdea>? projectIdeas,
    bool? acceptingStudents,
  }) {
    return StaffMember(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      department: department ?? this.department,
      biography: biography ?? this.biography,
      specialisations: specialisations ?? this.specialisations,
      projectIdeas: projectIdeas ?? this.projectIdeas,
      acceptingStudents: acceptingStudents ?? this.acceptingStudents,
    );
  }
}
