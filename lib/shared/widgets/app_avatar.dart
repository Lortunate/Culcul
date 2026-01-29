import 'package:cilixili/i18n/strings.g.dart';
import 'package:cilixili/shared/widgets/app_network_image.dart';
import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  final String? url;
  final double size;
  final VoidCallback? onTap;

  const AppAvatar({super.key, this.url, this.size = 32, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final t = Translations.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? Colors.grey[800] : Colors.grey[200],
        ),
        clipBehavior: Clip.antiAlias,
        child: url?.isNotEmpty == true
            ? AppNetworkImage(
                url: url!,
                width: size,
                height: size,
                borderRadius: size / 2,
                placeholder: Icon(
                  Icons.face,
                  color: Colors.grey,
                  size: size * 0.6,
                ),
                errorWidget: Icon(
                  Icons.face,
                  color: Colors.grey,
                  size: size * 0.6,
                ),
              )
            : Center(
                child: Padding(
                  padding: EdgeInsets.all(size * 0.1),
                  child: FittedBox(
                    child: Text(
                      t.profile.login,
                      style: TextStyle(
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
