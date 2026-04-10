import 'package:culcul/shared/pagination/paged_list_state.dart';
import 'package:culcul/features/dynamic/presentation/view_models/dynamic_comment_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DynamicCommentState keeps comment errors in paging.error', () {
    final error = Exception('comment load failed');
    final state = DynamicCommentState(paging: PagedListState(error: error));

    expect(state.paging.error, same(error));
  });
}
