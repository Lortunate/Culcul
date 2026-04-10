import 'package:dio/dio.dart';

class RequestCancelToken {
  RequestCancelToken() : _dioToken = CancelToken();

  final CancelToken _dioToken;

  CancelToken get dioToken => _dioToken;
  bool get isCancelled => _dioToken.isCancelled;

  void cancel([String? reason]) {
    if (_dioToken.isCancelled) {
      return;
    }
    _dioToken.cancel(reason);
  }
}
