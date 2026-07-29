bool textContainsQuery(String text, String query) {
  final lowerCaseText = text.toLowerCase();
  final lowerCaseQuery = query.toLowerCase();
  return lowerCaseText.contains(lowerCaseQuery);
}
