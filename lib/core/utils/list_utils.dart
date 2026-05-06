class ListUtils {
  ListUtils._();

  /// Merges two lists, ensuring no duplicates based on an ID selector.
  /// New items are appended to the end.
  static List<T> mergeUnique<T>(
    List<T> current,
    List<T> newItems, {
    required Object? Function(T item) idGetter,
  }) {
    if (newItems.isEmpty) return current;
    if (current.isEmpty) return newItems;

    final existingIds = current.map(idGetter).toSet();
    final uniqueNewItems = newItems
        .where((item) => !existingIds.contains(idGetter(item)))
        .toList();

    return [...current, ...uniqueNewItems];
  }
}
