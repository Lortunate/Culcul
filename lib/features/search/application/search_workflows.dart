String? normalizeSearchTerm(String rawTerm) {
  final normalizedTerm = rawTerm.trim();
  if (normalizedTerm.isEmpty) {
    return null;
  }
  return normalizedTerm;
}

List<String> addSearchHistoryEntry(
  List<String> currentHistory,
  String rawTerm, {
  int maxHistory = 15,
}) {
  final normalizedTerm = normalizeSearchTerm(rawTerm);
  if (normalizedTerm == null) {
    return List<String>.from(currentHistory);
  }

  final nextHistory = List<String>.from(currentHistory);
  nextHistory.remove(normalizedTerm);
  nextHistory.insert(0, normalizedTerm);
  if (nextHistory.length > maxHistory) {
    nextHistory.removeRange(maxHistory, nextHistory.length);
  }
  return nextHistory;
}
