class SearchSubmission {
  const SearchSubmission(this.term);

  final String term;
}

SearchSubmission? prepareSearchSubmission(String rawTerm) {
  final normalizedTerm = rawTerm.trim();
  if (normalizedTerm.isEmpty) {
    return null;
  }
  return SearchSubmission(normalizedTerm);
}

List<String> addSearchHistoryEntry(
  List<String> currentHistory,
  String rawTerm, {
  int maxHistory = 15,
}) {
  final submission = prepareSearchSubmission(rawTerm);
  if (submission == null) {
    return List<String>.from(currentHistory);
  }

  final nextHistory = List<String>.from(currentHistory);
  nextHistory.remove(submission.term);
  nextHistory.insert(0, submission.term);
  if (nextHistory.length > maxHistory) {
    nextHistory.removeRange(maxHistory, nextHistory.length);
  }
  return nextHistory;
}

List<String> removeSearchHistoryEntry(List<String> currentHistory, String rawTerm) {
  final normalizedTerm = rawTerm.trim();
  if (normalizedTerm.isEmpty) {
    return List<String>.from(currentHistory);
  }
  return currentHistory.where((term) => term != normalizedTerm).toList();
}
