
import 'package:share_plus/share_plus.dart';

class ShareUtils {
  static Future<void> shareText(String text, {String? subject}) async {
    await Share.share(text, subject: subject);
  }

  static Future<void> shareUri(Uri uri) async {
    await Share.shareUri(uri);
  }

  static Future<void> shareVideo(String bvid, String title, String coverUrl) async {
    final String url = 'https://www.bilibili.com/video/$bvid';
    await Share.share('$title\n$url', subject: title);
  }

  static Future<void> shareDynamic(String dynamicId, String content) async {
    final String url = 'https://t.bilibili.com/$dynamicId';
    await Share.share('$content\n$url');
  }
}
