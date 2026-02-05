import 'dart:ui';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/pages/auth/hooks/use_qr_login.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrLoginView extends HookConsumerWidget {
  const QrLoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final qrState = useQrLogin(ref);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainer.withValues(
                    alpha: 0.6,
                  ),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: theme.colorScheme.outlineVariant.withValues(
                      alpha: 0.2,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (qrState.qrUrl != null)
                      QrImageView(
                        data: qrState.qrUrl!,
                        version: QrVersions.auto,
                        size: 200,
                        eyeStyle: QrEyeStyle(
                          eyeShape: QrEyeShape.square,
                          color: theme.colorScheme.onSurface,
                        ),
                        dataModuleStyle: QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.square,
                          color: theme.colorScheme.onSurface,
                        ),
                      )
                    else
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),
                    Text(
                      qrState.status,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    if (qrState.statusCode == 86038 ||
                        qrState.status == t.auth.qr_status.error) ...[
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: qrState.refresh,
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text("Refresh"),
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
