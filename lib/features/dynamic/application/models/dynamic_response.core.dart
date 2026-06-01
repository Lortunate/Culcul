part of 'dynamic_response.dart';

final class DynamicData {
  DynamicData({
    required this.hasMore,
    required List<DynamicItem> items,
    required this.offset,
    required this.updateBaseline,
    required this.updateNum,
  }) : items = List.unmodifiable(items);

  factory DynamicData.fromJson(Map<String, dynamic> json) {
    return DynamicData(
      hasMore: json['has_more'] as bool,
      items: (json['items'] as List<dynamic>)
          .map((item) => DynamicItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      offset: JsonUtils.parseStringWithDefault(json['offset']),
      updateBaseline: JsonUtils.parseStringWithDefault(json['update_baseline']),
      updateNum: JsonUtils.parseIntWithDefault(json['update_num']),
    );
  }

  final bool hasMore;
  final List<DynamicItem> items;
  final String offset;
  final String updateBaseline;
  final int updateNum;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DynamicData &&
            other.hasMore == hasMore &&
            listEquals(other.items, items) &&
            other.offset == offset &&
            other.updateBaseline == updateBaseline &&
            other.updateNum == updateNum;
  }

  @override
  int get hashCode =>
      Object.hash(hasMore, Object.hashAll(items), offset, updateBaseline, updateNum);

  @override
  String toString() {
    return 'DynamicData('
        'hasMore: $hasMore, '
        'items: $items, '
        'offset: $offset, '
        'updateBaseline: $updateBaseline, '
        'updateNum: $updateNum'
        ')';
  }
}

final class DynamicItem {
  static const Object _nullableSentinel = Object();

  const DynamicItem({
    required this.idStr,
    required this.type,
    required this.visible,
    required this.modules,
    this.orig,
    this.basic,
  });

  factory DynamicItem.fromJson(Map<String, dynamic> json) {
    return DynamicItem(
      idStr: JsonUtils.parseStringWithDefault(json['id_str']),
      type: JsonUtils.parseStringWithDefault(json['type']),
      visible: json['visible'] as bool,
      modules: DynamicModules.fromJson(json['modules'] as Map<String, dynamic>),
      orig: json['orig'] == null
          ? null
          : DynamicItem.fromJson(json['orig'] as Map<String, dynamic>),
      basic: json['basic'] == null
          ? null
          : DynamicBasic.fromJson(json['basic'] as Map<String, dynamic>),
    );
  }

  final String idStr;
  final String type;
  final bool visible;
  final DynamicModules modules;
  final DynamicItem? orig;
  final DynamicBasic? basic;

  DynamicItem copyWith({
    String? idStr,
    String? type,
    bool? visible,
    DynamicModules? modules,
    Object? orig = _nullableSentinel,
    Object? basic = _nullableSentinel,
  }) {
    return DynamicItem(
      idStr: idStr ?? this.idStr,
      type: type ?? this.type,
      visible: visible ?? this.visible,
      modules: modules ?? this.modules,
      orig: identical(orig, _nullableSentinel) ? this.orig : orig as DynamicItem?,
      basic: identical(basic, _nullableSentinel) ? this.basic : basic as DynamicBasic?,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DynamicItem &&
            other.idStr == idStr &&
            other.type == type &&
            other.visible == visible &&
            other.modules == modules &&
            other.orig == orig &&
            other.basic == basic;
  }

  @override
  int get hashCode => Object.hash(idStr, type, visible, modules, orig, basic);

  @override
  String toString() {
    return 'DynamicItem('
        'idStr: $idStr, '
        'type: $type, '
        'visible: $visible, '
        'modules: $modules, '
        'orig: $orig, '
        'basic: $basic'
        ')';
  }
}

final class DynamicBasic {
  const DynamicBasic({
    required this.commentIdStr,
    required this.commentType,
    required this.ridStr,
  });

  factory DynamicBasic.fromJson(Map<String, dynamic> json) {
    return DynamicBasic(
      commentIdStr: JsonUtils.parseStringWithDefault(json['comment_id_str']),
      commentType: (json['comment_type'] as num).toInt(),
      ridStr: JsonUtils.parseStringWithDefault(json['rid_str']),
    );
  }

  final String commentIdStr;
  final int commentType;
  final String ridStr;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DynamicBasic &&
            other.commentIdStr == commentIdStr &&
            other.commentType == commentType &&
            other.ridStr == ridStr;
  }

  @override
  int get hashCode => Object.hash(commentIdStr, commentType, ridStr);

