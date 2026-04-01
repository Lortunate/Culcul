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
}
