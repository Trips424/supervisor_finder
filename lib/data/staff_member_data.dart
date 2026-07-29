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
        id: 'project-4',
        title: 'Analyzing player statistics',
        description: 'A project focused on analyzing player statistics.',
        area: 'Data Analysis',
        difficulty: 'Intermediate',
        availability: true,
      ),
    ],
  ),

  const StaffMember(
    id: 'staff-2',
    name: 'Mr Mohamed Salah',
    email: 'mohamed.salah@port.ac.uk',
    department: 'School of Computing',
    biography: 'Researches software testing and web development.',
    specialisations: ['Software Testing', 'Web Development'],
    acceptingStudents: true,
    projectIdeas: [
      ProjectIdea(
        id: 'project-2',
        title: 'Automated testing dashboard',
        description: 'A dashboard that displays software test results.',
        area: 'Software Testing',
        difficulty: 'Intermediate',
        availability: true,
      ),
    ],
  ),

  const StaffMember(
    id: 'staff-3',
    name: 'Dr Cristiano Ronaldo',
    email: 'cristiano.ronaldo@port.ac.uk',
    department: 'School of Computing',
    biography: 'Specialises in artificial intelligence and robotics.',
    specialisations: ['Artificial Intelligence', 'Robotics'],
    acceptingStudents: true,
    projectIdeas: [
      ProjectIdea(
        id: 'project-3',
        title: 'Developing autonomous robots',
        description: 'A project focused on creating autonomous robots.',
        area: 'Robotics',
        difficulty: 'Advanced',
        availability: true,
      ),
    ],
  ),

  const StaffMember(
    id: 'staff-4',
    name: 'Dr Kyrie Irving',
    email: 'kyrie.irving@port.ac.uk',
    department: 'School of Computing',
    biography: 'Specialises in computer graphics and game development.',
    specialisations: ['Computer Graphics', 'Game Development'],
    acceptingStudents: true,
    projectIdeas: [
      ProjectIdea(
        id: 'project-5',
        title: 'Creating interactive 3D environments',
        description:
            'A project focused on developing interactive 3D environments.',
        area: 'Computer Graphics',
        difficulty: 'Intermediate',
        availability: true,
      ),
    ],
  ),

  const StaffMember(
    id: 'staff-5',
    name: 'Dr LeBron James',
    email: 'lebron.james@port.ac.uk',
    department: 'School of Computing',
    biography: 'Specialises in software engineering and distributed systems.',
    specialisations: ['Software Engineering', 'Distributed Systems'],
    acceptingStudents: true,
    projectIdeas: [
      ProjectIdea(
        id: 'project-6',
        title: 'Designing scalable web applications',
        description:
            'A project focused on designing scalable web applications.',
        area: 'Software Engineering',
        difficulty: 'Advanced',
        availability: true,
      ),
    ],
  ),

  const StaffMember(
    id: 'staff-6',
    name: 'Dr Tyrese Haliburton',
    email: 'tyrese.haliburton@port.ac.uk',
    department: 'School of Computing',
    biography: 'Specialises in data science and machine learning.',
    specialisations: ['Data Science', 'Machine Learning'],
    acceptingStudents: true,
    projectIdeas: [
      ProjectIdea(
        id: 'project-7',
        title: 'Developing predictive models',
        description: 'A project focused on developing predictive models.',
        area: 'Machine Learning',
        difficulty: 'Advanced',
        availability: true,
      ),
    ],
  ),
];
