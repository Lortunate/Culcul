// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_local_database.dart';

// ignore_for_file: type=lint
class $NotificationMessagesTable extends NotificationMessages
    with TableInfo<$NotificationMessagesTable, NotificationMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ownerUidMeta = const VerificationMeta('ownerUid');
  @override
  late final GeneratedColumn<int> ownerUid = GeneratedColumn<int>(
    'owner_uid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionTypeMeta = const VerificationMeta('sessionType');
  @override
  late final GeneratedColumn<int> sessionType = GeneratedColumn<int>(
    'session_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _talkerIdMeta = const VerificationMeta('talkerId');
  @override
  late final GeneratedColumn<int> talkerId = GeneratedColumn<int>(
    'talker_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _msgSeqnoMeta = const VerificationMeta('msgSeqno');
  @override
  late final GeneratedColumn<int> msgSeqno = GeneratedColumn<int>(
    'msg_seqno',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderUidMeta = const VerificationMeta('senderUid');
  @override
  late final GeneratedColumn<int> senderUid = GeneratedColumn<int>(
    'sender_uid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receiverTypeMeta = const VerificationMeta(
    'receiverType',
  );
  @override
  late final GeneratedColumn<int> receiverType = GeneratedColumn<int>(
    'receiver_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receiverIdMeta = const VerificationMeta('receiverId');
  @override
  late final GeneratedColumn<int> receiverId = GeneratedColumn<int>(
    'receiver_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _msgTypeMeta = const VerificationMeta('msgType');
  @override
  late final GeneratedColumn<int> msgType = GeneratedColumn<int>(
    'msg_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentJsonMeta = const VerificationMeta('contentJson');
  @override
  late final GeneratedColumn<String> contentJson = GeneratedColumn<String>(
    'content_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<int> timestamp = GeneratedColumn<int>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _atUidsJsonMeta = const VerificationMeta('atUidsJson');
  @override
  late final GeneratedColumn<String> atUidsJson = GeneratedColumn<String>(
    'at_uids_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _msgKeyMeta = const VerificationMeta('msgKey');
  @override
  late final GeneratedColumn<int> msgKey = GeneratedColumn<int>(
    'msg_key',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _msgStatusMeta = const VerificationMeta('msgStatus');
  @override
  late final GeneratedColumn<int> msgStatus = GeneratedColumn<int>(
    'msg_status',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notifyCodeMeta = const VerificationMeta('notifyCode');
  @override
  late final GeneratedColumn<String> notifyCode = GeneratedColumn<String>(
    'notify_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _newFaceVersionMeta = const VerificationMeta(
    'newFaceVersion',
  );
  @override
  late final GeneratedColumn<int> newFaceVersion = GeneratedColumn<int>(
    'new_face_version',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _msgSourceMeta = const VerificationMeta('msgSource');
  @override
  late final GeneratedColumn<int> msgSource = GeneratedColumn<int>(
    'msg_source',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    ownerUid,
    sessionType,
    talkerId,
    msgSeqno,
    senderUid,
    receiverType,
    receiverId,
    msgType,
    contentJson,
    timestamp,
    atUidsJson,
    msgKey,
    msgStatus,
    notifyCode,
    newFaceVersion,
    msgSource,
    syncStatus,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationMessage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('owner_uid')) {
      context.handle(
        _ownerUidMeta,
        ownerUid.isAcceptableOrUnknown(data['owner_uid']!, _ownerUidMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerUidMeta);
    }
    if (data.containsKey('session_type')) {
      context.handle(
        _sessionTypeMeta,
        sessionType.isAcceptableOrUnknown(data['session_type']!, _sessionTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionTypeMeta);
    }
    if (data.containsKey('talker_id')) {
      context.handle(
        _talkerIdMeta,
        talkerId.isAcceptableOrUnknown(data['talker_id']!, _talkerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_talkerIdMeta);
    }
    if (data.containsKey('msg_seqno')) {
      context.handle(
        _msgSeqnoMeta,
        msgSeqno.isAcceptableOrUnknown(data['msg_seqno']!, _msgSeqnoMeta),
      );
    } else if (isInserting) {
      context.missing(_msgSeqnoMeta);
    }
    if (data.containsKey('sender_uid')) {
      context.handle(
        _senderUidMeta,
        senderUid.isAcceptableOrUnknown(data['sender_uid']!, _senderUidMeta),
      );
    } else if (isInserting) {
      context.missing(_senderUidMeta);
    }
    if (data.containsKey('receiver_type')) {
      context.handle(
        _receiverTypeMeta,
        receiverType.isAcceptableOrUnknown(data['receiver_type']!, _receiverTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_receiverTypeMeta);
    }
    if (data.containsKey('receiver_id')) {
      context.handle(
        _receiverIdMeta,
        receiverId.isAcceptableOrUnknown(data['receiver_id']!, _receiverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_receiverIdMeta);
    }
    if (data.containsKey('msg_type')) {
      context.handle(
        _msgTypeMeta,
        msgType.isAcceptableOrUnknown(data['msg_type']!, _msgTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_msgTypeMeta);
    }
    if (data.containsKey('content_json')) {
      context.handle(
        _contentJsonMeta,
        contentJson.isAcceptableOrUnknown(data['content_json']!, _contentJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_contentJsonMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('at_uids_json')) {
      context.handle(
        _atUidsJsonMeta,
        atUidsJson.isAcceptableOrUnknown(data['at_uids_json']!, _atUidsJsonMeta),
      );
    }
    if (data.containsKey('msg_key')) {
      context.handle(
        _msgKeyMeta,
        msgKey.isAcceptableOrUnknown(data['msg_key']!, _msgKeyMeta),
      );
    }
    if (data.containsKey('msg_status')) {
      context.handle(
        _msgStatusMeta,
        msgStatus.isAcceptableOrUnknown(data['msg_status']!, _msgStatusMeta),
      );
    }
    if (data.containsKey('notify_code')) {
      context.handle(
        _notifyCodeMeta,
        notifyCode.isAcceptableOrUnknown(data['notify_code']!, _notifyCodeMeta),
      );
    }
    if (data.containsKey('new_face_version')) {
      context.handle(
        _newFaceVersionMeta,
        newFaceVersion.isAcceptableOrUnknown(
          data['new_face_version']!,
          _newFaceVersionMeta,
        ),
      );
    }
    if (data.containsKey('msg_source')) {
      context.handle(
        _msgSourceMeta,
        msgSource.isAcceptableOrUnknown(data['msg_source']!, _msgSourceMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ownerUid, sessionType, talkerId, msgSeqno};
  @override
  NotificationMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationMessage(
      ownerUid: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}owner_uid'],
      )!,
      sessionType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_type'],
      )!,
      talkerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}talker_id'],
      )!,
      msgSeqno: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}msg_seqno'],
      )!,
      senderUid: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sender_uid'],
      )!,
      receiverType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}receiver_type'],
      )!,
      receiverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}receiver_id'],
      )!,
      msgType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}msg_type'],
      )!,
      contentJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_json'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp'],
      )!,
      atUidsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}at_uids_json'],
      ),
      msgKey: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}msg_key'],
      ),
      msgStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}msg_status'],
      ),
      notifyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notify_code'],
      ),
      newFaceVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}new_face_version'],
      ),
      msgSource: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}msg_source'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NotificationMessagesTable createAlias(String alias) {
    return $NotificationMessagesTable(attachedDatabase, alias);
  }
}

