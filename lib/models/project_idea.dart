class ProjectIdea {
  const ProjectIdea({
    required this.id,
    required this.title,
    required this.description,
    required this.area,
    required this.difficulty,
    required this.availability,
  });

  final String id;
  final String title;
  final String description;
  final String area;
  final String difficulty;
  final bool availability;

  ProjectIdea copyWith({
    String? id,
    String? title,
    String? description,
    String? area,
    String? difficulty,
    bool? availability,
  }) {
    return ProjectIdea(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      area: area ?? this.area,
      difficulty: difficulty ?? this.difficulty,
      availability: availability ?? this.availability,
    );
  }
}
