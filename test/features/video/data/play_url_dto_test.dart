import 'package:culcul/features/video/data/dtos/play_url_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Durl parses backup_url into backupUrl', () {
    final json = <String, dynamic>{
      'order': 1,
      'length': 120000,
      'size': 1024,
      'url': 'https://upos-sz-mirrorcos.bilivideo.com/test.flv',
      'backup_url': <String>[
        'https://upos-sz-mirrorks3.bilivideo.com/test.flv',
        'https://upos-sz-mirrorali.bilivideo.com/test.flv',
      ],
    };

    final durl = Durl.fromJson(json);

    expect(durl.backupUrl, hasLength(2));
    expect(durl.backupUrl.first, contains('mirrorks3'));
    expect(durl.backupUrl.last, contains('mirrorali'));
  });

  test('Dash audio parses mixed baseUrl and backup_url aliases', () {
    final json = <String, dynamic>{
      'format': 'dash',
      'quality': 80,
      'timelength': 30000,
      'accept_format': 'dash',
      'accept_description': <String>['1080P'],
      'accept_quality': <int>[80],
      'video_codecid': 7,
      'durl': <Map<String, dynamic>>[],
      'dash': <String, dynamic>{
        'audio': <Map<String, dynamic>>[
          <String, dynamic>{
            'id': 30280,
            'base_url': '//upos-sz-mirrorali.bilivideo.com/audio-main.m4s',
            'backupUrl': <String>['//upos-sz-mirrorks3.bilivideo.com/audio-backup-1.m4s'],
            'bandwidth': 192000,
          },
          <String, dynamic>{
            'id': 30232,
            'baseUrl': '//upos-sz-mirrorcos.bilivideo.com/audio-low.m4s',
            'backup_url': <String>['//upos-sz-mirrorhw.bilivideo.com/audio-backup-2.m4s'],
            'bandwidth': 128000,
          },
        ],
      },
    };

    final playUrl = PlayUrl.fromJson(json);

    expect(playUrl.dash, isNotNull);
    expect(playUrl.dash!.audio, hasLength(2));
    expect(playUrl.dash!.audio.first.baseUrl, contains('audio-main.m4s'));
    expect(playUrl.dash!.audio.first.backupUrl.single, contains('audio-backup-1.m4s'));
    expect(playUrl.dash!.audio.last.baseUrl, contains('audio-low.m4s'));
    expect(playUrl.dash!.audio.last.backupUrl.single, contains('audio-backup-2.m4s'));
  });
}