class NotificationMessage extends DataClass implements Insertable<NotificationMessage> {
  final int ownerUid;
  final int sessionType;
  final int talkerId;
  final int msgSeqno;
  final int senderUid;
  final int receiverType;
  final int receiverId;
  final int msgType;
  final String contentJson;
  final int timestamp;
  final String? atUidsJson;
  final int? msgKey;
  final int? msgStatus;
  final String? notifyCode;
  final int? newFaceVersion;
  final int? msgSource;
  final String syncStatus;
  final int createdAt;
  final int updatedAt;
  const NotificationMessage({
    required this.ownerUid,
    required this.sessionType,
    required this.talkerId,
    required this.msgSeqno,
    required this.senderUid,
    required this.receiverType,
    required this.receiverId,
    required this.msgType,
    required this.contentJson,
    required this.timestamp,
    this.atUidsJson,
    this.msgKey,
    this.msgStatus,
    this.notifyCode,
    this.newFaceVersion,
    this.msgSource,
    required this.syncStatus,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['owner_uid'] = Variable<int>(ownerUid);
    map['session_type'] = Variable<int>(sessionType);
    map['talker_id'] = Variable<int>(talkerId);
    map['msg_seqno'] = Variable<int>(msgSeqno);
    map['sender_uid'] = Variable<int>(senderUid);
    map['receiver_type'] = Variable<int>(receiverType);
    map['receiver_id'] = Variable<int>(receiverId);
    map['msg_type'] = Variable<int>(msgType);
    map['content_json'] = Variable<String>(contentJson);
    map['timestamp'] = Variable<int>(timestamp);
    if (!nullToAbsent || atUidsJson != null) {
      map['at_uids_json'] = Variable<String>(atUidsJson);
    }
    if (!nullToAbsent || msgKey != null) {
      map['msg_key'] = Variable<int>(msgKey);
    }
    if (!nullToAbsent || msgStatus != null) {
      map['msg_status'] = Variable<int>(msgStatus);
    }
    if (!nullToAbsent || notifyCode != null) {
      map['notify_code'] = Variable<String>(notifyCode);
    }
    if (!nullToAbsent || newFaceVersion != null) {
      map['new_face_version'] = Variable<int>(newFaceVersion);
    }
    if (!nullToAbsent || msgSource != null) {
      map['msg_source'] = Variable<int>(msgSource);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  NotificationMessagesCompanion toCompanion(bool nullToAbsent) {
    return NotificationMessagesCompanion(
      ownerUid: Value(ownerUid),
      sessionType: Value(sessionType),
      talkerId: Value(talkerId),
      msgSeqno: Value(msgSeqno),
      senderUid: Value(senderUid),
      receiverType: Value(receiverType),
      receiverId: Value(receiverId),
      msgType: Value(msgType),
      contentJson: Value(contentJson),
      timestamp: Value(timestamp),
      atUidsJson: atUidsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(atUidsJson),
      msgKey: msgKey == null && nullToAbsent ? const Value.absent() : Value(msgKey),
      msgStatus: msgStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(msgStatus),
      notifyCode: notifyCode == null && nullToAbsent
          ? const Value.absent()
          : Value(notifyCode),
      newFaceVersion: newFaceVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(newFaceVersion),
      msgSource: msgSource == null && nullToAbsent
          ? const Value.absent()
          : Value(msgSource),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory NotificationMessage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationMessage(
      ownerUid: serializer.fromJson<int>(json['ownerUid']),
      sessionType: serializer.fromJson<int>(json['sessionType']),
      talkerId: serializer.fromJson<int>(json['talkerId']),
      msgSeqno: serializer.fromJson<int>(json['msgSeqno']),
      senderUid: serializer.fromJson<int>(json['senderUid']),
      receiverType: serializer.fromJson<int>(json['receiverType']),
      receiverId: serializer.fromJson<int>(json['receiverId']),
      msgType: serializer.fromJson<int>(json['msgType']),
      contentJson: serializer.fromJson<String>(json['contentJson']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      atUidsJson: serializer.fromJson<String?>(json['atUidsJson']),
      msgKey: serializer.fromJson<int?>(json['msgKey']),
      msgStatus: serializer.fromJson<int?>(json['msgStatus']),
      notifyCode: serializer.fromJson<String?>(json['notifyCode']),
      newFaceVersion: serializer.fromJson<int?>(json['newFaceVersion']),
      msgSource: serializer.fromJson<int?>(json['msgSource']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ownerUid': serializer.toJson<int>(ownerUid),
      'sessionType': serializer.toJson<int>(sessionType),
      'talkerId': serializer.toJson<int>(talkerId),
      'msgSeqno': serializer.toJson<int>(msgSeqno),
      'senderUid': serializer.toJson<int>(senderUid),
      'receiverType': serializer.toJson<int>(receiverType),
      'receiverId': serializer.toJson<int>(receiverId),
      'msgType': serializer.toJson<int>(msgType),
      'contentJson': serializer.toJson<String>(contentJson),
      'timestamp': serializer.toJson<int>(timestamp),
      'atUidsJson': serializer.toJson<String?>(atUidsJson),
      'msgKey': serializer.toJson<int?>(msgKey),
      'msgStatus': serializer.toJson<int?>(msgStatus),
      'notifyCode': serializer.toJson<String?>(notifyCode),
      'newFaceVersion': serializer.toJson<int?>(newFaceVersion),
      'msgSource': serializer.toJson<int?>(msgSource),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  NotificationMessage copyWith({
    int? ownerUid,
    int? sessionType,
    int? talkerId,
    int? msgSeqno,
    int? senderUid,
    int? receiverType,
    int? receiverId,
    int? msgType,
    String? contentJson,
    int? timestamp,
    Value<String?> atUidsJson = const Value.absent(),
    Value<int?> msgKey = const Value.absent(),
    Value<int?> msgStatus = const Value.absent(),
    Value<String?> notifyCode = const Value.absent(),
    Value<int?> newFaceVersion = const Value.absent(),
    Value<int?> msgSource = const Value.absent(),
    String? syncStatus,
    int? createdAt,
    int? updatedAt,
  }) => NotificationMessage(
    ownerUid: ownerUid ?? this.ownerUid,
    sessionType: sessionType ?? this.sessionType,
    talkerId: talkerId ?? this.talkerId,
    msgSeqno: msgSeqno ?? this.msgSeqno,
    senderUid: senderUid ?? this.senderUid,
    receiverType: receiverType ?? this.receiverType,
    receiverId: receiverId ?? this.receiverId,
    msgType: msgType ?? this.msgType,
    contentJson: contentJson ?? this.contentJson,
    timestamp: timestamp ?? this.timestamp,
    atUidsJson: atUidsJson.present ? atUidsJson.value : this.atUidsJson,
    msgKey: msgKey.present ? msgKey.value : this.msgKey,
    msgStatus: msgStatus.present ? msgStatus.value : this.msgStatus,
    notifyCode: notifyCode.present ? notifyCode.value : this.notifyCode,
    newFaceVersion: newFaceVersion.present ? newFaceVersion.value : this.newFaceVersion,
    msgSource: msgSource.present ? msgSource.value : this.msgSource,
    syncStatus: syncStatus ?? this.syncStatus,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NotificationMessage copyWithCompanion(NotificationMessagesCompanion data) {
    return NotificationMessage(
      ownerUid: data.ownerUid.present ? data.ownerUid.value : this.ownerUid,
      sessionType: data.sessionType.present ? data.sessionType.value : this.sessionType,
      talkerId: data.talkerId.present ? data.talkerId.value : this.talkerId,
      msgSeqno: data.msgSeqno.present ? data.msgSeqno.value : this.msgSeqno,
      senderUid: data.senderUid.present ? data.senderUid.value : this.senderUid,
      receiverType: data.receiverType.present
          ? data.receiverType.value
          : this.receiverType,
      receiverId: data.receiverId.present ? data.receiverId.value : this.receiverId,
      msgType: data.msgType.present ? data.msgType.value : this.msgType,
      contentJson: data.contentJson.present ? data.contentJson.value : this.contentJson,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      atUidsJson: data.atUidsJson.present ? data.atUidsJson.value : this.atUidsJson,
      msgKey: data.msgKey.present ? data.msgKey.value : this.msgKey,
      msgStatus: data.msgStatus.present ? data.msgStatus.value : this.msgStatus,
      notifyCode: data.notifyCode.present ? data.notifyCode.value : this.notifyCode,
      newFaceVersion: data.newFaceVersion.present
          ? data.newFaceVersion.value
          : this.newFaceVersion,
      msgSource: data.msgSource.present ? data.msgSource.value : this.msgSource,
      syncStatus: data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationMessage(')
          ..write('ownerUid: $ownerUid, ')
          ..write('sessionType: $sessionType, ')
          ..write('talkerId: $talkerId, ')
          ..write('msgSeqno: $msgSeqno, ')
          ..write('senderUid: $senderUid, ')
          ..write('receiverType: $receiverType, ')
          ..write('receiverId: $receiverId, ')
          ..write('msgType: $msgType, ')
          ..write('contentJson: $contentJson, ')
          ..write('timestamp: $timestamp, ')
          ..write('atUidsJson: $atUidsJson, ')
          ..write('msgKey: $msgKey, ')
          ..write('msgStatus: $msgStatus, ')
          ..write('notifyCode: $notifyCode, ')
          ..write('newFaceVersion: $newFaceVersion, ')
          ..write('msgSource: $msgSource, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    ownerUid,
    sessionType,
    talkerId,
    msgSeqno,
    senderUid,
    receiverType,
    receiverId,
    msgType,
    contentJson,
    timestamp,
    atUidsJson,
    msgKey,
    msgStatus,
    notifyCode,
    newFaceVersion,
    msgSource,
    syncStatus,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationMessage &&
          other.ownerUid == this.ownerUid &&
          other.sessionType == this.sessionType &&
          other.talkerId == this.talkerId &&
          other.msgSeqno == this.msgSeqno &&
          other.senderUid == this.senderUid &&
          other.receiverType == this.receiverType &&
          other.receiverId == this.receiverId &&
          other.msgType == this.msgType &&
          other.contentJson == this.contentJson &&
          other.timestamp == this.timestamp &&
          other.atUidsJson == this.atUidsJson &&
          other.msgKey == this.msgKey &&
          other.msgStatus == this.msgStatus &&
          other.notifyCode == this.notifyCode &&
          other.newFaceVersion == this.newFaceVersion &&
          other.msgSource == this.msgSource &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class NotificationMessagesCompanion extends UpdateCompanion<NotificationMessage> {
  final Value<int> ownerUid;
  final Value<int> sessionType;
  final Value<int> talkerId;
  final Value<int> msgSeqno;
  final Value<int> senderUid;
  final Value<int> receiverType;
  final Value<int> receiverId;
  final Value<int> msgType;
  final Value<String> contentJson;
  final Value<int> timestamp;
  final Value<String?> atUidsJson;
  final Value<int?> msgKey;
  final Value<int?> msgStatus;
  final Value<String?> notifyCode;
  final Value<int?> newFaceVersion;
  final Value<int?> msgSource;
  final Value<String> syncStatus;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const NotificationMessagesCompanion({
    this.ownerUid = const Value.absent(),
    this.sessionType = const Value.absent(),
    this.talkerId = const Value.absent(),
    this.msgSeqno = const Value.absent(),
    this.senderUid = const Value.absent(),
    this.receiverType = const Value.absent(),
    this.receiverId = const Value.absent(),
    this.msgType = const Value.absent(),
    this.contentJson = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.atUidsJson = const Value.absent(),
    this.msgKey = const Value.absent(),
    this.msgStatus = const Value.absent(),
    this.notifyCode = const Value.absent(),
    this.newFaceVersion = const Value.absent(),
    this.msgSource = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationMessagesCompanion.insert({
    required int ownerUid,
    required int sessionType,
    required int talkerId,
    required int msgSeqno,
    required int senderUid,
    required int receiverType,
    required int receiverId,
    required int msgType,
    required String contentJson,
    required int timestamp,
    this.atUidsJson = const Value.absent(),
    this.msgKey = const Value.absent(),
    this.msgStatus = const Value.absent(),
    this.notifyCode = const Value.absent(),
    this.newFaceVersion = const Value.absent(),
    this.msgSource = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : ownerUid = Value(ownerUid),
       sessionType = Value(sessionType),
       talkerId = Value(talkerId),
       msgSeqno = Value(msgSeqno),
       senderUid = Value(senderUid),
       receiverType = Value(receiverType),
       receiverId = Value(receiverId),
       msgType = Value(msgType),
       contentJson = Value(contentJson),
       timestamp = Value(timestamp),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<NotificationMessage> custom({
    Expression<int>? ownerUid,
    Expression<int>? sessionType,
    Expression<int>? talkerId,
    Expression<int>? msgSeqno,
    Expression<int>? senderUid,
    Expression<int>? receiverType,
    Expression<int>? receiverId,
    Expression<int>? msgType,
    Expression<String>? contentJson,
    Expression<int>? timestamp,
    Expression<String>? atUidsJson,
    Expression<int>? msgKey,
    Expression<int>? msgStatus,
    Expression<String>? notifyCode,
    Expression<int>? newFaceVersion,
    Expression<int>? msgSource,
    Expression<String>? syncStatus,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (ownerUid != null) 'owner_uid': ownerUid,
      if (sessionType != null) 'session_type': sessionType,
      if (talkerId != null) 'talker_id': talkerId,
      if (msgSeqno != null) 'msg_seqno': msgSeqno,
      if (senderUid != null) 'sender_uid': senderUid,
      if (receiverType != null) 'receiver_type': receiverType,
      if (receiverId != null) 'receiver_id': receiverId,
      if (msgType != null) 'msg_type': msgType,
      if (contentJson != null) 'content_json': contentJson,
      if (timestamp != null) 'timestamp': timestamp,
      if (atUidsJson != null) 'at_uids_json': atUidsJson,
      if (msgKey != null) 'msg_key': msgKey,
      if (msgStatus != null) 'msg_status': msgStatus,
      if (notifyCode != null) 'notify_code': notifyCode,
      if (newFaceVersion != null) 'new_face_version': newFaceVersion,
      if (msgSource != null) 'msg_source': msgSource,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationMessagesCompanion copyWith({
    Value<int>? ownerUid,
    Value<int>? sessionType,
    Value<int>? talkerId,
    Value<int>? msgSeqno,
    Value<int>? senderUid,
    Value<int>? receiverType,
    Value<int>? receiverId,
    Value<int>? msgType,
    Value<String>? contentJson,
    Value<int>? timestamp,
    Value<String?>? atUidsJson,
    Value<int?>? msgKey,
    Value<int?>? msgStatus,
    Value<String?>? notifyCode,
    Value<int?>? newFaceVersion,
    Value<int?>? msgSource,
    Value<String>? syncStatus,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return NotificationMessagesCompanion(
      ownerUid: ownerUid ?? this.ownerUid,
      sessionType: sessionType ?? this.sessionType,
      talkerId: talkerId ?? this.talkerId,
      msgSeqno: msgSeqno ?? this.msgSeqno,
      senderUid: senderUid ?? this.senderUid,
      receiverType: receiverType ?? this.receiverType,
      receiverId: receiverId ?? this.receiverId,
      msgType: msgType ?? this.msgType,
      contentJson: contentJson ?? this.contentJson,
      timestamp: timestamp ?? this.timestamp,
      atUidsJson: atUidsJson ?? this.atUidsJson,
      msgKey: msgKey ?? this.msgKey,
      msgStatus: msgStatus ?? this.msgStatus,
      notifyCode: notifyCode ?? this.notifyCode,
      newFaceVersion: newFaceVersion ?? this.newFaceVersion,
      msgSource: msgSource ?? this.msgSource,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ownerUid.present) {
      map['owner_uid'] = Variable<int>(ownerUid.value);
    }
    if (sessionType.present) {
      map['session_type'] = Variable<int>(sessionType.value);
    }
    if (talkerId.present) {
      map['talker_id'] = Variable<int>(talkerId.value);
    }
    if (msgSeqno.present) {
      map['msg_seqno'] = Variable<int>(msgSeqno.value);
    }
    if (senderUid.present) {
      map['sender_uid'] = Variable<int>(senderUid.value);
    }
    if (receiverType.present) {
      map['receiver_type'] = Variable<int>(receiverType.value);
    }
    if (receiverId.present) {
      map['receiver_id'] = Variable<int>(receiverId.value);
    }
    if (msgType.present) {
      map['msg_type'] = Variable<int>(msgType.value);
    }
    if (contentJson.present) {
      map['content_json'] = Variable<String>(contentJson.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (atUidsJson.present) {
      map['at_uids_json'] = Variable<String>(atUidsJson.value);
    }
    if (msgKey.present) {
      map['msg_key'] = Variable<int>(msgKey.value);
    }
    if (msgStatus.present) {
      map['msg_status'] = Variable<int>(msgStatus.value);
    }
    if (notifyCode.present) {
      map['notify_code'] = Variable<String>(notifyCode.value);
    }
    if (newFaceVersion.present) {
      map['new_face_version'] = Variable<int>(newFaceVersion.value);
    }
    if (msgSource.present) {
      map['msg_source'] = Variable<int>(msgSource.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationMessagesCompanion(')
          ..write('ownerUid: $ownerUid, ')
          ..write('sessionType: $sessionType, ')
          ..write('talkerId: $talkerId, ')
          ..write('msgSeqno: $msgSeqno, ')
          ..write('senderUid: $senderUid, ')
          ..write('receiverType: $receiverType, ')
          ..write('receiverId: $receiverId, ')
          ..write('msgType: $msgType, ')
          ..write('contentJson: $contentJson, ')
          ..write('timestamp: $timestamp, ')
          ..write('atUidsJson: $atUidsJson, ')
          ..write('msgKey: $msgKey, ')
          ..write('msgStatus: $msgStatus, ')
          ..write('notifyCode: $notifyCode, ')
          ..write('newFaceVersion: $newFaceVersion, ')
          ..write('msgSource: $msgSource, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationMessageEmojisTable extends NotificationMessageEmojis
    with TableInfo<$NotificationMessageEmojisTable, NotificationMessageEmoji> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationMessageEmojisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ownerUidMeta = const VerificationMeta('ownerUid');
  @override
  late final GeneratedColumn<int> ownerUid = GeneratedColumn<int>(
    'owner_uid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionTypeMeta = const VerificationMeta('sessionType');
  @override
  late final GeneratedColumn<int> sessionType = GeneratedColumn<int>(
    'session_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _talkerIdMeta = const VerificationMeta('talkerId');
  @override
  late final GeneratedColumn<int> talkerId = GeneratedColumn<int>(
    'talker_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emojiTextMeta = const VerificationMeta('emojiText');
  @override
  late final GeneratedColumn<String> emojiText = GeneratedColumn<String>(
    'emoji_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emojiUrlMeta = const VerificationMeta('emojiUrl');
  @override
  late final GeneratedColumn<String> emojiUrl = GeneratedColumn<String>(
    'emoji_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    ownerUid,
    sessionType,
    talkerId,
    emojiText,
    emojiUrl,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_message_emojis';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationMessageEmoji> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('owner_uid')) {
      context.handle(
        _ownerUidMeta,
        ownerUid.isAcceptableOrUnknown(data['owner_uid']!, _ownerUidMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerUidMeta);
    }
    if (data.containsKey('session_type')) {
      context.handle(
        _sessionTypeMeta,
        sessionType.isAcceptableOrUnknown(data['session_type']!, _sessionTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionTypeMeta);
    }
    if (data.containsKey('talker_id')) {
      context.handle(
        _talkerIdMeta,
        talkerId.isAcceptableOrUnknown(data['talker_id']!, _talkerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_talkerIdMeta);
    }
    if (data.containsKey('emoji_text')) {
      context.handle(
        _emojiTextMeta,
        emojiText.isAcceptableOrUnknown(data['emoji_text']!, _emojiTextMeta),
      );
    } else if (isInserting) {
      context.missing(_emojiTextMeta);
    }
    if (data.containsKey('emoji_url')) {
      context.handle(
        _emojiUrlMeta,
        emojiUrl.isAcceptableOrUnknown(data['emoji_url']!, _emojiUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_emojiUrlMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ownerUid, sessionType, talkerId, emojiText};
  @override
  NotificationMessageEmoji map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationMessageEmoji(
      ownerUid: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}owner_uid'],
      )!,
      sessionType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_type'],
      )!,
      talkerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}talker_id'],
      )!,
      emojiText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emoji_text'],
      )!,
      emojiUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emoji_url'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NotificationMessageEmojisTable createAlias(String alias) {
    return $NotificationMessageEmojisTable(attachedDatabase, alias);
  }
}

class NotificationMessageEmoji extends DataClass
    implements Insertable<NotificationMessageEmoji> {
  final int ownerUid;
  final int sessionType;
  final int talkerId;
  final String emojiText;
  final String emojiUrl;
  final int updatedAt;
  const NotificationMessageEmoji({
    required this.ownerUid,
    required this.sessionType,
    required this.talkerId,
    required this.emojiText,
    required this.emojiUrl,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['owner_uid'] = Variable<int>(ownerUid);
    map['session_type'] = Variable<int>(sessionType);
    map['talker_id'] = Variable<int>(talkerId);
    map['emoji_text'] = Variable<String>(emojiText);
    map['emoji_url'] = Variable<String>(emojiUrl);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  NotificationMessageEmojisCompanion toCompanion(bool nullToAbsent) {
    return NotificationMessageEmojisCompanion(
      ownerUid: Value(ownerUid),
      sessionType: Value(sessionType),
      talkerId: Value(talkerId),
      emojiText: Value(emojiText),
      emojiUrl: Value(emojiUrl),
      updatedAt: Value(updatedAt),
    );
  }

  factory NotificationMessageEmoji.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationMessageEmoji(
      ownerUid: serializer.fromJson<int>(json['ownerUid']),
      sessionType: serializer.fromJson<int>(json['sessionType']),
      talkerId: serializer.fromJson<int>(json['talkerId']),
      emojiText: serializer.fromJson<String>(json['emojiText']),
      emojiUrl: serializer.fromJson<String>(json['emojiUrl']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ownerUid': serializer.toJson<int>(ownerUid),
      'sessionType': serializer.toJson<int>(sessionType),
      'talkerId': serializer.toJson<int>(talkerId),
      'emojiText': serializer.toJson<String>(emojiText),
      'emojiUrl': serializer.toJson<String>(emojiUrl),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  NotificationMessageEmoji copyWith({
    int? ownerUid,
    int? sessionType,
    int? talkerId,
    String? emojiText,
    String? emojiUrl,
    int? updatedAt,
  }) => NotificationMessageEmoji(
    ownerUid: ownerUid ?? this.ownerUid,
    sessionType: sessionType ?? this.sessionType,
    talkerId: talkerId ?? this.talkerId,
    emojiText: emojiText ?? this.emojiText,
    emojiUrl: emojiUrl ?? this.emojiUrl,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NotificationMessageEmoji copyWithCompanion(NotificationMessageEmojisCompanion data) {
    return NotificationMessageEmoji(
      ownerUid: data.ownerUid.present ? data.ownerUid.value : this.ownerUid,
      sessionType: data.sessionType.present ? data.sessionType.value : this.sessionType,
      talkerId: data.talkerId.present ? data.talkerId.value : this.talkerId,
      emojiText: data.emojiText.present ? data.emojiText.value : this.emojiText,
      emojiUrl: data.emojiUrl.present ? data.emojiUrl.value : this.emojiUrl,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationMessageEmoji(')
          ..write('ownerUid: $ownerUid, ')
          ..write('sessionType: $sessionType, ')
          ..write('talkerId: $talkerId, ')
          ..write('emojiText: $emojiText, ')
          ..write('emojiUrl: $emojiUrl, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(ownerUid, sessionType, talkerId, emojiText, emojiUrl, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationMessageEmoji &&
          other.ownerUid == this.ownerUid &&
          other.sessionType == this.sessionType &&
          other.talkerId == this.talkerId &&
          other.emojiText == this.emojiText &&
          other.emojiUrl == this.emojiUrl &&
          other.updatedAt == this.updatedAt);
}

class NotificationMessageEmojisCompanion
    extends UpdateCompanion<NotificationMessageEmoji> {
  final Value<int> ownerUid;
  final Value<int> sessionType;
  final Value<int> talkerId;
  final Value<String> emojiText;
  final Value<String> emojiUrl;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const NotificationMessageEmojisCompanion({
    this.ownerUid = const Value.absent(),
    this.sessionType = const Value.absent(),
    this.talkerId = const Value.absent(),
    this.emojiText = const Value.absent(),
    this.emojiUrl = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationMessageEmojisCompanion.insert({
    required int ownerUid,
    required int sessionType,
    required int talkerId,
    required String emojiText,
    required String emojiUrl,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : ownerUid = Value(ownerUid),
       sessionType = Value(sessionType),
       talkerId = Value(talkerId),
       emojiText = Value(emojiText),
       emojiUrl = Value(emojiUrl),
       updatedAt = Value(updatedAt);
  static Insertable<NotificationMessageEmoji> custom({
    Expression<int>? ownerUid,
    Expression<int>? sessionType,
    Expression<int>? talkerId,
    Expression<String>? emojiText,
    Expression<String>? emojiUrl,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (ownerUid != null) 'owner_uid': ownerUid,
      if (sessionType != null) 'session_type': sessionType,
      if (talkerId != null) 'talker_id': talkerId,
      if (emojiText != null) 'emoji_text': emojiText,
      if (emojiUrl != null) 'emoji_url': emojiUrl,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationMessageEmojisCompanion copyWith({
    Value<int>? ownerUid,
    Value<int>? sessionType,
    Value<int>? talkerId,
    Value<String>? emojiText,
    Value<String>? emojiUrl,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return NotificationMessageEmojisCompanion(
      ownerUid: ownerUid ?? this.ownerUid,
      sessionType: sessionType ?? this.sessionType,
      talkerId: talkerId ?? this.talkerId,
      emojiText: emojiText ?? this.emojiText,
      emojiUrl: emojiUrl ?? this.emojiUrl,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ownerUid.present) {
      map['owner_uid'] = Variable<int>(ownerUid.value);
    }
    if (sessionType.present) {
      map['session_type'] = Variable<int>(sessionType.value);
    }
    if (talkerId.present) {
      map['talker_id'] = Variable<int>(talkerId.value);
    }
    if (emojiText.present) {
      map['emoji_text'] = Variable<String>(emojiText.value);
    }
    if (emojiUrl.present) {
      map['emoji_url'] = Variable<String>(emojiUrl.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationMessageEmojisCompanion(')
          ..write('ownerUid: $ownerUid, ')
          ..write('sessionType: $sessionType, ')
          ..write('talkerId: $talkerId, ')
          ..write('emojiText: $emojiText, ')
          ..write('emojiUrl: $emojiUrl, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationSessionsTable extends NotificationSessions
    with TableInfo<$NotificationSessionsTable, NotificationSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ownerUidMeta = const VerificationMeta('ownerUid');
  @override
  late final GeneratedColumn<int> ownerUid = GeneratedColumn<int>(
    'owner_uid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionTypeMeta = const VerificationMeta('sessionType');
  @override
  late final GeneratedColumn<int> sessionType = GeneratedColumn<int>(
    'session_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _talkerIdMeta = const VerificationMeta('talkerId');
  @override
  late final GeneratedColumn<int> talkerId = GeneratedColumn<int>(
    'talker_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unreadCountMeta = const VerificationMeta('unreadCount');
  @override
  late final GeneratedColumn<int> unreadCount = GeneratedColumn<int>(
    'unread_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sessionTsMeta = const VerificationMeta('sessionTs');
  @override
  late final GeneratedColumn<int> sessionTs = GeneratedColumn<int>(
    'session_ts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionJsonMeta = const VerificationMeta('sessionJson');
  @override
  late final GeneratedColumn<String> sessionJson = GeneratedColumn<String>(
    'session_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    ownerUid,
    sessionType,
    talkerId,
    unreadCount,
    sessionTs,
    sessionJson,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('owner_uid')) {
      context.handle(
        _ownerUidMeta,
        ownerUid.isAcceptableOrUnknown(data['owner_uid']!, _ownerUidMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerUidMeta);
    }
    if (data.containsKey('session_type')) {
      context.handle(
        _sessionTypeMeta,
        sessionType.isAcceptableOrUnknown(data['session_type']!, _sessionTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionTypeMeta);
    }
    if (data.containsKey('talker_id')) {
      context.handle(
        _talkerIdMeta,
        talkerId.isAcceptableOrUnknown(data['talker_id']!, _talkerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_talkerIdMeta);
    }
    if (data.containsKey('unread_count')) {
      context.handle(
        _unreadCountMeta,
        unreadCount.isAcceptableOrUnknown(data['unread_count']!, _unreadCountMeta),
      );
    }
    if (data.containsKey('session_ts')) {
      context.handle(
        _sessionTsMeta,
        sessionTs.isAcceptableOrUnknown(data['session_ts']!, _sessionTsMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionTsMeta);
    }
    if (data.containsKey('session_json')) {
      context.handle(
        _sessionJsonMeta,
        sessionJson.isAcceptableOrUnknown(data['session_json']!, _sessionJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionJsonMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ownerUid, sessionType, talkerId};
  @override
  NotificationSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationSession(
      ownerUid: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}owner_uid'],
      )!,
      sessionType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_type'],
      )!,
      talkerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}talker_id'],
      )!,
      unreadCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unread_count'],
      )!,
      sessionTs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_ts'],
      )!,
      sessionJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NotificationSessionsTable createAlias(String alias) {
    return $NotificationSessionsTable(attachedDatabase, alias);
  }
}

class NotificationSession extends DataClass implements Insertable<NotificationSession> {
  final int ownerUid;
  final int sessionType;
  final int talkerId;
  final int unreadCount;
  final int sessionTs;
  final String sessionJson;
  final int updatedAt;
  const NotificationSession({
    required this.ownerUid,
    required this.sessionType,
    required this.talkerId,
    required this.unreadCount,
    required this.sessionTs,
    required this.sessionJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['owner_uid'] = Variable<int>(ownerUid);
    map['session_type'] = Variable<int>(sessionType);
    map['talker_id'] = Variable<int>(talkerId);
    map['unread_count'] = Variable<int>(unreadCount);
    map['session_ts'] = Variable<int>(sessionTs);
    map['session_json'] = Variable<String>(sessionJson);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  NotificationSessionsCompanion toCompanion(bool nullToAbsent) {
    return NotificationSessionsCompanion(
      ownerUid: Value(ownerUid),
      sessionType: Value(sessionType),
      talkerId: Value(talkerId),
      unreadCount: Value(unreadCount),
      sessionTs: Value(sessionTs),
      sessionJson: Value(sessionJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory NotificationSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationSession(
      ownerUid: serializer.fromJson<int>(json['ownerUid']),
      sessionType: serializer.fromJson<int>(json['sessionType']),
      talkerId: serializer.fromJson<int>(json['talkerId']),
      unreadCount: serializer.fromJson<int>(json['unreadCount']),
      sessionTs: serializer.fromJson<int>(json['sessionTs']),
      sessionJson: serializer.fromJson<String>(json['sessionJson']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ownerUid': serializer.toJson<int>(ownerUid),
      'sessionType': serializer.toJson<int>(sessionType),
      'talkerId': serializer.toJson<int>(talkerId),
      'unreadCount': serializer.toJson<int>(unreadCount),
      'sessionTs': serializer.toJson<int>(sessionTs),
      'sessionJson': serializer.toJson<String>(sessionJson),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  NotificationSession copyWith({
    int? ownerUid,
    int? sessionType,
    int? talkerId,
    int? unreadCount,
    int? sessionTs,
    String? sessionJson,
    int? updatedAt,
  }) => NotificationSession(
    ownerUid: ownerUid ?? this.ownerUid,
    sessionType: sessionType ?? this.sessionType,
    talkerId: talkerId ?? this.talkerId,
    unreadCount: unreadCount ?? this.unreadCount,
    sessionTs: sessionTs ?? this.sessionTs,
    sessionJson: sessionJson ?? this.sessionJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NotificationSession copyWithCompanion(NotificationSessionsCompanion data) {
    return NotificationSession(
      ownerUid: data.ownerUid.present ? data.ownerUid.value : this.ownerUid,
      sessionType: data.sessionType.present ? data.sessionType.value : this.sessionType,
      talkerId: data.talkerId.present ? data.talkerId.value : this.talkerId,
      unreadCount: data.unreadCount.present ? data.unreadCount.value : this.unreadCount,
      sessionTs: data.sessionTs.present ? data.sessionTs.value : this.sessionTs,
      sessionJson: data.sessionJson.present ? data.sessionJson.value : this.sessionJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationSession(')
          ..write('ownerUid: $ownerUid, ')
          ..write('sessionType: $sessionType, ')
          ..write('talkerId: $talkerId, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('sessionTs: $sessionTs, ')
          ..write('sessionJson: $sessionJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    ownerUid,
    sessionType,
    talkerId,
    unreadCount,
    sessionTs,
    sessionJson,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationSession &&
          other.ownerUid == this.ownerUid &&
          other.sessionType == this.sessionType &&
          other.talkerId == this.talkerId &&
          other.unreadCount == this.unreadCount &&
          other.sessionTs == this.sessionTs &&
          other.sessionJson == this.sessionJson &&
          other.updatedAt == this.updatedAt);
}

class NotificationSessionsCompanion extends UpdateCompanion<NotificationSession> {
  final Value<int> ownerUid;
  final Value<int> sessionType;
  final Value<int> talkerId;
  final Value<int> unreadCount;
  final Value<int> sessionTs;
  final Value<String> sessionJson;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const NotificationSessionsCompanion({
    this.ownerUid = const Value.absent(),
    this.sessionType = const Value.absent(),
    this.talkerId = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.sessionTs = const Value.absent(),
    this.sessionJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationSessionsCompanion.insert({
    required int ownerUid,
    required int sessionType,
    required int talkerId,
    this.unreadCount = const Value.absent(),
    required int sessionTs,
    required String sessionJson,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : ownerUid = Value(ownerUid),
       sessionType = Value(sessionType),
       talkerId = Value(talkerId),
       sessionTs = Value(sessionTs),
       sessionJson = Value(sessionJson),
       updatedAt = Value(updatedAt);
  static Insertable<NotificationSession> custom({
    Expression<int>? ownerUid,
    Expression<int>? sessionType,
    Expression<int>? talkerId,
    Expression<int>? unreadCount,
    Expression<int>? sessionTs,
    Expression<String>? sessionJson,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (ownerUid != null) 'owner_uid': ownerUid,
      if (sessionType != null) 'session_type': sessionType,
      if (talkerId != null) 'talker_id': talkerId,
      if (unreadCount != null) 'unread_count': unreadCount,
      if (sessionTs != null) 'session_ts': sessionTs,
      if (sessionJson != null) 'session_json': sessionJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationSessionsCompanion copyWith({
    Value<int>? ownerUid,
    Value<int>? sessionType,
    Value<int>? talkerId,
    Value<int>? unreadCount,
    Value<int>? sessionTs,
    Value<String>? sessionJson,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return NotificationSessionsCompanion(
      ownerUid: ownerUid ?? this.ownerUid,
      sessionType: sessionType ?? this.sessionType,
      talkerId: talkerId ?? this.talkerId,
      unreadCount: unreadCount ?? this.unreadCount,
      sessionTs: sessionTs ?? this.sessionTs,
      sessionJson: sessionJson ?? this.sessionJson,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ownerUid.present) {
      map['owner_uid'] = Variable<int>(ownerUid.value);
    }
    if (sessionType.present) {
      map['session_type'] = Variable<int>(sessionType.value);
    }
    if (talkerId.present) {
      map['talker_id'] = Variable<int>(talkerId.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    if (sessionTs.present) {
      map['session_ts'] = Variable<int>(sessionTs.value);
    }
    if (sessionJson.present) {
      map['session_json'] = Variable<String>(sessionJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationSessionsCompanion(')
          ..write('ownerUid: $ownerUid, ')
          ..write('sessionType: $sessionType, ')
          ..write('talkerId: $talkerId, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('sessionTs: $sessionTs, ')
          ..write('sessionJson: $sessionJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationFeedItemsTable extends NotificationFeedItems
    with TableInfo<$NotificationFeedItemsTable, NotificationFeedItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationFeedItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ownerUidMeta = const VerificationMeta('ownerUid');
  @override
  late final GeneratedColumn<int> ownerUid = GeneratedColumn<int>(
    'owner_uid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _feedTypeMeta = const VerificationMeta('feedType');
  @override
  late final GeneratedColumn<String> feedType = GeneratedColumn<String>(
    'feed_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta('eventId');
  @override
  late final GeneratedColumn<int> eventId = GeneratedColumn<int>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventTimeMeta = const VerificationMeta('eventTime');
  @override
  late final GeneratedColumn<int> eventTime = GeneratedColumn<int>(
    'event_time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemJsonMeta = const VerificationMeta('itemJson');
  @override
  late final GeneratedColumn<String> itemJson = GeneratedColumn<String>(
    'item_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    ownerUid,
    feedType,
    eventId,
    eventTime,
    itemJson,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_feed_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationFeedItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('owner_uid')) {
      context.handle(
        _ownerUidMeta,
        ownerUid.isAcceptableOrUnknown(data['owner_uid']!, _ownerUidMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerUidMeta);
    }
    if (data.containsKey('feed_type')) {
      context.handle(
        _feedTypeMeta,
        feedType.isAcceptableOrUnknown(data['feed_type']!, _feedTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_feedTypeMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('event_time')) {
      context.handle(
        _eventTimeMeta,
        eventTime.isAcceptableOrUnknown(data['event_time']!, _eventTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTimeMeta);
    }
    if (data.containsKey('item_json')) {
      context.handle(
        _itemJsonMeta,
        itemJson.isAcceptableOrUnknown(data['item_json']!, _itemJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_itemJsonMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ownerUid, feedType, eventId};
  @override
  NotificationFeedItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationFeedItem(
      ownerUid: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}owner_uid'],
      )!,
      feedType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feed_type'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_id'],
      )!,
      eventTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}event_time'],
      )!,
      itemJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NotificationFeedItemsTable createAlias(String alias) {
    return $NotificationFeedItemsTable(attachedDatabase, alias);
  }
}

class NotificationFeedItem extends DataClass implements Insertable<NotificationFeedItem> {
  final int ownerUid;
  final String feedType;
  final int eventId;
  final int eventTime;
  final String itemJson;
  final int updatedAt;
  const NotificationFeedItem({
    required this.ownerUid,
    required this.feedType,
    required this.eventId,
    required this.eventTime,
    required this.itemJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['owner_uid'] = Variable<int>(ownerUid);
    map['feed_type'] = Variable<String>(feedType);
    map['event_id'] = Variable<int>(eventId);
    map['event_time'] = Variable<int>(eventTime);
    map['item_json'] = Variable<String>(itemJson);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  NotificationFeedItemsCompanion toCompanion(bool nullToAbsent) {
    return NotificationFeedItemsCompanion(
      ownerUid: Value(ownerUid),
      feedType: Value(feedType),
      eventId: Value(eventId),
      eventTime: Value(eventTime),
      itemJson: Value(itemJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory NotificationFeedItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationFeedItem(
      ownerUid: serializer.fromJson<int>(json['ownerUid']),
      feedType: serializer.fromJson<String>(json['feedType']),
      eventId: serializer.fromJson<int>(json['eventId']),
      eventTime: serializer.fromJson<int>(json['eventTime']),
      itemJson: serializer.fromJson<String>(json['itemJson']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ownerUid': serializer.toJson<int>(ownerUid),
      'feedType': serializer.toJson<String>(feedType),
      'eventId': serializer.toJson<int>(eventId),
      'eventTime': serializer.toJson<int>(eventTime),
      'itemJson': serializer.toJson<String>(itemJson),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  NotificationFeedItem copyWith({
    int? ownerUid,
    String? feedType,
    int? eventId,
    int? eventTime,
    String? itemJson,
    int? updatedAt,
  }) => NotificationFeedItem(
    ownerUid: ownerUid ?? this.ownerUid,
    feedType: feedType ?? this.feedType,
    eventId: eventId ?? this.eventId,
    eventTime: eventTime ?? this.eventTime,
    itemJson: itemJson ?? this.itemJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NotificationFeedItem copyWithCompanion(NotificationFeedItemsCompanion data) {
    return NotificationFeedItem(
      ownerUid: data.ownerUid.present ? data.ownerUid.value : this.ownerUid,
      feedType: data.feedType.present ? data.feedType.value : this.feedType,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      eventTime: data.eventTime.present ? data.eventTime.value : this.eventTime,
      itemJson: data.itemJson.present ? data.itemJson.value : this.itemJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationFeedItem(')
          ..write('ownerUid: $ownerUid, ')
          ..write('feedType: $feedType, ')
          ..write('eventId: $eventId, ')
          ..write('eventTime: $eventTime, ')
          ..write('itemJson: $itemJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(ownerUid, feedType, eventId, eventTime, itemJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationFeedItem &&
          other.ownerUid == this.ownerUid &&
          other.feedType == this.feedType &&
          other.eventId == this.eventId &&
          other.eventTime == this.eventTime &&
          other.itemJson == this.itemJson &&
          other.updatedAt == this.updatedAt);
}

class NotificationFeedItemsCompanion extends UpdateCompanion<NotificationFeedItem> {
  final Value<int> ownerUid;
  final Value<String> feedType;
  final Value<int> eventId;
  final Value<int> eventTime;
  final Value<String> itemJson;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const NotificationFeedItemsCompanion({
    this.ownerUid = const Value.absent(),
    this.feedType = const Value.absent(),
    this.eventId = const Value.absent(),
    this.eventTime = const Value.absent(),
    this.itemJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationFeedItemsCompanion.insert({
    required int ownerUid,
    required String feedType,
    required int eventId,
    required int eventTime,
    required String itemJson,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : ownerUid = Value(ownerUid),
       feedType = Value(feedType),
       eventId = Value(eventId),
       eventTime = Value(eventTime),
       itemJson = Value(itemJson),
       updatedAt = Value(updatedAt);
  static Insertable<NotificationFeedItem> custom({
    Expression<int>? ownerUid,
    Expression<String>? feedType,
    Expression<int>? eventId,
    Expression<int>? eventTime,
    Expression<String>? itemJson,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (ownerUid != null) 'owner_uid': ownerUid,
      if (feedType != null) 'feed_type': feedType,
      if (eventId != null) 'event_id': eventId,
      if (eventTime != null) 'event_time': eventTime,
      if (itemJson != null) 'item_json': itemJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationFeedItemsCompanion copyWith({
    Value<int>? ownerUid,
    Value<String>? feedType,
    Value<int>? eventId,
    Value<int>? eventTime,
    Value<String>? itemJson,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return NotificationFeedItemsCompanion(
      ownerUid: ownerUid ?? this.ownerUid,
      feedType: feedType ?? this.feedType,
      eventId: eventId ?? this.eventId,
      eventTime: eventTime ?? this.eventTime,
      itemJson: itemJson ?? this.itemJson,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ownerUid.present) {
      map['owner_uid'] = Variable<int>(ownerUid.value);
    }
    if (feedType.present) {
      map['feed_type'] = Variable<String>(feedType.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<int>(eventId.value);
    }
    if (eventTime.present) {
      map['event_time'] = Variable<int>(eventTime.value);
    }
    if (itemJson.present) {
      map['item_json'] = Variable<String>(itemJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationFeedItemsCompanion(')
          ..write('ownerUid: $ownerUid, ')
          ..write('feedType: $feedType, ')
          ..write('eventId: $eventId, ')
          ..write('eventTime: $eventTime, ')
          ..write('itemJson: $itemJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationUnreadSummariesTable extends NotificationUnreadSummaries
    with TableInfo<$NotificationUnreadSummariesTable, NotificationUnreadSummary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationUnreadSummariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ownerUidMeta = const VerificationMeta('ownerUid');
  @override
  late final GeneratedColumn<int> ownerUid = GeneratedColumn<int>(
    'owner_uid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _summaryJsonMeta = const VerificationMeta('summaryJson');
  @override
  late final GeneratedColumn<String> summaryJson = GeneratedColumn<String>(
    'summary_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [ownerUid, summaryJson, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_unread_summaries';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationUnreadSummary> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('owner_uid')) {
      context.handle(
        _ownerUidMeta,
        ownerUid.isAcceptableOrUnknown(data['owner_uid']!, _ownerUidMeta),
      );
    }
    if (data.containsKey('summary_json')) {
      context.handle(
        _summaryJsonMeta,
        summaryJson.isAcceptableOrUnknown(data['summary_json']!, _summaryJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_summaryJsonMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ownerUid};
  @override
  NotificationUnreadSummary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationUnreadSummary(
      ownerUid: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}owner_uid'],
      )!,
      summaryJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NotificationUnreadSummariesTable createAlias(String alias) {
    return $NotificationUnreadSummariesTable(attachedDatabase, alias);
  }
}

class NotificationUnreadSummary extends DataClass
    implements Insertable<NotificationUnreadSummary> {
  final int ownerUid;
  final String summaryJson;
  final int updatedAt;
  const NotificationUnreadSummary({
    required this.ownerUid,
    required this.summaryJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['owner_uid'] = Variable<int>(ownerUid);
    map['summary_json'] = Variable<String>(summaryJson);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  NotificationUnreadSummariesCompanion toCompanion(bool nullToAbsent) {
    return NotificationUnreadSummariesCompanion(
      ownerUid: Value(ownerUid),
      summaryJson: Value(summaryJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory NotificationUnreadSummary.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationUnreadSummary(
      ownerUid: serializer.fromJson<int>(json['ownerUid']),
      summaryJson: serializer.fromJson<String>(json['summaryJson']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ownerUid': serializer.toJson<int>(ownerUid),
      'summaryJson': serializer.toJson<String>(summaryJson),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  NotificationUnreadSummary copyWith({
    int? ownerUid,
    String? summaryJson,
    int? updatedAt,
  }) => NotificationUnreadSummary(
    ownerUid: ownerUid ?? this.ownerUid,
    summaryJson: summaryJson ?? this.summaryJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NotificationUnreadSummary copyWithCompanion(NotificationUnreadSummariesCompanion data) {
    return NotificationUnreadSummary(
      ownerUid: data.ownerUid.present ? data.ownerUid.value : this.ownerUid,
      summaryJson: data.summaryJson.present ? data.summaryJson.value : this.summaryJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationUnreadSummary(')
          ..write('ownerUid: $ownerUid, ')
          ..write('summaryJson: $summaryJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(ownerUid, summaryJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationUnreadSummary &&
          other.ownerUid == this.ownerUid &&
          other.summaryJson == this.summaryJson &&
          other.updatedAt == this.updatedAt);
}

class NotificationUnreadSummariesCompanion
    extends UpdateCompanion<NotificationUnreadSummary> {
  final Value<int> ownerUid;
  final Value<String> summaryJson;
  final Value<int> updatedAt;
  const NotificationUnreadSummariesCompanion({
    this.ownerUid = const Value.absent(),
    this.summaryJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  NotificationUnreadSummariesCompanion.insert({
    this.ownerUid = const Value.absent(),
    required String summaryJson,
    required int updatedAt,
  }) : summaryJson = Value(summaryJson),
       updatedAt = Value(updatedAt);
  static Insertable<NotificationUnreadSummary> custom({
    Expression<int>? ownerUid,
    Expression<String>? summaryJson,
    Expression<int>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (ownerUid != null) 'owner_uid': ownerUid,
      if (summaryJson != null) 'summary_json': summaryJson,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  NotificationUnreadSummariesCompanion copyWith({
    Value<int>? ownerUid,
    Value<String>? summaryJson,
    Value<int>? updatedAt,
  }) {
    return NotificationUnreadSummariesCompanion(
      ownerUid: ownerUid ?? this.ownerUid,
      summaryJson: summaryJson ?? this.summaryJson,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ownerUid.present) {
      map['owner_uid'] = Variable<int>(ownerUid.value);
    }
    if (summaryJson.present) {
      map['summary_json'] = Variable<String>(summaryJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationUnreadSummariesCompanion(')
          ..write('ownerUid: $ownerUid, ')
          ..write('summaryJson: $summaryJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $NotificationSyncCursorsTable extends NotificationSyncCursors
    with TableInfo<$NotificationSyncCursorsTable, NotificationSyncCursor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationSyncCursorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ownerUidMeta = const VerificationMeta('ownerUid');
  @override
  late final GeneratedColumn<int> ownerUid = GeneratedColumn<int>(
    'owner_uid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cursorJsonMeta = const VerificationMeta('cursorJson');
  @override
  late final GeneratedColumn<String> cursorJson = GeneratedColumn<String>(
    'cursor_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hasMoreMeta = const VerificationMeta('hasMore');
  @override
  late final GeneratedColumn<bool> hasMore = GeneratedColumn<bool>(
    'has_more',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_more" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<int> lastSyncedAt = GeneratedColumn<int>(
    'last_synced_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    ownerUid,
    scope,
    cursorJson,
    hasMore,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_sync_cursors';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationSyncCursor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('owner_uid')) {
      context.handle(
        _ownerUidMeta,
        ownerUid.isAcceptableOrUnknown(data['owner_uid']!, _ownerUidMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerUidMeta);
    }
    if (data.containsKey('scope')) {
      context.handle(_scopeMeta, scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta));
    } else if (isInserting) {
      context.missing(_scopeMeta);
    }
    if (data.containsKey('cursor_json')) {
      context.handle(
        _cursorJsonMeta,
        cursorJson.isAcceptableOrUnknown(data['cursor_json']!, _cursorJsonMeta),
      );
    }
    if (data.containsKey('has_more')) {
      context.handle(
        _hasMoreMeta,
        hasMore.isAcceptableOrUnknown(data['has_more']!, _hasMoreMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(data['last_synced_at']!, _lastSyncedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ownerUid, scope};
  @override
  NotificationSyncCursor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationSyncCursor(
      ownerUid: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}owner_uid'],
      )!,
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      )!,
      cursorJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cursor_json'],
      ),
      hasMore: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_more'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_synced_at'],
      )!,
    );
  }

  @override
  $NotificationSyncCursorsTable createAlias(String alias) {
    return $NotificationSyncCursorsTable(attachedDatabase, alias);
  }
}

class NotificationSyncCursor extends DataClass
    implements Insertable<NotificationSyncCursor> {
  final int ownerUid;
  final String scope;
  final String? cursorJson;
  final bool hasMore;
  final int lastSyncedAt;
  const NotificationSyncCursor({
    required this.ownerUid,
    required this.scope,
    this.cursorJson,
    required this.hasMore,
    required this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['owner_uid'] = Variable<int>(ownerUid);
    map['scope'] = Variable<String>(scope);
    if (!nullToAbsent || cursorJson != null) {
      map['cursor_json'] = Variable<String>(cursorJson);
    }
    map['has_more'] = Variable<bool>(hasMore);
    map['last_synced_at'] = Variable<int>(lastSyncedAt);
    return map;
  }

  NotificationSyncCursorsCompanion toCompanion(bool nullToAbsent) {
    return NotificationSyncCursorsCompanion(
      ownerUid: Value(ownerUid),
      scope: Value(scope),
      cursorJson: cursorJson == null && nullToAbsent
          ? const Value.absent()
          : Value(cursorJson),
      hasMore: Value(hasMore),
      lastSyncedAt: Value(lastSyncedAt),
    );
  }

  factory NotificationSyncCursor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationSyncCursor(
      ownerUid: serializer.fromJson<int>(json['ownerUid']),
      scope: serializer.fromJson<String>(json['scope']),
      cursorJson: serializer.fromJson<String?>(json['cursorJson']),
      hasMore: serializer.fromJson<bool>(json['hasMore']),
      lastSyncedAt: serializer.fromJson<int>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ownerUid': serializer.toJson<int>(ownerUid),
      'scope': serializer.toJson<String>(scope),
      'cursorJson': serializer.toJson<String?>(cursorJson),
      'hasMore': serializer.toJson<bool>(hasMore),
      'lastSyncedAt': serializer.toJson<int>(lastSyncedAt),
    };
  }

  NotificationSyncCursor copyWith({
    int? ownerUid,
    String? scope,
    Value<String?> cursorJson = const Value.absent(),
    bool? hasMore,
    int? lastSyncedAt,
  }) => NotificationSyncCursor(
    ownerUid: ownerUid ?? this.ownerUid,
    scope: scope ?? this.scope,
    cursorJson: cursorJson.present ? cursorJson.value : this.cursorJson,
    hasMore: hasMore ?? this.hasMore,
    lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
  );
  NotificationSyncCursor copyWithCompanion(NotificationSyncCursorsCompanion data) {
    return NotificationSyncCursor(
      ownerUid: data.ownerUid.present ? data.ownerUid.value : this.ownerUid,
      scope: data.scope.present ? data.scope.value : this.scope,
      cursorJson: data.cursorJson.present ? data.cursorJson.value : this.cursorJson,
      hasMore: data.hasMore.present ? data.hasMore.value : this.hasMore,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationSyncCursor(')
          ..write('ownerUid: $ownerUid, ')
          ..write('scope: $scope, ')
          ..write('cursorJson: $cursorJson, ')
          ..write('hasMore: $hasMore, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(ownerUid, scope, cursorJson, hasMore, lastSyncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationSyncCursor &&
          other.ownerUid == this.ownerUid &&
          other.scope == this.scope &&
          other.cursorJson == this.cursorJson &&
          other.hasMore == this.hasMore &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class NotificationSyncCursorsCompanion extends UpdateCompanion<NotificationSyncCursor> {
  final Value<int> ownerUid;
  final Value<String> scope;
  final Value<String?> cursorJson;
  final Value<bool> hasMore;
  final Value<int> lastSyncedAt;
  final Value<int> rowid;
  const NotificationSyncCursorsCompanion({
    this.ownerUid = const Value.absent(),
    this.scope = const Value.absent(),
    this.cursorJson = const Value.absent(),
    this.hasMore = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationSyncCursorsCompanion.insert({
    required int ownerUid,
    required String scope,
    this.cursorJson = const Value.absent(),
    this.hasMore = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : ownerUid = Value(ownerUid),
       scope = Value(scope);
  static Insertable<NotificationSyncCursor> custom({
    Expression<int>? ownerUid,
    Expression<String>? scope,
    Expression<String>? cursorJson,
    Expression<bool>? hasMore,
    Expression<int>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (ownerUid != null) 'owner_uid': ownerUid,
      if (scope != null) 'scope': scope,
      if (cursorJson != null) 'cursor_json': cursorJson,
      if (hasMore != null) 'has_more': hasMore,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationSyncCursorsCompanion copyWith({
    Value<int>? ownerUid,
    Value<String>? scope,
    Value<String?>? cursorJson,
    Value<bool>? hasMore,
    Value<int>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return NotificationSyncCursorsCompanion(
      ownerUid: ownerUid ?? this.ownerUid,
      scope: scope ?? this.scope,
      cursorJson: cursorJson ?? this.cursorJson,
      hasMore: hasMore ?? this.hasMore,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ownerUid.present) {
      map['owner_uid'] = Variable<int>(ownerUid.value);
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (cursorJson.present) {
      map['cursor_json'] = Variable<String>(cursorJson.value);
    }
    if (hasMore.present) {
      map['has_more'] = Variable<bool>(hasMore.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<int>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationSyncCursorsCompanion(')
          ..write('ownerUid: $ownerUid, ')
          ..write('scope: $scope, ')
          ..write('cursorJson: $cursorJson, ')
          ..write('hasMore: $hasMore, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationOutboxTable extends NotificationOutbox
    with TableInfo<$NotificationOutboxTable, NotificationOutboxData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationOutboxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _ownerUidMeta = const VerificationMeta('ownerUid');
  @override
  late final GeneratedColumn<int> ownerUid = GeneratedColumn<int>(
    'owner_uid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionTypeMeta = const VerificationMeta('sessionType');
  @override
  late final GeneratedColumn<int> sessionType = GeneratedColumn<int>(
    'session_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _talkerIdMeta = const VerificationMeta('talkerId');
  @override
  late final GeneratedColumn<int> talkerId = GeneratedColumn<int>(
    'talker_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localMsgSeqnoMeta = const VerificationMeta(
    'localMsgSeqno',
  );
  @override
  late final GeneratedColumn<int> localMsgSeqno = GeneratedColumn<int>(
    'local_msg_seqno',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderUidMeta = const VerificationMeta('senderUid');
  @override
  late final GeneratedColumn<int> senderUid = GeneratedColumn<int>(
    'sender_uid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receiverTypeMeta = const VerificationMeta(
    'receiverType',
  );
  @override
  late final GeneratedColumn<int> receiverType = GeneratedColumn<int>(
    'receiver_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receiverIdMeta = const VerificationMeta('receiverId');
  @override
  late final GeneratedColumn<int> receiverId = GeneratedColumn<int>(
    'receiver_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _msgTypeMeta = const VerificationMeta('msgType');
  @override
  late final GeneratedColumn<int> msgType = GeneratedColumn<int>(
    'msg_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentJsonMeta = const VerificationMeta('contentJson');
  @override
  late final GeneratedColumn<String> contentJson = GeneratedColumn<String>(
    'content_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<int> timestamp = GeneratedColumn<int>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String> error = GeneratedColumn<String>(
    'error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _msgKeyMeta = const VerificationMeta('msgKey');
  @override
  late final GeneratedColumn<int> msgKey = GeneratedColumn<int>(
    'msg_key',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerUid,
    sessionType,
    talkerId,
    localMsgSeqno,
    senderUid,
    receiverType,
    receiverId,
    msgType,
    contentJson,
    timestamp,
    status,
    error,
    msgKey,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_outbox';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationOutboxData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('owner_uid')) {
      context.handle(
        _ownerUidMeta,
        ownerUid.isAcceptableOrUnknown(data['owner_uid']!, _ownerUidMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerUidMeta);
    }
    if (data.containsKey('session_type')) {
      context.handle(
        _sessionTypeMeta,
        sessionType.isAcceptableOrUnknown(data['session_type']!, _sessionTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionTypeMeta);
    }
    if (data.containsKey('talker_id')) {
      context.handle(
        _talkerIdMeta,
        talkerId.isAcceptableOrUnknown(data['talker_id']!, _talkerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_talkerIdMeta);
    }
    if (data.containsKey('local_msg_seqno')) {
      context.handle(
        _localMsgSeqnoMeta,
        localMsgSeqno.isAcceptableOrUnknown(data['local_msg_seqno']!, _localMsgSeqnoMeta),
      );
    } else if (isInserting) {
      context.missing(_localMsgSeqnoMeta);
    }
    if (data.containsKey('sender_uid')) {
      context.handle(
        _senderUidMeta,
        senderUid.isAcceptableOrUnknown(data['sender_uid']!, _senderUidMeta),
      );
    } else if (isInserting) {
      context.missing(_senderUidMeta);
    }
    if (data.containsKey('receiver_type')) {
      context.handle(
        _receiverTypeMeta,
        receiverType.isAcceptableOrUnknown(data['receiver_type']!, _receiverTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_receiverTypeMeta);
    }
    if (data.containsKey('receiver_id')) {
      context.handle(
        _receiverIdMeta,
        receiverId.isAcceptableOrUnknown(data['receiver_id']!, _receiverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_receiverIdMeta);
    }
    if (data.containsKey('msg_type')) {
      context.handle(
        _msgTypeMeta,
        msgType.isAcceptableOrUnknown(data['msg_type']!, _msgTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_msgTypeMeta);
    }
    if (data.containsKey('content_json')) {
      context.handle(
        _contentJsonMeta,
        contentJson.isAcceptableOrUnknown(data['content_json']!, _contentJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_contentJsonMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('error')) {
      context.handle(_errorMeta, error.isAcceptableOrUnknown(data['error']!, _errorMeta));
    }
    if (data.containsKey('msg_key')) {
      context.handle(
        _msgKeyMeta,
        msgKey.isAcceptableOrUnknown(data['msg_key']!, _msgKeyMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationOutboxData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationOutboxData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ownerUid: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}owner_uid'],
      )!,
      sessionType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_type'],
      )!,
      talkerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}talker_id'],
      )!,
      localMsgSeqno: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_msg_seqno'],
      )!,
      senderUid: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sender_uid'],
      )!,
      receiverType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}receiver_type'],
      )!,
      receiverId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}receiver_id'],
      )!,
      msgType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}msg_type'],
      )!,
      contentJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_json'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      error: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error'],
      ),
      msgKey: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}msg_key'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NotificationOutboxTable createAlias(String alias) {
    return $NotificationOutboxTable(attachedDatabase, alias);
  }
}

class NotificationOutboxData extends DataClass
    implements Insertable<NotificationOutboxData> {
  final int id;
  final int ownerUid;
  final int sessionType;
  final int talkerId;
  final int localMsgSeqno;
  final int senderUid;
  final int receiverType;
  final int receiverId;
  final int msgType;
  final String contentJson;
  final int timestamp;
  final String status;
  final String? error;
  final int? msgKey;
  final int createdAt;
  final int updatedAt;
  const NotificationOutboxData({
    required this.id,
    required this.ownerUid,
    required this.sessionType,
    required this.talkerId,
    required this.localMsgSeqno,
    required this.senderUid,
    required this.receiverType,
    required this.receiverId,
    required this.msgType,
    required this.contentJson,
    required this.timestamp,
    required this.status,
    this.error,
    this.msgKey,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['owner_uid'] = Variable<int>(ownerUid);
    map['session_type'] = Variable<int>(sessionType);
    map['talker_id'] = Variable<int>(talkerId);
    map['local_msg_seqno'] = Variable<int>(localMsgSeqno);
    map['sender_uid'] = Variable<int>(senderUid);
    map['receiver_type'] = Variable<int>(receiverType);
    map['receiver_id'] = Variable<int>(receiverId);
    map['msg_type'] = Variable<int>(msgType);
    map['content_json'] = Variable<String>(contentJson);
    map['timestamp'] = Variable<int>(timestamp);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || error != null) {
      map['error'] = Variable<String>(error);
    }
    if (!nullToAbsent || msgKey != null) {
      map['msg_key'] = Variable<int>(msgKey);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  NotificationOutboxCompanion toCompanion(bool nullToAbsent) {
    return NotificationOutboxCompanion(
      id: Value(id),
      ownerUid: Value(ownerUid),
      sessionType: Value(sessionType),
      talkerId: Value(talkerId),
      localMsgSeqno: Value(localMsgSeqno),
      senderUid: Value(senderUid),
      receiverType: Value(receiverType),
      receiverId: Value(receiverId),
      msgType: Value(msgType),
      contentJson: Value(contentJson),
      timestamp: Value(timestamp),
      status: Value(status),
      error: error == null && nullToAbsent ? const Value.absent() : Value(error),
      msgKey: msgKey == null && nullToAbsent ? const Value.absent() : Value(msgKey),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory NotificationOutboxData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationOutboxData(
      id: serializer.fromJson<int>(json['id']),
      ownerUid: serializer.fromJson<int>(json['ownerUid']),
      sessionType: serializer.fromJson<int>(json['sessionType']),
      talkerId: serializer.fromJson<int>(json['talkerId']),
      localMsgSeqno: serializer.fromJson<int>(json['localMsgSeqno']),
      senderUid: serializer.fromJson<int>(json['senderUid']),
      receiverType: serializer.fromJson<int>(json['receiverType']),
      receiverId: serializer.fromJson<int>(json['receiverId']),
      msgType: serializer.fromJson<int>(json['msgType']),
      contentJson: serializer.fromJson<String>(json['contentJson']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      status: serializer.fromJson<String>(json['status']),
      error: serializer.fromJson<String?>(json['error']),
      msgKey: serializer.fromJson<int?>(json['msgKey']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ownerUid': serializer.toJson<int>(ownerUid),
      'sessionType': serializer.toJson<int>(sessionType),
      'talkerId': serializer.toJson<int>(talkerId),
      'localMsgSeqno': serializer.toJson<int>(localMsgSeqno),
      'senderUid': serializer.toJson<int>(senderUid),
      'receiverType': serializer.toJson<int>(receiverType),
      'receiverId': serializer.toJson<int>(receiverId),
      'msgType': serializer.toJson<int>(msgType),
      'contentJson': serializer.toJson<String>(contentJson),
      'timestamp': serializer.toJson<int>(timestamp),
      'status': serializer.toJson<String>(status),
      'error': serializer.toJson<String?>(error),
      'msgKey': serializer.toJson<int?>(msgKey),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  NotificationOutboxData copyWith({
    int? id,
    int? ownerUid,
    int? sessionType,
    int? talkerId,
    int? localMsgSeqno,
    int? senderUid,
    int? receiverType,
    int? receiverId,
    int? msgType,
    String? contentJson,
    int? timestamp,
    String? status,
    Value<String?> error = const Value.absent(),
    Value<int?> msgKey = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => NotificationOutboxData(
    id: id ?? this.id,
    ownerUid: ownerUid ?? this.ownerUid,
    sessionType: sessionType ?? this.sessionType,
    talkerId: talkerId ?? this.talkerId,
    localMsgSeqno: localMsgSeqno ?? this.localMsgSeqno,
    senderUid: senderUid ?? this.senderUid,
    receiverType: receiverType ?? this.receiverType,
    receiverId: receiverId ?? this.receiverId,
    msgType: msgType ?? this.msgType,
    contentJson: contentJson ?? this.contentJson,
    timestamp: timestamp ?? this.timestamp,
    status: status ?? this.status,
    error: error.present ? error.value : this.error,
    msgKey: msgKey.present ? msgKey.value : this.msgKey,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NotificationOutboxData copyWithCompanion(NotificationOutboxCompanion data) {
    return NotificationOutboxData(
      id: data.id.present ? data.id.value : this.id,
      ownerUid: data.ownerUid.present ? data.ownerUid.value : this.ownerUid,
      sessionType: data.sessionType.present ? data.sessionType.value : this.sessionType,
      talkerId: data.talkerId.present ? data.talkerId.value : this.talkerId,
      localMsgSeqno: data.localMsgSeqno.present
          ? data.localMsgSeqno.value
          : this.localMsgSeqno,
      senderUid: data.senderUid.present ? data.senderUid.value : this.senderUid,
      receiverType: data.receiverType.present
          ? data.receiverType.value
          : this.receiverType,
      receiverId: data.receiverId.present ? data.receiverId.value : this.receiverId,
      msgType: data.msgType.present ? data.msgType.value : this.msgType,
      contentJson: data.contentJson.present ? data.contentJson.value : this.contentJson,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      status: data.status.present ? data.status.value : this.status,
      error: data.error.present ? data.error.value : this.error,
      msgKey: data.msgKey.present ? data.msgKey.value : this.msgKey,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationOutboxData(')
          ..write('id: $id, ')
          ..write('ownerUid: $ownerUid, ')
          ..write('sessionType: $sessionType, ')
          ..write('talkerId: $talkerId, ')
          ..write('localMsgSeqno: $localMsgSeqno, ')
          ..write('senderUid: $senderUid, ')
          ..write('receiverType: $receiverType, ')
          ..write('receiverId: $receiverId, ')
          ..write('msgType: $msgType, ')
          ..write('contentJson: $contentJson, ')
          ..write('timestamp: $timestamp, ')
          ..write('status: $status, ')
          ..write('error: $error, ')
          ..write('msgKey: $msgKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ownerUid,
    sessionType,
    talkerId,
    localMsgSeqno,
    senderUid,
    receiverType,
    receiverId,
    msgType,
    contentJson,
    timestamp,
    status,
    error,
    msgKey,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationOutboxData &&
          other.id == this.id &&
          other.ownerUid == this.ownerUid &&
          other.sessionType == this.sessionType &&
          other.talkerId == this.talkerId &&
          other.localMsgSeqno == this.localMsgSeqno &&
          other.senderUid == this.senderUid &&
          other.receiverType == this.receiverType &&
          other.receiverId == this.receiverId &&
          other.msgType == this.msgType &&
          other.contentJson == this.contentJson &&
          other.timestamp == this.timestamp &&
          other.status == this.status &&
          other.error == this.error &&
          other.msgKey == this.msgKey &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class NotificationOutboxCompanion extends UpdateCompanion<NotificationOutboxData> {
  final Value<int> id;
  final Value<int> ownerUid;
  final Value<int> sessionType;
  final Value<int> talkerId;
  final Value<int> localMsgSeqno;
  final Value<int> senderUid;
  final Value<int> receiverType;
  final Value<int> receiverId;
  final Value<int> msgType;
  final Value<String> contentJson;
  final Value<int> timestamp;
  final Value<String> status;
  final Value<String?> error;
  final Value<int?> msgKey;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  const NotificationOutboxCompanion({
    this.id = const Value.absent(),
    this.ownerUid = const Value.absent(),
    this.sessionType = const Value.absent(),
    this.talkerId = const Value.absent(),
    this.localMsgSeqno = const Value.absent(),
    this.senderUid = const Value.absent(),
    this.receiverType = const Value.absent(),
    this.receiverId = const Value.absent(),
    this.msgType = const Value.absent(),
    this.contentJson = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.status = const Value.absent(),
    this.error = const Value.absent(),
    this.msgKey = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  NotificationOutboxCompanion.insert({
    this.id = const Value.absent(),
    required int ownerUid,
    required int sessionType,
    required int talkerId,
    required int localMsgSeqno,
    required int senderUid,
    required int receiverType,
    required int receiverId,
    required int msgType,
    required String contentJson,
    required int timestamp,
    this.status = const Value.absent(),
    this.error = const Value.absent(),
    this.msgKey = const Value.absent(),
    required int createdAt,
    required int updatedAt,
  }) : ownerUid = Value(ownerUid),
       sessionType = Value(sessionType),
       talkerId = Value(talkerId),
       localMsgSeqno = Value(localMsgSeqno),
       senderUid = Value(senderUid),
       receiverType = Value(receiverType),
       receiverId = Value(receiverId),
       msgType = Value(msgType),
       contentJson = Value(contentJson),
       timestamp = Value(timestamp),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<NotificationOutboxData> custom({
    Expression<int>? id,
    Expression<int>? ownerUid,
    Expression<int>? sessionType,
    Expression<int>? talkerId,
    Expression<int>? localMsgSeqno,
    Expression<int>? senderUid,
    Expression<int>? receiverType,
    Expression<int>? receiverId,
    Expression<int>? msgType,
    Expression<String>? contentJson,
    Expression<int>? timestamp,
    Expression<String>? status,
    Expression<String>? error,
    Expression<int>? msgKey,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerUid != null) 'owner_uid': ownerUid,
      if (sessionType != null) 'session_type': sessionType,
      if (talkerId != null) 'talker_id': talkerId,
      if (localMsgSeqno != null) 'local_msg_seqno': localMsgSeqno,
      if (senderUid != null) 'sender_uid': senderUid,
      if (receiverType != null) 'receiver_type': receiverType,
      if (receiverId != null) 'receiver_id': receiverId,
      if (msgType != null) 'msg_type': msgType,
      if (contentJson != null) 'content_json': contentJson,
      if (timestamp != null) 'timestamp': timestamp,
      if (status != null) 'status': status,
      if (error != null) 'error': error,
      if (msgKey != null) 'msg_key': msgKey,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  NotificationOutboxCompanion copyWith({
    Value<int>? id,
    Value<int>? ownerUid,
    Value<int>? sessionType,
    Value<int>? talkerId,
    Value<int>? localMsgSeqno,
    Value<int>? senderUid,
    Value<int>? receiverType,
    Value<int>? receiverId,
    Value<int>? msgType,
    Value<String>? contentJson,
    Value<int>? timestamp,
    Value<String>? status,
    Value<String?>? error,
    Value<int?>? msgKey,
    Value<int>? createdAt,
    Value<int>? updatedAt,
  }) {
    return NotificationOutboxCompanion(
      id: id ?? this.id,
      ownerUid: ownerUid ?? this.ownerUid,
      sessionType: sessionType ?? this.sessionType,
      talkerId: talkerId ?? this.talkerId,
      localMsgSeqno: localMsgSeqno ?? this.localMsgSeqno,
      senderUid: senderUid ?? this.senderUid,
      receiverType: receiverType ?? this.receiverType,
      receiverId: receiverId ?? this.receiverId,
      msgType: msgType ?? this.msgType,
      contentJson: contentJson ?? this.contentJson,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      error: error ?? this.error,
      msgKey: msgKey ?? this.msgKey,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ownerUid.present) {
      map['owner_uid'] = Variable<int>(ownerUid.value);
    }
    if (sessionType.present) {
      map['session_type'] = Variable<int>(sessionType.value);
    }
    if (talkerId.present) {
      map['talker_id'] = Variable<int>(talkerId.value);
    }
    if (localMsgSeqno.present) {
      map['local_msg_seqno'] = Variable<int>(localMsgSeqno.value);
    }
    if (senderUid.present) {
      map['sender_uid'] = Variable<int>(senderUid.value);
    }
    if (receiverType.present) {
      map['receiver_type'] = Variable<int>(receiverType.value);
    }
    if (receiverId.present) {
      map['receiver_id'] = Variable<int>(receiverId.value);
    }
    if (msgType.present) {
      map['msg_type'] = Variable<int>(msgType.value);
    }
    if (contentJson.present) {
      map['content_json'] = Variable<String>(contentJson.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (error.present) {
      map['error'] = Variable<String>(error.value);
    }
    if (msgKey.present) {
      map['msg_key'] = Variable<int>(msgKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationOutboxCompanion(')
          ..write('id: $id, ')
          ..write('ownerUid: $ownerUid, ')
          ..write('sessionType: $sessionType, ')
          ..write('talkerId: $talkerId, ')
          ..write('localMsgSeqno: $localMsgSeqno, ')
          ..write('senderUid: $senderUid, ')
          ..write('receiverType: $receiverType, ')
          ..write('receiverId: $receiverId, ')
          ..write('msgType: $msgType, ')
          ..write('contentJson: $contentJson, ')
          ..write('timestamp: $timestamp, ')
          ..write('status: $status, ')
          ..write('error: $error, ')
          ..write('msgKey: $msgKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$NotificationLocalDatabase extends GeneratedDatabase {
  _$NotificationLocalDatabase(QueryExecutor e) : super(e);
  $NotificationLocalDatabaseManager get managers =>
      $NotificationLocalDatabaseManager(this);
  late final $NotificationMessagesTable notificationMessages = $NotificationMessagesTable(
    this,
  );
  late final $NotificationMessageEmojisTable notificationMessageEmojis =
      $NotificationMessageEmojisTable(this);
  late final $NotificationSessionsTable notificationSessions = $NotificationSessionsTable(
    this,
  );
  late final $NotificationFeedItemsTable notificationFeedItems =
      $NotificationFeedItemsTable(this);
  late final $NotificationUnreadSummariesTable notificationUnreadSummaries =
      $NotificationUnreadSummariesTable(this);
  late final $NotificationSyncCursorsTable notificationSyncCursors =
      $NotificationSyncCursorsTable(this);
  late final $NotificationOutboxTable notificationOutbox = $NotificationOutboxTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    notificationMessages,
    notificationMessageEmojis,
    notificationSessions,
    notificationFeedItems,
    notificationUnreadSummaries,
    notificationSyncCursors,
    notificationOutbox,
  ];
}

typedef $$NotificationMessagesTableCreateCompanionBuilder =
    NotificationMessagesCompanion Function({
      required int ownerUid,
      required int sessionType,
      required int talkerId,
      required int msgSeqno,
      required int senderUid,
      required int receiverType,
      required int receiverId,
      required int msgType,
      required String contentJson,
      required int timestamp,
      Value<String?> atUidsJson,
      Value<int?> msgKey,
      Value<int?> msgStatus,
      Value<String?> notifyCode,
      Value<int?> newFaceVersion,
      Value<int?> msgSource,
      Value<String> syncStatus,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$NotificationMessagesTableUpdateCompanionBuilder =
    NotificationMessagesCompanion Function({
      Value<int> ownerUid,
      Value<int> sessionType,
      Value<int> talkerId,
      Value<int> msgSeqno,
      Value<int> senderUid,
      Value<int> receiverType,
      Value<int> receiverId,
      Value<int> msgType,
      Value<String> contentJson,
      Value<int> timestamp,
      Value<String?> atUidsJson,
      Value<int?> msgKey,
      Value<int?> msgStatus,
      Value<String?> notifyCode,
      Value<int?> newFaceVersion,
      Value<int?> msgSource,
      Value<String> syncStatus,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$NotificationMessagesTableFilterComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationMessagesTable> {
  $$NotificationMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sessionType => $composableBuilder(
    column: $table.sessionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get talkerId => $composableBuilder(
    column: $table.talkerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get msgSeqno => $composableBuilder(
    column: $table.msgSeqno,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get senderUid => $composableBuilder(
    column: $table.senderUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get receiverType => $composableBuilder(
    column: $table.receiverType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get receiverId => $composableBuilder(
    column: $table.receiverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get msgType => $composableBuilder(
    column: $table.msgType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentJson => $composableBuilder(
    column: $table.contentJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get atUidsJson => $composableBuilder(
    column: $table.atUidsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get msgKey => $composableBuilder(
    column: $table.msgKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get msgStatus => $composableBuilder(
    column: $table.msgStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notifyCode => $composableBuilder(
    column: $table.notifyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get newFaceVersion => $composableBuilder(
    column: $table.newFaceVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get msgSource => $composableBuilder(
    column: $table.msgSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationMessagesTableOrderingComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationMessagesTable> {
  $$NotificationMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sessionType => $composableBuilder(
    column: $table.sessionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get talkerId => $composableBuilder(
    column: $table.talkerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get msgSeqno => $composableBuilder(
    column: $table.msgSeqno,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get senderUid => $composableBuilder(
    column: $table.senderUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get receiverType => $composableBuilder(
    column: $table.receiverType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get receiverId => $composableBuilder(
    column: $table.receiverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get msgType => $composableBuilder(
    column: $table.msgType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentJson => $composableBuilder(
    column: $table.contentJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get atUidsJson => $composableBuilder(
    column: $table.atUidsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get msgKey => $composableBuilder(
    column: $table.msgKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get msgStatus => $composableBuilder(
    column: $table.msgStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notifyCode => $composableBuilder(
    column: $table.notifyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get newFaceVersion => $composableBuilder(
    column: $table.newFaceVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get msgSource => $composableBuilder(
    column: $table.msgSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationMessagesTableAnnotationComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationMessagesTable> {
  $$NotificationMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get ownerUid =>
      $composableBuilder(column: $table.ownerUid, builder: (column) => column);

  GeneratedColumn<int> get sessionType =>
      $composableBuilder(column: $table.sessionType, builder: (column) => column);

  GeneratedColumn<int> get talkerId =>
      $composableBuilder(column: $table.talkerId, builder: (column) => column);

  GeneratedColumn<int> get msgSeqno =>
      $composableBuilder(column: $table.msgSeqno, builder: (column) => column);

  GeneratedColumn<int> get senderUid =>
      $composableBuilder(column: $table.senderUid, builder: (column) => column);

  GeneratedColumn<int> get receiverType =>
      $composableBuilder(column: $table.receiverType, builder: (column) => column);

  GeneratedColumn<int> get receiverId =>
      $composableBuilder(column: $table.receiverId, builder: (column) => column);

  GeneratedColumn<int> get msgType =>
      $composableBuilder(column: $table.msgType, builder: (column) => column);

  GeneratedColumn<String> get contentJson =>
      $composableBuilder(column: $table.contentJson, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get atUidsJson =>
      $composableBuilder(column: $table.atUidsJson, builder: (column) => column);

  GeneratedColumn<int> get msgKey =>
      $composableBuilder(column: $table.msgKey, builder: (column) => column);

  GeneratedColumn<int> get msgStatus =>
      $composableBuilder(column: $table.msgStatus, builder: (column) => column);

  GeneratedColumn<String> get notifyCode =>
      $composableBuilder(column: $table.notifyCode, builder: (column) => column);

  GeneratedColumn<int> get newFaceVersion =>
      $composableBuilder(column: $table.newFaceVersion, builder: (column) => column);

  GeneratedColumn<int> get msgSource =>
      $composableBuilder(column: $table.msgSource, builder: (column) => column);

  GeneratedColumn<String> get syncStatus =>
      $composableBuilder(column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NotificationMessagesTableTableManager
    extends
        RootTableManager<
          _$NotificationLocalDatabase,
          $NotificationMessagesTable,
          NotificationMessage,
          $$NotificationMessagesTableFilterComposer,
          $$NotificationMessagesTableOrderingComposer,
          $$NotificationMessagesTableAnnotationComposer,
          $$NotificationMessagesTableCreateCompanionBuilder,
          $$NotificationMessagesTableUpdateCompanionBuilder,
          (
            NotificationMessage,
            BaseReferences<
              _$NotificationLocalDatabase,
              $NotificationMessagesTable,
              NotificationMessage
            >,
          ),
          NotificationMessage,
          PrefetchHooks Function()
        > {
  $$NotificationMessagesTableTableManager(
    _$NotificationLocalDatabase db,
    $NotificationMessagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> ownerUid = const Value.absent(),
                Value<int> sessionType = const Value.absent(),
                Value<int> talkerId = const Value.absent(),
                Value<int> msgSeqno = const Value.absent(),
                Value<int> senderUid = const Value.absent(),
                Value<int> receiverType = const Value.absent(),
                Value<int> receiverId = const Value.absent(),
                Value<int> msgType = const Value.absent(),
                Value<String> contentJson = const Value.absent(),
                Value<int> timestamp = const Value.absent(),
                Value<String?> atUidsJson = const Value.absent(),
                Value<int?> msgKey = const Value.absent(),
                Value<int?> msgStatus = const Value.absent(),
                Value<String?> notifyCode = const Value.absent(),
                Value<int?> newFaceVersion = const Value.absent(),
                Value<int?> msgSource = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationMessagesCompanion(
                ownerUid: ownerUid,
                sessionType: sessionType,
                talkerId: talkerId,
                msgSeqno: msgSeqno,
                senderUid: senderUid,
                receiverType: receiverType,
                receiverId: receiverId,
                msgType: msgType,
                contentJson: contentJson,
                timestamp: timestamp,
                atUidsJson: atUidsJson,
                msgKey: msgKey,
                msgStatus: msgStatus,
                notifyCode: notifyCode,
                newFaceVersion: newFaceVersion,
                msgSource: msgSource,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int ownerUid,
                required int sessionType,
                required int talkerId,
                required int msgSeqno,
                required int senderUid,
                required int receiverType,
                required int receiverId,
                required int msgType,
                required String contentJson,
                required int timestamp,
                Value<String?> atUidsJson = const Value.absent(),
                Value<int?> msgKey = const Value.absent(),
                Value<int?> msgStatus = const Value.absent(),
                Value<String?> notifyCode = const Value.absent(),
                Value<int?> newFaceVersion = const Value.absent(),
                Value<int?> msgSource = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => NotificationMessagesCompanion.insert(
                ownerUid: ownerUid,
                sessionType: sessionType,
                talkerId: talkerId,
                msgSeqno: msgSeqno,
                senderUid: senderUid,
                receiverType: receiverType,
                receiverId: receiverId,
                msgType: msgType,
                contentJson: contentJson,
                timestamp: timestamp,
                atUidsJson: atUidsJson,
                msgKey: msgKey,
                msgStatus: msgStatus,
                notifyCode: notifyCode,
                newFaceVersion: newFaceVersion,
                msgSource: msgSource,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$NotificationLocalDatabase,
      $NotificationMessagesTable,
      NotificationMessage,
      $$NotificationMessagesTableFilterComposer,
      $$NotificationMessagesTableOrderingComposer,
      $$NotificationMessagesTableAnnotationComposer,
      $$NotificationMessagesTableCreateCompanionBuilder,
      $$NotificationMessagesTableUpdateCompanionBuilder,
      (
        NotificationMessage,
        BaseReferences<
          _$NotificationLocalDatabase,
          $NotificationMessagesTable,
          NotificationMessage
        >,
      ),
      NotificationMessage,
      PrefetchHooks Function()
    >;
typedef $$NotificationMessageEmojisTableCreateCompanionBuilder =
    NotificationMessageEmojisCompanion Function({
      required int ownerUid,
      required int sessionType,
      required int talkerId,
      required String emojiText,
      required String emojiUrl,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$NotificationMessageEmojisTableUpdateCompanionBuilder =
    NotificationMessageEmojisCompanion Function({
      Value<int> ownerUid,
      Value<int> sessionType,
      Value<int> talkerId,
      Value<String> emojiText,
      Value<String> emojiUrl,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$NotificationMessageEmojisTableFilterComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationMessageEmojisTable> {
  $$NotificationMessageEmojisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sessionType => $composableBuilder(
    column: $table.sessionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get talkerId => $composableBuilder(
    column: $table.talkerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emojiText => $composableBuilder(
    column: $table.emojiText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emojiUrl => $composableBuilder(
    column: $table.emojiUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationMessageEmojisTableOrderingComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationMessageEmojisTable> {
  $$NotificationMessageEmojisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sessionType => $composableBuilder(
    column: $table.sessionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get talkerId => $composableBuilder(
    column: $table.talkerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emojiText => $composableBuilder(
    column: $table.emojiText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emojiUrl => $composableBuilder(
    column: $table.emojiUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationMessageEmojisTableAnnotationComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationMessageEmojisTable> {
  $$NotificationMessageEmojisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get ownerUid =>
      $composableBuilder(column: $table.ownerUid, builder: (column) => column);

  GeneratedColumn<int> get sessionType =>
      $composableBuilder(column: $table.sessionType, builder: (column) => column);

  GeneratedColumn<int> get talkerId =>
      $composableBuilder(column: $table.talkerId, builder: (column) => column);

  GeneratedColumn<String> get emojiText =>
      $composableBuilder(column: $table.emojiText, builder: (column) => column);

  GeneratedColumn<String> get emojiUrl =>
      $composableBuilder(column: $table.emojiUrl, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NotificationMessageEmojisTableTableManager
    extends
        RootTableManager<
          _$NotificationLocalDatabase,
          $NotificationMessageEmojisTable,
          NotificationMessageEmoji,
          $$NotificationMessageEmojisTableFilterComposer,
          $$NotificationMessageEmojisTableOrderingComposer,
          $$NotificationMessageEmojisTableAnnotationComposer,
          $$NotificationMessageEmojisTableCreateCompanionBuilder,
          $$NotificationMessageEmojisTableUpdateCompanionBuilder,
          (
            NotificationMessageEmoji,
            BaseReferences<
              _$NotificationLocalDatabase,
              $NotificationMessageEmojisTable,
              NotificationMessageEmoji
            >,
          ),
          NotificationMessageEmoji,
          PrefetchHooks Function()
        > {
  $$NotificationMessageEmojisTableTableManager(
    _$NotificationLocalDatabase db,
    $NotificationMessageEmojisTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationMessageEmojisTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationMessageEmojisTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationMessageEmojisTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> ownerUid = const Value.absent(),
                Value<int> sessionType = const Value.absent(),
                Value<int> talkerId = const Value.absent(),
                Value<String> emojiText = const Value.absent(),
                Value<String> emojiUrl = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationMessageEmojisCompanion(
                ownerUid: ownerUid,
                sessionType: sessionType,
                talkerId: talkerId,
                emojiText: emojiText,
                emojiUrl: emojiUrl,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int ownerUid,
                required int sessionType,
                required int talkerId,
                required String emojiText,
                required String emojiUrl,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => NotificationMessageEmojisCompanion.insert(
                ownerUid: ownerUid,
                sessionType: sessionType,
                talkerId: talkerId,
                emojiText: emojiText,
                emojiUrl: emojiUrl,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationMessageEmojisTableProcessedTableManager =
    ProcessedTableManager<
      _$NotificationLocalDatabase,
      $NotificationMessageEmojisTable,
      NotificationMessageEmoji,
      $$NotificationMessageEmojisTableFilterComposer,
      $$NotificationMessageEmojisTableOrderingComposer,
      $$NotificationMessageEmojisTableAnnotationComposer,
      $$NotificationMessageEmojisTableCreateCompanionBuilder,
      $$NotificationMessageEmojisTableUpdateCompanionBuilder,
      (
        NotificationMessageEmoji,
        BaseReferences<
          _$NotificationLocalDatabase,
          $NotificationMessageEmojisTable,
          NotificationMessageEmoji
        >,
      ),
      NotificationMessageEmoji,
      PrefetchHooks Function()
    >;
typedef $$NotificationSessionsTableCreateCompanionBuilder =
    NotificationSessionsCompanion Function({
      required int ownerUid,
      required int sessionType,
      required int talkerId,
      Value<int> unreadCount,
      required int sessionTs,
      required String sessionJson,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$NotificationSessionsTableUpdateCompanionBuilder =
    NotificationSessionsCompanion Function({
      Value<int> ownerUid,
      Value<int> sessionType,
      Value<int> talkerId,
      Value<int> unreadCount,
      Value<int> sessionTs,
      Value<String> sessionJson,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$NotificationSessionsTableFilterComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationSessionsTable> {
  $$NotificationSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sessionType => $composableBuilder(
    column: $table.sessionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get talkerId => $composableBuilder(
    column: $table.talkerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sessionTs => $composableBuilder(
    column: $table.sessionTs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionJson => $composableBuilder(
    column: $table.sessionJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationSessionsTableOrderingComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationSessionsTable> {
  $$NotificationSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sessionType => $composableBuilder(
    column: $table.sessionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get talkerId => $composableBuilder(
    column: $table.talkerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sessionTs => $composableBuilder(
    column: $table.sessionTs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionJson => $composableBuilder(
    column: $table.sessionJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationSessionsTableAnnotationComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationSessionsTable> {
  $$NotificationSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get ownerUid =>
      $composableBuilder(column: $table.ownerUid, builder: (column) => column);

  GeneratedColumn<int> get sessionType =>
      $composableBuilder(column: $table.sessionType, builder: (column) => column);

  GeneratedColumn<int> get talkerId =>
      $composableBuilder(column: $table.talkerId, builder: (column) => column);

  GeneratedColumn<int> get unreadCount =>
      $composableBuilder(column: $table.unreadCount, builder: (column) => column);

  GeneratedColumn<int> get sessionTs =>
      $composableBuilder(column: $table.sessionTs, builder: (column) => column);

  GeneratedColumn<String> get sessionJson =>
      $composableBuilder(column: $table.sessionJson, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NotificationSessionsTableTableManager
    extends
        RootTableManager<
          _$NotificationLocalDatabase,
          $NotificationSessionsTable,
          NotificationSession,
          $$NotificationSessionsTableFilterComposer,
          $$NotificationSessionsTableOrderingComposer,
          $$NotificationSessionsTableAnnotationComposer,
          $$NotificationSessionsTableCreateCompanionBuilder,
          $$NotificationSessionsTableUpdateCompanionBuilder,
          (
            NotificationSession,
            BaseReferences<
              _$NotificationLocalDatabase,
              $NotificationSessionsTable,
              NotificationSession
            >,
          ),
          NotificationSession,
          PrefetchHooks Function()
        > {
  $$NotificationSessionsTableTableManager(
    _$NotificationLocalDatabase db,
    $NotificationSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> ownerUid = const Value.absent(),
                Value<int> sessionType = const Value.absent(),
                Value<int> talkerId = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<int> sessionTs = const Value.absent(),
                Value<String> sessionJson = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationSessionsCompanion(
                ownerUid: ownerUid,
                sessionType: sessionType,
                talkerId: talkerId,
                unreadCount: unreadCount,
                sessionTs: sessionTs,
                sessionJson: sessionJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int ownerUid,
                required int sessionType,
                required int talkerId,
                Value<int> unreadCount = const Value.absent(),
                required int sessionTs,
                required String sessionJson,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => NotificationSessionsCompanion.insert(
                ownerUid: ownerUid,
                sessionType: sessionType,
                talkerId: talkerId,
                unreadCount: unreadCount,
                sessionTs: sessionTs,
                sessionJson: sessionJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$NotificationLocalDatabase,
      $NotificationSessionsTable,
      NotificationSession,
      $$NotificationSessionsTableFilterComposer,
      $$NotificationSessionsTableOrderingComposer,
      $$NotificationSessionsTableAnnotationComposer,
      $$NotificationSessionsTableCreateCompanionBuilder,
      $$NotificationSessionsTableUpdateCompanionBuilder,
      (
        NotificationSession,
        BaseReferences<
          _$NotificationLocalDatabase,
          $NotificationSessionsTable,
          NotificationSession
        >,
      ),
      NotificationSession,
      PrefetchHooks Function()
    >;
typedef $$NotificationFeedItemsTableCreateCompanionBuilder =
    NotificationFeedItemsCompanion Function({
      required int ownerUid,
      required String feedType,
      required int eventId,
      required int eventTime,
      required String itemJson,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$NotificationFeedItemsTableUpdateCompanionBuilder =
    NotificationFeedItemsCompanion Function({
      Value<int> ownerUid,
      Value<String> feedType,
      Value<int> eventId,
      Value<int> eventTime,
      Value<String> itemJson,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$NotificationFeedItemsTableFilterComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationFeedItemsTable> {
  $$NotificationFeedItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get feedType => $composableBuilder(
    column: $table.feedType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get eventTime => $composableBuilder(
    column: $table.eventTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemJson => $composableBuilder(
    column: $table.itemJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationFeedItemsTableOrderingComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationFeedItemsTable> {
  $$NotificationFeedItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feedType => $composableBuilder(
    column: $table.feedType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get eventTime => $composableBuilder(
    column: $table.eventTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemJson => $composableBuilder(
    column: $table.itemJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationFeedItemsTableAnnotationComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationFeedItemsTable> {
  $$NotificationFeedItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get ownerUid =>
      $composableBuilder(column: $table.ownerUid, builder: (column) => column);

  GeneratedColumn<String> get feedType =>
      $composableBuilder(column: $table.feedType, builder: (column) => column);

  GeneratedColumn<int> get eventId =>
      $composableBuilder(column: $table.eventId, builder: (column) => column);

  GeneratedColumn<int> get eventTime =>
      $composableBuilder(column: $table.eventTime, builder: (column) => column);

  GeneratedColumn<String> get itemJson =>
      $composableBuilder(column: $table.itemJson, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NotificationFeedItemsTableTableManager
    extends
        RootTableManager<
          _$NotificationLocalDatabase,
          $NotificationFeedItemsTable,
          NotificationFeedItem,
          $$NotificationFeedItemsTableFilterComposer,
          $$NotificationFeedItemsTableOrderingComposer,
          $$NotificationFeedItemsTableAnnotationComposer,
          $$NotificationFeedItemsTableCreateCompanionBuilder,
          $$NotificationFeedItemsTableUpdateCompanionBuilder,
          (
            NotificationFeedItem,
            BaseReferences<
              _$NotificationLocalDatabase,
              $NotificationFeedItemsTable,
              NotificationFeedItem
            >,
          ),
          NotificationFeedItem,
          PrefetchHooks Function()
        > {
  $$NotificationFeedItemsTableTableManager(
    _$NotificationLocalDatabase db,
    $NotificationFeedItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationFeedItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationFeedItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationFeedItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> ownerUid = const Value.absent(),
                Value<String> feedType = const Value.absent(),
                Value<int> eventId = const Value.absent(),
                Value<int> eventTime = const Value.absent(),
                Value<String> itemJson = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationFeedItemsCompanion(
                ownerUid: ownerUid,
                feedType: feedType,
                eventId: eventId,
                eventTime: eventTime,
                itemJson: itemJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int ownerUid,
                required String feedType,
                required int eventId,
                required int eventTime,
                required String itemJson,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => NotificationFeedItemsCompanion.insert(
                ownerUid: ownerUid,
                feedType: feedType,
                eventId: eventId,
                eventTime: eventTime,
                itemJson: itemJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationFeedItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$NotificationLocalDatabase,
      $NotificationFeedItemsTable,
      NotificationFeedItem,
      $$NotificationFeedItemsTableFilterComposer,
      $$NotificationFeedItemsTableOrderingComposer,
      $$NotificationFeedItemsTableAnnotationComposer,
      $$NotificationFeedItemsTableCreateCompanionBuilder,
      $$NotificationFeedItemsTableUpdateCompanionBuilder,
      (
        NotificationFeedItem,
        BaseReferences<
          _$NotificationLocalDatabase,
          $NotificationFeedItemsTable,
          NotificationFeedItem
        >,
      ),
      NotificationFeedItem,
      PrefetchHooks Function()
    >;
typedef $$NotificationUnreadSummariesTableCreateCompanionBuilder =
    NotificationUnreadSummariesCompanion Function({
      Value<int> ownerUid,
      required String summaryJson,
      required int updatedAt,
    });
typedef $$NotificationUnreadSummariesTableUpdateCompanionBuilder =
    NotificationUnreadSummariesCompanion Function({
      Value<int> ownerUid,
      Value<String> summaryJson,
      Value<int> updatedAt,
    });

class $$NotificationUnreadSummariesTableFilterComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationUnreadSummariesTable> {
  $$NotificationUnreadSummariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summaryJson => $composableBuilder(
    column: $table.summaryJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationUnreadSummariesTableOrderingComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationUnreadSummariesTable> {
  $$NotificationUnreadSummariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summaryJson => $composableBuilder(
    column: $table.summaryJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationUnreadSummariesTableAnnotationComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationUnreadSummariesTable> {
  $$NotificationUnreadSummariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get ownerUid =>
      $composableBuilder(column: $table.ownerUid, builder: (column) => column);

  GeneratedColumn<String> get summaryJson =>
      $composableBuilder(column: $table.summaryJson, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NotificationUnreadSummariesTableTableManager
    extends
        RootTableManager<
          _$NotificationLocalDatabase,
          $NotificationUnreadSummariesTable,
          NotificationUnreadSummary,
          $$NotificationUnreadSummariesTableFilterComposer,
          $$NotificationUnreadSummariesTableOrderingComposer,
          $$NotificationUnreadSummariesTableAnnotationComposer,
          $$NotificationUnreadSummariesTableCreateCompanionBuilder,
          $$NotificationUnreadSummariesTableUpdateCompanionBuilder,
          (
            NotificationUnreadSummary,
            BaseReferences<
              _$NotificationLocalDatabase,
              $NotificationUnreadSummariesTable,
              NotificationUnreadSummary
            >,
          ),
          NotificationUnreadSummary,
          PrefetchHooks Function()
        > {
  $$NotificationUnreadSummariesTableTableManager(
    _$NotificationLocalDatabase db,
    $NotificationUnreadSummariesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationUnreadSummariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationUnreadSummariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationUnreadSummariesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> ownerUid = const Value.absent(),
                Value<String> summaryJson = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
              }) => NotificationUnreadSummariesCompanion(
                ownerUid: ownerUid,
                summaryJson: summaryJson,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> ownerUid = const Value.absent(),
                required String summaryJson,
                required int updatedAt,
              }) => NotificationUnreadSummariesCompanion.insert(
                ownerUid: ownerUid,
                summaryJson: summaryJson,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationUnreadSummariesTableProcessedTableManager =
    ProcessedTableManager<
      _$NotificationLocalDatabase,
      $NotificationUnreadSummariesTable,
      NotificationUnreadSummary,
      $$NotificationUnreadSummariesTableFilterComposer,
      $$NotificationUnreadSummariesTableOrderingComposer,
      $$NotificationUnreadSummariesTableAnnotationComposer,
      $$NotificationUnreadSummariesTableCreateCompanionBuilder,
      $$NotificationUnreadSummariesTableUpdateCompanionBuilder,
      (
        NotificationUnreadSummary,
        BaseReferences<
          _$NotificationLocalDatabase,
          $NotificationUnreadSummariesTable,
          NotificationUnreadSummary
        >,
      ),
      NotificationUnreadSummary,
      PrefetchHooks Function()
    >;
typedef $$NotificationSyncCursorsTableCreateCompanionBuilder =
    NotificationSyncCursorsCompanion Function({
      required int ownerUid,
      required String scope,
      Value<String?> cursorJson,
      Value<bool> hasMore,
      Value<int> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$NotificationSyncCursorsTableUpdateCompanionBuilder =
    NotificationSyncCursorsCompanion Function({
      Value<int> ownerUid,
      Value<String> scope,
      Value<String?> cursorJson,
      Value<bool> hasMore,
      Value<int> lastSyncedAt,
      Value<int> rowid,
    });

class $$NotificationSyncCursorsTableFilterComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationSyncCursorsTable> {
  $$NotificationSyncCursorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cursorJson => $composableBuilder(
    column: $table.cursorJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasMore => $composableBuilder(
    column: $table.hasMore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationSyncCursorsTableOrderingComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationSyncCursorsTable> {
  $$NotificationSyncCursorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cursorJson => $composableBuilder(
    column: $table.cursorJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasMore => $composableBuilder(
    column: $table.hasMore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationSyncCursorsTableAnnotationComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationSyncCursorsTable> {
  $$NotificationSyncCursorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get ownerUid =>
      $composableBuilder(column: $table.ownerUid, builder: (column) => column);

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<String> get cursorJson =>
      $composableBuilder(column: $table.cursorJson, builder: (column) => column);

  GeneratedColumn<bool> get hasMore =>
      $composableBuilder(column: $table.hasMore, builder: (column) => column);

  GeneratedColumn<int> get lastSyncedAt =>
      $composableBuilder(column: $table.lastSyncedAt, builder: (column) => column);
}

class $$NotificationSyncCursorsTableTableManager
    extends
        RootTableManager<
          _$NotificationLocalDatabase,
          $NotificationSyncCursorsTable,
          NotificationSyncCursor,
          $$NotificationSyncCursorsTableFilterComposer,
          $$NotificationSyncCursorsTableOrderingComposer,
          $$NotificationSyncCursorsTableAnnotationComposer,
          $$NotificationSyncCursorsTableCreateCompanionBuilder,
          $$NotificationSyncCursorsTableUpdateCompanionBuilder,
          (
            NotificationSyncCursor,
            BaseReferences<
              _$NotificationLocalDatabase,
              $NotificationSyncCursorsTable,
              NotificationSyncCursor
            >,
          ),
          NotificationSyncCursor,
          PrefetchHooks Function()
        > {
  $$NotificationSyncCursorsTableTableManager(
    _$NotificationLocalDatabase db,
    $NotificationSyncCursorsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationSyncCursorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationSyncCursorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationSyncCursorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> ownerUid = const Value.absent(),
                Value<String> scope = const Value.absent(),
                Value<String?> cursorJson = const Value.absent(),
                Value<bool> hasMore = const Value.absent(),
                Value<int> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationSyncCursorsCompanion(
                ownerUid: ownerUid,
                scope: scope,
                cursorJson: cursorJson,
                hasMore: hasMore,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int ownerUid,
                required String scope,
                Value<String?> cursorJson = const Value.absent(),
                Value<bool> hasMore = const Value.absent(),
                Value<int> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationSyncCursorsCompanion.insert(
                ownerUid: ownerUid,
                scope: scope,
                cursorJson: cursorJson,
                hasMore: hasMore,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationSyncCursorsTableProcessedTableManager =
    ProcessedTableManager<
      _$NotificationLocalDatabase,
      $NotificationSyncCursorsTable,
      NotificationSyncCursor,
      $$NotificationSyncCursorsTableFilterComposer,
      $$NotificationSyncCursorsTableOrderingComposer,
      $$NotificationSyncCursorsTableAnnotationComposer,
      $$NotificationSyncCursorsTableCreateCompanionBuilder,
      $$NotificationSyncCursorsTableUpdateCompanionBuilder,
      (
        NotificationSyncCursor,
        BaseReferences<
          _$NotificationLocalDatabase,
          $NotificationSyncCursorsTable,
          NotificationSyncCursor
        >,
      ),
      NotificationSyncCursor,
      PrefetchHooks Function()
    >;
typedef $$NotificationOutboxTableCreateCompanionBuilder =
    NotificationOutboxCompanion Function({
      Value<int> id,
      required int ownerUid,
      required int sessionType,
      required int talkerId,
      required int localMsgSeqno,
      required int senderUid,
      required int receiverType,
      required int receiverId,
      required int msgType,
      required String contentJson,
      required int timestamp,
      Value<String> status,
      Value<String?> error,
      Value<int?> msgKey,
      required int createdAt,
      required int updatedAt,
    });
typedef $$NotificationOutboxTableUpdateCompanionBuilder =
    NotificationOutboxCompanion Function({
      Value<int> id,
      Value<int> ownerUid,
      Value<int> sessionType,
      Value<int> talkerId,
      Value<int> localMsgSeqno,
      Value<int> senderUid,
      Value<int> receiverType,
      Value<int> receiverId,
      Value<int> msgType,
      Value<String> contentJson,
      Value<int> timestamp,
      Value<String> status,
      Value<String?> error,
      Value<int?> msgKey,
      Value<int> createdAt,
      Value<int> updatedAt,
    });

class $$NotificationOutboxTableFilterComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationOutboxTable> {
  $$NotificationOutboxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sessionType => $composableBuilder(
    column: $table.sessionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get talkerId => $composableBuilder(
    column: $table.talkerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get localMsgSeqno => $composableBuilder(
    column: $table.localMsgSeqno,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get senderUid => $composableBuilder(
    column: $table.senderUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get receiverType => $composableBuilder(
    column: $table.receiverType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get receiverId => $composableBuilder(
    column: $table.receiverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get msgType => $composableBuilder(
    column: $table.msgType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentJson => $composableBuilder(
    column: $table.contentJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get error => $composableBuilder(
    column: $table.error,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get msgKey => $composableBuilder(
    column: $table.msgKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationOutboxTableOrderingComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationOutboxTable> {
  $$NotificationOutboxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sessionType => $composableBuilder(
    column: $table.sessionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get talkerId => $composableBuilder(
    column: $table.talkerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localMsgSeqno => $composableBuilder(
    column: $table.localMsgSeqno,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get senderUid => $composableBuilder(
    column: $table.senderUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get receiverType => $composableBuilder(
    column: $table.receiverType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get receiverId => $composableBuilder(
    column: $table.receiverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get msgType => $composableBuilder(
    column: $table.msgType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentJson => $composableBuilder(
    column: $table.contentJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get error => $composableBuilder(
    column: $table.error,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get msgKey => $composableBuilder(
    column: $table.msgKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationOutboxTableAnnotationComposer
    extends Composer<_$NotificationLocalDatabase, $NotificationOutboxTable> {
  $$NotificationOutboxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ownerUid =>
      $composableBuilder(column: $table.ownerUid, builder: (column) => column);

  GeneratedColumn<int> get sessionType =>
      $composableBuilder(column: $table.sessionType, builder: (column) => column);

  GeneratedColumn<int> get talkerId =>
      $composableBuilder(column: $table.talkerId, builder: (column) => column);

  GeneratedColumn<int> get localMsgSeqno =>
      $composableBuilder(column: $table.localMsgSeqno, builder: (column) => column);

  GeneratedColumn<int> get senderUid =>
      $composableBuilder(column: $table.senderUid, builder: (column) => column);

  GeneratedColumn<int> get receiverType =>
      $composableBuilder(column: $table.receiverType, builder: (column) => column);

  GeneratedColumn<int> get receiverId =>
      $composableBuilder(column: $table.receiverId, builder: (column) => column);

  GeneratedColumn<int> get msgType =>
      $composableBuilder(column: $table.msgType, builder: (column) => column);

  GeneratedColumn<String> get contentJson =>
      $composableBuilder(column: $table.contentJson, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get error =>
      $composableBuilder(column: $table.error, builder: (column) => column);

  GeneratedColumn<int> get msgKey =>
      $composableBuilder(column: $table.msgKey, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NotificationOutboxTableTableManager
    extends
        RootTableManager<
          _$NotificationLocalDatabase,
          $NotificationOutboxTable,
          NotificationOutboxData,
          $$NotificationOutboxTableFilterComposer,
          $$NotificationOutboxTableOrderingComposer,
          $$NotificationOutboxTableAnnotationComposer,
          $$NotificationOutboxTableCreateCompanionBuilder,
          $$NotificationOutboxTableUpdateCompanionBuilder,
          (
            NotificationOutboxData,
            BaseReferences<
              _$NotificationLocalDatabase,
              $NotificationOutboxTable,
              NotificationOutboxData
            >,
          ),
          NotificationOutboxData,
          PrefetchHooks Function()
        > {
  $$NotificationOutboxTableTableManager(
    _$NotificationLocalDatabase db,
    $NotificationOutboxTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationOutboxTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationOutboxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationOutboxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ownerUid = const Value.absent(),
                Value<int> sessionType = const Value.absent(),
                Value<int> talkerId = const Value.absent(),
                Value<int> localMsgSeqno = const Value.absent(),
                Value<int> senderUid = const Value.absent(),
                Value<int> receiverType = const Value.absent(),
                Value<int> receiverId = const Value.absent(),
                Value<int> msgType = const Value.absent(),
                Value<String> contentJson = const Value.absent(),
                Value<int> timestamp = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> error = const Value.absent(),
                Value<int?> msgKey = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
              }) => NotificationOutboxCompanion(
                id: id,
                ownerUid: ownerUid,
                sessionType: sessionType,
                talkerId: talkerId,
                localMsgSeqno: localMsgSeqno,
                senderUid: senderUid,
                receiverType: receiverType,
                receiverId: receiverId,
                msgType: msgType,
                contentJson: contentJson,
                timestamp: timestamp,
                status: status,
                error: error,
                msgKey: msgKey,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int ownerUid,
                required int sessionType,
                required int talkerId,
                required int localMsgSeqno,
                required int senderUid,
                required int receiverType,
                required int receiverId,
                required int msgType,
                required String contentJson,
                required int timestamp,
                Value<String> status = const Value.absent(),
                Value<String?> error = const Value.absent(),
                Value<int?> msgKey = const Value.absent(),
                required int createdAt,
                required int updatedAt,
              }) => NotificationOutboxCompanion.insert(
                id: id,
                ownerUid: ownerUid,
                sessionType: sessionType,
                talkerId: talkerId,
                localMsgSeqno: localMsgSeqno,
                senderUid: senderUid,
                receiverType: receiverType,
                receiverId: receiverId,
                msgType: msgType,
                contentJson: contentJson,
                timestamp: timestamp,
                status: status,
                error: error,
                msgKey: msgKey,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationOutboxTableProcessedTableManager =
    ProcessedTableManager<
      _$NotificationLocalDatabase,
      $NotificationOutboxTable,
      NotificationOutboxData,
      $$NotificationOutboxTableFilterComposer,
      $$NotificationOutboxTableOrderingComposer,
      $$NotificationOutboxTableAnnotationComposer,
      $$NotificationOutboxTableCreateCompanionBuilder,
      $$NotificationOutboxTableUpdateCompanionBuilder,
      (
        NotificationOutboxData,
        BaseReferences<
          _$NotificationLocalDatabase,
          $NotificationOutboxTable,
          NotificationOutboxData
        >,
      ),
      NotificationOutboxData,
      PrefetchHooks Function()
    >;

class $NotificationLocalDatabaseManager {
  final _$NotificationLocalDatabase _db;
  $NotificationLocalDatabaseManager(this._db);
  $$NotificationMessagesTableTableManager get notificationMessages =>
      $$NotificationMessagesTableTableManager(_db, _db.notificationMessages);
  $$NotificationMessageEmojisTableTableManager get notificationMessageEmojis =>
      $$NotificationMessageEmojisTableTableManager(_db, _db.notificationMessageEmojis);
  $$NotificationSessionsTableTableManager get notificationSessions =>
      $$NotificationSessionsTableTableManager(_db, _db.notificationSessions);
  $$NotificationFeedItemsTableTableManager get notificationFeedItems =>
      $$NotificationFeedItemsTableTableManager(_db, _db.notificationFeedItems);
  $$NotificationUnreadSummariesTableTableManager get notificationUnreadSummaries =>
      $$NotificationUnreadSummariesTableTableManager(
        _db,
        _db.notificationUnreadSummaries,
      );
  $$NotificationSyncCursorsTableTableManager get notificationSyncCursors =>
      $$NotificationSyncCursorsTableTableManager(_db, _db.notificationSyncCursors);
  $$NotificationOutboxTableTableManager get notificationOutbox =>
      $$NotificationOutboxTableTableManager(_db, _db.notificationOutbox);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationLocalDatabase)
final notificationLocalDatabaseProvider = NotificationLocalDatabaseProvider._();

final class NotificationLocalDatabaseProvider
    extends
        $FunctionalProvider<
          NotificationLocalDatabase,
          NotificationLocalDatabase,
          NotificationLocalDatabase
        >
    with $Provider<NotificationLocalDatabase> {
  NotificationLocalDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationLocalDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationLocalDatabaseHash();

  @$internal
  @override
  $ProviderElement<NotificationLocalDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NotificationLocalDatabase create(Ref ref) {
    return notificationLocalDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationLocalDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationLocalDatabase>(value),
    );
  }
}

String _$notificationLocalDatabaseHash() => r'ab7ad185eb0d67afb3aea4c47b80a55dca7e7eec';
