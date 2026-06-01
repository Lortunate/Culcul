import 'package:flutter/foundation.dart' show listEquals;

final class LiveDanmuInfoModel {
  LiveDanmuInfoModel({required this.token, List<LiveDanmuHost> hostList = const []})
    : hostList = List<LiveDanmuHost>.unmodifiable(hostList);

  factory LiveDanmuInfoModel.fromJson(Map<String, dynamic> json) {
    return LiveDanmuInfoModel(
      token: json['token'] as String,
      hostList:
          (json['host_list'] as List<dynamic>?)
              ?.map((e) => LiveDanmuHost.fromJson(e as Map<String, dynamic>))
              .toList(growable: false) ??
          const [],
    );
  }

  final String token;
  final List<LiveDanmuHost> hostList;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveDanmuInfoModel &&
            runtimeType == other.runtimeType &&
            token == other.token &&
            listEquals(hostList, other.hostList);
  }

  @override
  int get hashCode => Object.hash(runtimeType, token, Object.hashAll(hostList));

  @override
  String toString() {
    return 'LiveDanmuInfoModel(token: $token, hostList: $hostList)';
  }
}

final class LiveDanmuHost {
  const LiveDanmuHost({required this.host, required this.wssPort, required this.wsPort});

  factory LiveDanmuHost.fromJson(Map<String, dynamic> json) {
    return LiveDanmuHost(
      host: json['host'] as String,
      wssPort: (json['wss_port'] as num).toInt(),
      wsPort: (json['ws_port'] as num).toInt(),
    );
  }

  final String host;
  final int wssPort;
  final int wsPort;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LiveDanmuHost &&
            runtimeType == other.runtimeType &&
            host == other.host &&
            wssPort == other.wssPort &&
            wsPort == other.wsPort;
  }

  @override
  int get hashCode => Object.hash(runtimeType, host, wssPort, wsPort);

  @override
  String toString() {
    return 'LiveDanmuHost(host: $host, wssPort: $wssPort, wsPort: $wsPort)';
  }
}
