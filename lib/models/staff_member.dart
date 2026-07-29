import 'project_idea.dart';

class StaffMember {
  const StaffMember({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
    required this.subjects,
    required this.projectIdeas,
    required this.acceptedStudents,
  });

  final String id;
  final String name;
  final String email;
  final String department;
  final List<String> subjects;
  final List<ProjectIdea> projectIdeas;
  final List<Student> acceptedStudents;
}
