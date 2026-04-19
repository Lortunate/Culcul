typedef ToggleDynamicDetailLike = Future<String?> Function();
typedef AddDynamicDetailReply = Future<void> Function(int root, int parent, String text);

class DynamicDetailActions {
  DynamicDetailActions({required this.toggleLike, required this.addReply});

  final ToggleDynamicDetailLike toggleLike;
  final AddDynamicDetailReply addReply;

  Future<String?> handleLike() => toggleLike();

  Future<bool> submitComment(String rawText) async {
    final text = rawText.trim();
    if (text.isEmpty) {
      return false;
    }

    await addReply(0, 0, text);
    return true;
  }
}
