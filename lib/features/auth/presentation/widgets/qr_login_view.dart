import 'package:culcul/features/auth/presentation/view_models/auth_qr_login_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrLoginView extends ConsumerWidget {
  const QrLoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final qrState = ref.watch(authQrLoginControllerProvider);
    final qrController = ref.read(authQrLoginControllerProvider.notifier);

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (qrState.qrUrl != null)
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: QrImageView(
                        data: qrState.qrUrl!,
                        version: QrVersions.auto,
                        size: 200,
                        eyeStyle: QrEyeStyle(
                          eyeShape: QrEyeShape.square,
                          color: colorScheme.scrim,
                        ),
                        dataModuleStyle: QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.square,
                          color: colorScheme.scrim,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    )
                  else
                    SizedBox(
                      height: 224,
                      width: 224,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: theme.colorScheme.primary,
                          strokeWidth: 3,
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  Text(
                    switch (qrState.status) {
                      AuthQrLoginStatus.loading => t.auth.qr_status.loading,
                      AuthQrLoginStatus.success => t.auth.qr_status.success,
                      AuthQrLoginStatus.scanned => t.auth.qr_status.scanned,
                      AuthQrLoginStatus.expired => t.auth.qr_status.expired,
                      AuthQrLoginStatus.error => t.auth.qr_status.error,
                    },
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            if (qrState.statusCode == 86038 ||
                qrState.status == AuthQrLoginStatus.error) ...[
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: qrController.refresh,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: Text(t.auth.qr_refresh),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: const StadiumBorder(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

