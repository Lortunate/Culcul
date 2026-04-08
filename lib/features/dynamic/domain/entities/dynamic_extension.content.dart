part of 'dynamic_extension.dart';

extension DynamicItemContentExtension on DynamicItem {
  String? get description => modules.moduleDynamic.desc?.text;

  String? get contentText {
    final descText = modules.moduleDynamic.desc?.text;
    if (descText != null && descText.isNotEmpty) return descText;

    final opusSummaryText = modules.moduleDynamic.major?.opus?.summary?.text;
    if (opusSummaryText != null && opusSummaryText.isNotEmpty) return opusSummaryText;

    final opusTitle = modules.moduleDynamic.major?.opus?.title;
    if (opusTitle != null && opusTitle.isNotEmpty) return opusTitle;

    return null;
  }

  List<String>? get images {
    if (isArticleType) return null;
    final dynamicModule = modules.moduleDynamic;
    final drawImages = dynamicModule.major?.draw?.items
        .map((e) => e.src.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    if (drawImages != null && drawImages.isNotEmpty) return drawImages;

    return dynamicModule.major?.opus?.pics
        ?.map((e) => e.url ?? '')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  DynamicVideoContent? get videoContent =>
      _dynamicMapVideoContent(modules.moduleDynamic.major);

  String? get topicName => modules.moduleDynamic.topic?.name;

  int? get topicId {
    final url = modules.moduleDynamic.topic?.jumpUrl;
    if (url == null) return null;
    try {
      final uri = Uri.parse(url);
      final topicIdStr = uri.queryParameters['topic_id'];
      if (topicIdStr != null) {
        return int.tryParse(topicIdStr);
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  DynamicLinkCard? get linkCard =>
      _dynamicMapLinkCard(item: this, major: modules.moduleDynamic.major);

  String? get commentId => basic?.commentIdStr;
  int? get commentType => basic?.commentType;

  DynamicAdditional? get additional =>
      _dynamicMapAdditional(modules.moduleDynamic.additional);
}
