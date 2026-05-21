import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cookie_jar_provider.g.dart';

@Riverpod(keepAlive: true)
CookieJar cookieJar(Ref ref) {
  return _LazyPersistCookieJar();
}

final class _LazyPersistCookieJar implements CookieJar {
  _LazyPersistCookieJar();

  @override
  final bool ignoreExpires = false;

  CookieJar? _jar;
  Future<CookieJar>? _jarFuture;

  Future<CookieJar> _resolve() {
    final jar = _jar;
    if (jar != null) return Future.value(jar);
    return _jarFuture ??= _create();
  }

  Future<CookieJar> _create() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final jar = PersistCookieJar(
      storage: FileStorage('${documentDirectory.path}/.cookies/'),
    );
    _jar = jar;
    return jar;
  }

  @override
  Future<void> delete(Uri uri, [bool withDomainSharedCookie = false]) async {
    return (await _resolve()).delete(uri, withDomainSharedCookie);
  }

  @override
  Future<void> deleteAll() async {
    return (await _resolve()).deleteAll();
  }

  @override
  Future<List<Cookie>> loadForRequest(Uri uri) async {
    return (await _resolve()).loadForRequest(uri);
  }

  @override
  Future<void> saveFromResponse(Uri uri, List<Cookie> cookies) async {
    return (await _resolve()).saveFromResponse(uri, cookies);
  }
}
