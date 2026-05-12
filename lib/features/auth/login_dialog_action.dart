import 'package:culcul/features/auth/presentation/widgets/login_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_dialog_action.g.dart';

typedef ShowLoginDialog = void Function(BuildContext context);

@riverpod
ShowLoginDialog showLoginDialog(Ref ref) {
  return (context) => LoginDialog.show(context);
}
