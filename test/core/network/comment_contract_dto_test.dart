import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('comment contract parses API payload directly', () {
    final contract = CommentResponse.fromJson(<String, dynamic>{
      'replies': [
        <String, dynamic>{
          'rpid': 1,
          'oid': 2,
          'type': 1,
          'mid': 3,
          'root': 0,
          'parent': 0,
          'ctime': 123,
          'member': <String, dynamic>{
            'mid': '3',
            'uname': 'tester',
            'sex': '保密',
            'sign': '',
            'avatar': 'avatar',
            'rank': '10000',
            'level_info': <String, dynamic>{
              'current_level': 6,
              'current_min': 0,
              'current_exp': 1,
              'next_exp': 2,
            },
            'pendant': <String, dynamic>{'pid': 0, 'name': '', 'image': '', 'expire': 0},
            'nameplate': <String, dynamic>{
              'nid': 0,
              'name': '',
              'image': '',
              'image_small': '',
              'level': '',
              'condition': '',
            },
            'official_verify': <String, dynamic>{'type': -1, 'desc': ''},
            'vip': <String, dynamic>{},
          },
          'content': <String, dynamic>{'message': 'hello'},
        },
      ],
      'cursor': <String, dynamic>{
        'all_count': 10,
        'is_begin': false,
        'is_end': true,
        'name': 'hot',
      },
      'page': <String, dynamic>{'num': 1, 'size': 20, 'count': 10, 'acount': 10},
    });

    expect(contract.replies.single.content.message, 'hello');
    expect(contract.cursor?.allCount, 10);
    expect(contract.page?.count, 10);
  });
}
