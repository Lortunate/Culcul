import 'package:share_plus/share_plus.dart';

Future<void> shareUri(Uri uri) async {
  await SharePlus.instance.share(ShareParams(uri: uri));
}

Future<void> shareDynamic(String dynamicId, String content) async {
  final String url = 'https://t.bilibili.com/$dynamicId';
  await SharePlus.instance.share(ShareParams(text: '$content\n$url'));
}

Future<void> shareUser(String uid, String username) async {
  final String url = 'https://space.bilibili.com/$uid';
  await SharePlus.instance.share(
    ShareParams(text: 'Check out $username on Bilibili!\n$url', subject: username),
  );
}
