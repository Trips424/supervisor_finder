import '../models/staff_member.dart';

bool textContainsQuery(String text, String query) {
  final lowerCaseText = text.toLowerCase();
  final lowerCaseQuery = query.toLowerCase();
  return lowerCaseText.contains(lowerCaseQuery);
}

bool staffMemberMatchesQuery(StaffMember staff, String query) {
  final cleanQuery = query.trim();

  if (cleanQuery.isEmpty) {
    return true;
  }

  return textContainsQuery(staff.name, cleanQuery) ||
      textContainsQuery(staff.email, cleanQuery) ||
      textContainsQuery(staff.department, cleanQuery) ||
      textContainsQuery(staff.biography, cleanQuery) ||
      staff.specialisations.any(
        (specialisation) => textContainsQuery(specialisation, cleanQuery),
      ) ||
      staff.projectIdeas.any(
        (projectIdea) =>
            textContainsQuery(projectIdea.title, cleanQuery) ||
            textContainsQuery(projectIdea.description, cleanQuery),
      );
}
