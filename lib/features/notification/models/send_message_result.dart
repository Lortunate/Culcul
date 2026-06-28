class SendMessageResult {
  SendMessageResult({
    required this.msgKey,
    this.msgContent,
    Map<String, dynamic>? keyHitInfos,
  }) : _keyHitInfos = keyHitInfos == null ? null : Map.unmodifiable(keyHitInfos);

  final int msgKey;
  final String? msgContent;
  final Map<String, dynamic>? _keyHitInfos;

  Map<String, dynamic>? get keyHitInfos => _keyHitInfos;

  @override
  String toString() {
    return 'SendMessageResult(msgKey: $msgKey, msgContent: $msgContent, '
        'keyHitInfos: $keyHitInfos)';
  }
}
