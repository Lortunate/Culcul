import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:culcul/domain/entities/user_entity.dart';

extension AuthStateExtension on AsyncValue<UserEntity?> {
  bool get isLoggedIn => asData?.value != null;
  UserEntity? get user => asData?.value;
}

