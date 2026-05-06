import 'package:share_plus/share_plus.dart';

class ShareUtils {
  static Future<void> shareText(String text, {String? subject}) async {
    await SharePlus.instance.share(ShareParams(text: text, subject: subject));
  }

  static Future<void> shareUri(Uri uri) async {
    await SharePlus.instance.share(ShareParams(uri: uri));
  }

  static Future<void> shareVideo(String bvid, String title, String coverUrl) async {
    final String url = 'https://www.bilibili.com/video/$bvid';
    await SharePlus.instance.share(ShareParams(text: '$title\n$url', subject: title));
  }

  static Future<void> shareDynamic(String dynamicId, String content) async {
    final String url = 'https://t.bilibili.com/$dynamicId';
    await SharePlus.instance.share(ShareParams(text: '$content\n$url'));
  }

  static Future<void> shareUser(String uid, String username) async {
    final String url = 'https://space.bilibili.com/$uid';
    await SharePlus.instance.share(
      ShareParams(text: 'Check out $username on Bilibili!\n$url', subject: username),
    );
  }
}
