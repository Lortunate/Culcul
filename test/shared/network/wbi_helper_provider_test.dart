import 'package:culcul/shared/network/resource_api.dart';
import 'package:culcul/shared/network/providers/wbi_helper_provider.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeResourceApi implements ResourceApi {
  @override
  Future<dynamic> fetchNav() async {
    return {
      'code': 0,
      'data': {
        'wbi_img': {
          'img_url':
              'https://i0.hdslb.com/bfs/wbi/abcdefghijklmnopqrstuvwxyz123456.png',
          'sub_url':
              'https://i0.hdslb.com/bfs/wbi/0123456789abcdef0123456789abcdef.png',
        },
      },
    };
  }

  @override
  Future<List<int>> fetchBytes(String url) async {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> fetchJson(String url) async {
    throw UnimplementedError();
  }
}

void main() {
  test('WBI helper strips reserved characters and appends signing fields', () async {
    final helper = WbiHelper(_FakeResourceApi());

    await helper.updateKeys();
    final signed = helper.sign({
      'foo': "a!b'c(d)*",
      'bar': 1,
    });

    expect(signed['foo'], 'abcd');
    expect(signed['bar'], '1');
    expect(signed['wts'], isA<String>());
    expect((signed['w_rid'] as String).length, 32);
  });
}
