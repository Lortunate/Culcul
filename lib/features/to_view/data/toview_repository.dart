import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/providers/api_provider.dart';
import 'package:culcul/core/base_repository.dart';
import 'package:culcul/data/api/toview_api.dart';
import 'package:culcul/data/models/toview/to_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'toview_repository.g.dart';

@riverpod
ToViewRepository toViewRepository(Ref ref) {
  return ToViewRepository(ref.watch(toViewApiProvider));
}

class ToViewRepository extends BaseRepository {
  final ToViewApi _api;

  ToViewRepository(this._api);

  Future<ToViewListResponse> getToViewList() async {
    try {
      return await requestApi(() => _api.getToViewList());
    } on ServerException catch (e) {
      if (e.code == 0 && e.message == 'No Data') {
        return ToViewListResponse(count: 0, list: []);
      }
      rethrow;
    }
  }

  Future<void> addToView({required int aid}) {
    return request(() => _api.addToView(aid));
  }

  Future<void> deleteToView({required int aid}) {
    return request(() => _api.deleteToView(aid));
  }

  Future<void> clearToView() {
    return request(() => _api.clearToView());
  }
}
