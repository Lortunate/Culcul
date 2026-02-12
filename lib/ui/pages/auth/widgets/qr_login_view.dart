import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/pages/auth/hooks/use_qr_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrLoginView extends HookConsumerWidget {
  const QrLoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final qrState = useQrLogin(ref);
    
    // Entry animation
    final entryAnimationController = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );
    
    useEffect(() {
      entryAnimationController.forward();
      return null;
    }, []);

    final entryOffset = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: entryAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );
    
    final entryOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: entryAnimationController,
        curve: Curves.easeOut,
      ),
    );

    return Center(
      child: SingleChildScrollView(
        child: FadeTransition(
          opacity: entryOpacity,
          child: SlideTransition(
            position: entryOffset,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // QR Code Container
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: theme.shadowColor.withValues(alpha: 0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (qrState.qrUrl != null)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: QrImageView(
                            data: qrState.qrUrl!,
                            version: QrVersions.auto,
                            size: 200,
                            eyeStyle: const QrEyeStyle(
                              eyeShape: QrEyeShape.square,
                              color: Colors.black,
                            ),
                            dataModuleStyle: const QrDataModuleStyle(
                              dataModuleShape: QrDataModuleShape.square,
                              color: Colors.black,
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
                          QrLoginStatus.loading => t.auth.qr_status.loading,
                          QrLoginStatus.success => t.auth.qr_status.success,
                          QrLoginStatus.scanned => t.auth.qr_status.scanned,
                          QrLoginStatus.expired => t.auth.qr_status.expired,
                          QrLoginStatus.error => t.auth.qr_status.error,
                        },
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        t.auth.qr_hint,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Refresh Button (only when needed)
                if (qrState.statusCode == 86038 ||
                    qrState.status == QrLoginStatus.error) ...[
                  const SizedBox(height: 32),
                  FilledButton.icon(
                    onPressed: qrState.refresh,
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
        ),
      ),
    );
  }
}
