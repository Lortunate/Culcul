import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/spinkit_refresh_header.dart';

/// 统一的下拉刷新 Header
class AppRefreshHeader extends SpinkitHeader {
  const AppRefreshHeader()
    : super(
        size: 24, // 稍微调小一点，显得更精致
      );
}

/// 统一的上拉加载 Footer
class AppLoadFooter extends SpinkitFooter {
  AppLoadFooter() : super(size: 24, noMoreText: t.common.no_more_content);
}
