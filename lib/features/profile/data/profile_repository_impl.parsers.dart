part of 'profile_repository_impl.dart';

extension _ProfileRepositoryParsers on ProfileRepositoryImpl {
  UserCardModel _parseUserCard(dynamic data, {required int fallbackMid}) {
    try {
      final map = Map<String, dynamic>.from(data as Map);
      final card = Map<String, dynamic>.from(map['card'] as Map? ?? const {});
      final following = map['following'] as bool? ?? false;

      return UserCardModel(
        mid: card['mid']?.toString() ?? fallbackMid.toString(),
        name: card['name']?.toString() ?? '',
        face: card['face']?.toString() ?? '',
        isFollowed: following,
      );
    } catch (error) {
      throw AppError.unknown('Failed to parse user card', cause: error);
    }
  }

  ({int followers, int following}) _parseRelationStats(dynamic response) {
    if (response == null ||
        response.code != 0 ||
        response.data is! Map<String, dynamic>) {
      return (followers: 0, following: 0);
    }

    final data = response.data as Map<String, dynamic>;
    return (
      followers: data['follower'] as int? ?? 0,
      following: data['following'] as int? ?? 0,
    );
  }

  int _parseLikes(dynamic response) {
    if (response == null ||
        response.code != 0 ||
        response.data is! Map<String, dynamic>) {
      return 0;
    }
    final data = response.data as Map<String, dynamic>;
    return data['likes'] as int? ?? 0;
  }

  int _parseVideoCount(dynamic response) {
    if (response == null ||
        response.code != 0 ||
        response.data is! Map<String, dynamic>) {
      return 0;
    }
    final data = response.data as Map<String, dynamic>;
    return data['video'] as int? ?? 0;
  }

  bool _isVerified(Map<String, dynamic> infoData) {
    final official = infoData['official'];
    if (official is! Map<String, dynamic>) {
      return false;
    }
    return (official['role'] as int? ?? 0) != 0;
  }

  int _parseVipType(Map<String, dynamic> infoData) {
    final vipInfo = infoData['vip'];
    return vipInfo is Map<String, dynamic> ? vipInfo['type'] as int? ?? 0 : 0;
  }

  int _parseVipStatus(Map<String, dynamic> infoData) {
    final vipInfo = infoData['vip'];
    return vipInfo is Map<String, dynamic> ? vipInfo['status'] as int? ?? 0 : 0;
  }

  String? _resolveBanner(Map<String, dynamic> infoData, dynamic cardResponse) {
    final topPhoto = infoData['top_photo'] as String?;
    if (cardResponse == null ||
        cardResponse.code != 0 ||
        cardResponse.data is! Map<String, dynamic>) {
      return topPhoto;
    }

    final data = cardResponse.data as Map<String, dynamic>;
    final space = data['space'];
    if (space is! Map<String, dynamic>) {
      return topPhoto;
    }

    final large = space['l_img'] as String?;
    if (large != null && large.isNotEmpty) {
      return large;
    }

    final small = space['s_img'] as String?;
    if (small != null && small.isNotEmpty) {
      return small;
    }

    return topPhoto;
  }
}
