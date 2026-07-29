import '../models/project_idea.dart';
import '../models/staff_member.dart';

final List<StaffMember> sampleStaffMembers = [
  const StaffMember(
    id: 'staff-1',
    name: 'Dr Wayne Rooney',
    email: 'wayne.rooney@port.ac.uk',
    department: 'School of Computing',
    biography: 'Specialises in machine learning and data analysis.',
    specialisations: ['Machine Learning', 'Data Analysis'],
    acceptingStudents: true,
    projectIdeas: [
      ProjectIdea(
        id: 'project-1',
        title: 'Predicting football match outcomes',
        description: 'A project using data to predict football results.',
        area: 'Machine Learning',
        difficulty: 'Advanced',
        availability: true,
      ),
      ProjectIdea(
        id: 'project-2',
        title: 'Analyzing player performance data',
        description: 'A project focused on analyzing player statistics.',
        area: 'Data Analysis',
        difficulty: 'Intermediate',
        availability: true,
      ),
    ],
  ),
];
