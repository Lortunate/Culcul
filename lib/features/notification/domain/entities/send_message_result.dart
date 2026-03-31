class SendMessageResult {
  final int msgKey;
  final String? msgContent;
  final Map<String, dynamic>? keyHitInfos;

  const SendMessageResult({required this.msgKey, this.msgContent, this.keyHitInfos});
}