  @override
  String toString() {
    return 'DynamicBasic('
        'commentIdStr: $commentIdStr, '
        'commentType: $commentType, '
        'ridStr: $ridStr'
        ')';
  }
}

final class DynamicModules {
  static const Object _moduleStatSentinel = Object();

  const DynamicModules({
    required this.moduleAuthor,
    required this.moduleDynamic,
    this.moduleStat,
  });

  factory DynamicModules.fromJson(Map<String, dynamic> json) {
    return DynamicModules(
      moduleAuthor: ModuleAuthor.fromJson(json['module_author'] as Map<String, dynamic>),
      moduleDynamic: ModuleDynamic.fromJson(
        json['module_dynamic'] as Map<String, dynamic>,
      ),
      moduleStat: json['module_stat'] == null
          ? null
          : ModuleStat.fromJson(json['module_stat'] as Map<String, dynamic>),
    );
  }

  final ModuleAuthor moduleAuthor;
  final ModuleDynamic moduleDynamic;
  final ModuleStat? moduleStat;

  DynamicModules copyWith({
    ModuleAuthor? moduleAuthor,
    ModuleDynamic? moduleDynamic,
    Object? moduleStat = _moduleStatSentinel,
  }) {
    return DynamicModules(
      moduleAuthor: moduleAuthor ?? this.moduleAuthor,
      moduleDynamic: moduleDynamic ?? this.moduleDynamic,
      moduleStat: identical(moduleStat, _moduleStatSentinel)
          ? this.moduleStat
          : moduleStat as ModuleStat?,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DynamicModules &&
            other.moduleAuthor == moduleAuthor &&
            other.moduleDynamic == moduleDynamic &&
            other.moduleStat == moduleStat;
  }

  @override
  int get hashCode => Object.hash(moduleAuthor, moduleDynamic, moduleStat);

  @override
  String toString() {
    return 'DynamicModules('
        'moduleAuthor: $moduleAuthor, '
        'moduleDynamic: $moduleDynamic, '
        'moduleStat: $moduleStat'
        ')';
  }
}

final class ModuleAuthor {
  const ModuleAuthor({
    required this.mid,
    required this.name,
    required this.avatar,
    required this.pubTime,
    required this.pubAction,
  });

  factory ModuleAuthor.fromJson(Map<String, dynamic> json) {
    return ModuleAuthor(
      mid: (json['mid'] as num).toInt(),
      name: JsonUtils.parseStringWithDefault(json['name']),
      avatar: JsonUtils.parseStringWithDefault(json['face']),
      pubTime: JsonUtils.parseStringWithDefault(json['pub_time']),
      pubAction: JsonUtils.parseStringWithDefault(json['pub_action']),
    );
  }

  final int mid;
  final String name;
  final String avatar;
  final String pubTime;
  final String pubAction;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ModuleAuthor &&
            other.mid == mid &&
            other.name == name &&
            other.avatar == avatar &&
            other.pubTime == pubTime &&
            other.pubAction == pubAction;
  }

  @override
  int get hashCode => Object.hash(mid, name, avatar, pubTime, pubAction);

  @override
  String toString() {
    return 'ModuleAuthor('
        'mid: $mid, '
        'name: $name, '
        'avatar: $avatar, '
        'pubTime: $pubTime, '
        'pubAction: $pubAction'
        ')';
  }
}

final class ModuleDynamic {
  const ModuleDynamic({this.desc, this.major, this.topic, this.additional});

  factory ModuleDynamic.fromJson(Map<String, dynamic> json) {
    return ModuleDynamic(
      desc: json['desc'] == null
          ? null
          : ModuleDesc.fromJson(json['desc'] as Map<String, dynamic>),
      major: json['major'] == null
          ? null
          : ModuleMajor.fromJson(json['major'] as Map<String, dynamic>),
      topic: json['topic'] == null
          ? null
          : ModuleTopic.fromJson(json['topic'] as Map<String, dynamic>),
      additional: json['additional'] == null
          ? null
          : ModuleAdditional.fromJson(json['additional'] as Map<String, dynamic>),
    );
  }

  final ModuleDesc? desc;
  final ModuleMajor? major;
  final ModuleTopic? topic;
  final ModuleAdditional? additional;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ModuleDynamic &&
            other.desc == desc &&
            other.major == major &&
            other.topic == topic &&
            other.additional == additional;
  }

  @override
  int get hashCode => Object.hash(desc, major, topic, additional);

  @override
  String toString() {
    return 'ModuleDynamic('
        'desc: $desc, '
        'major: $major, '
        'topic: $topic, '
        'additional: $additional'
        ')';
  }
}
