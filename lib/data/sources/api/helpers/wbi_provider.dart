import 'package:cilixili/data/sources/api/helpers/wbi_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wbi_provider.g.dart';

@Riverpod(keepAlive: true)
WbiHelper wbiHelper(Ref ref) {
  return WbiHelper();
}
