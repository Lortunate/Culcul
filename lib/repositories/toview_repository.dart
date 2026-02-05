import 'package:culcul/data/api/toview_api.dart';
import 'package:culcul/data/models/toview/to_view_model.dart';

class ToViewRepository {
  final ToViewApi _api;

  ToViewRepository(this._api);

  Future<ToViewListResponse> getToViewList() async {
    final response = await _api.getToViewList();
    return response.data ?? ToViewListResponse(count: 0, list: []);
  }

  Future<void> addToView({required int aid}) {
    return _api.addToView(aid);
  }

  Future<void> deleteToView({required int aid}) {
    return _api.deleteToView(aid);
  }

  Future<void> clearToView() {
    return _api.clearToView();
  }
}
