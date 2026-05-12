import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_qr_code.freezed.dart';

@freezed
sealed class AuthQrCode with _$AuthQrCode {
  const factory AuthQrCode({required String url, required String key}) = _AuthQrCode;
}
