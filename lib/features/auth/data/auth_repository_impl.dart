import 'dart:convert';
import 'dart:typed_data';

import 'package:culcul/core/errors/exceptions.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/dio_client.dart';
import 'package:culcul/core/data/network/models/api_response.dart';
import 'package:culcul/core/data/network/request_executor.dart';
import 'package:culcul/core/bootstrap/providers/storage_provider.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/auth/data/auth_api.dart';
import 'package:culcul/features/auth/data/dtos/auth_dtos.dart';
import 'package:culcul/features/auth/domain/entities/country_code.dart';
import 'package:culcul/features/auth/domain/entities/user_entity.dart';
import 'package:culcul/features/auth/domain/entities/auth_captcha_challenge.dart';
import 'package:culcul/features/auth/domain/entities/auth_qr_code.dart';
import 'package:culcul/features/auth/domain/entities/auth_qr_poll_result.dart';
import 'package:culcul/features/auth/domain/repositories/auth_repository.dart' as domain;
import 'package:pointycastle/export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_repository_impl.g.dart';
part 'auth_repository_impl.helpers.dart';
part 'auth_repository_impl.session.dart';
part 'auth_repository_impl.flows.dart';

@riverpod
domain.AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    AuthApi(ref.watch(dioClientProvider)),
    ref.watch(sharedPreferencesProvider),
  );
}

class AuthRepositoryImpl
    with
        _AuthRepositoryHelpersMixin,
        _AuthRepositorySessionMixin,
        _AuthRepositoryFlowsMixin
    implements domain.AuthRepository {
  @override
  final AuthApi _api;
  @override
  final SharedPreferences _prefs;
  @override
  final RequestExecutor _executor;

  AuthRepositoryImpl(this._api, this._prefs) : _executor = const RequestExecutor();
}
