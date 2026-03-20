import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:culcul/data/models/user/user_model.dart';

extension AuthStateExtension on AsyncValue<User?> {
  bool get isLoggedIn => asData?.value != null;
  User? get user => asData?.value;
}
