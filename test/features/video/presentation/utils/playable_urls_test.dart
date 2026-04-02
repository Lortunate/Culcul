import 'package:culcul/features/video/domain/entities/play_url.dart' as domain;
import 'package:culcul/features/video/presentation/utils/playable_urls.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('buildAudioPlayableUrlsFromDash sorts by bandwidth and normalizes urls', () {
    final dash = domain.DashInfo(
      audio: [
        domain.DashStream(
          id: 30232,
          baseUrl: 'http://upos-sz-mirrorali.bilivideo.com/low.m4s',
          backupUrl: ['//upos-sz-mirrorhw.bilivideo.com/low-backup.m4s'],
          bandwidth: 128000,
        ),
        domain.DashStream(
          id: 30280,
          baseUrl: '//upos-sz-mirrorks3.bilivideo.com/high.m4s',
          backupUrl: ['https://upos-sz-mirrorcos.bilivideo.com/high-backup.m4s'],
          bandwidth: 192000,
        ),
      ],
    );

    final urls = buildAudioPlayableUrlsFromDash(dash);

    expect(urls, hasLength(4));
    expect(urls[0], contains('high.m4s'));
    expect(urls[1], contains('high-backup.m4s'));
    expect(urls[2], startsWith('https://'));
    expect(urls[2], contains('low.m4s'));
  });

  test(
    'buildListenAudioCandidateUrls falls back to durl when dash audio unavailable',
    () {
      final durl = domain.Durl(
        order: 1,
        length: 120000,
        size: 100,
        url: '//upos-sz-mirrorali.bilivideo.com/video.flv',
        backupUrl: ['http://upos-sz-mirrorhw.bilivideo.com/video-backup.flv'],
      );

      final urls = buildListenAudioCandidateUrls(
        dash: const domain.DashInfo(audio: []),
        fallbackDurl: durl,
      );

      expect(urls, hasLength(2));
      expect(urls.first, contains('video.flv'));
      expect(urls.last, startsWith('https://'));
    },
  );
}
