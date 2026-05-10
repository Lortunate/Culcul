import 'package:culcul/features/auth/presentation/widgets/login_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef ShowLoginDialog = void Function(BuildContext context);

final showLoginDialogProvider = Provider<ShowLoginDialog>((ref) {
  return (context) => LoginDialog.show(context);
});
