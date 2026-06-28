import 'package:share_plus/share_plus.dart';

Future<void> shareDynamicItem({
  required String dynamicId,
  required String content,
}) async {
  final url = 'https://t.bilibili.com/$dynamicId';
  await SharePlus.instance.share(ShareParams(text: '$content\n$url'));
}
