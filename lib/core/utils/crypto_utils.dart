import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/export.dart' as pc;

class CryptoUtils {
  CryptoUtils._();

  static const _correspondPublicKeyPEM = '''
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDLgd2OAkcGVtoE3ThUREbio0Eg
Uc/prcajMKXvkCKFCWhJYJcLkcM2DKKcSeFpD/j6Boy538YXnR6VhcuUJOhH2x71
nzPjfdTcqMz7djHum0qSZA0AyCBDABUqCrfNgCiJ00Ra7GmRj+YCK1NJEuewlb40
JNrRuoEUXpabUzGB8QIDAQAB
-----END PUBLIC KEY-----
''';

  /// Encrypts the password with the given hash and public key (PEM format).
  /// Used for password login.
  static String encryptPassword(String hash, String password, String publicKeyPem) {
    final parser = RSAKeyParser();
    final publicKey = parser.parse(publicKeyPem) as pc.RSAPublicKey;
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    final encrypted = encrypter.encrypt(hash + password);
    return encrypted.base64;
  }

  /// Generates the correspond path for cookie refreshing.
  static String generateCorrespondPath(int timestamp) {
    final parser = RSAKeyParser();
    final publicKey = parser.parse(_correspondPublicKeyPEM) as pc.RSAPublicKey;

    final engine = pc.OAEPEncoding(pc.RSAEngine())
      ..init(
        true,
        pc.ParametersWithRandom(
          pc.PublicKeyParameter<pc.RSAPublicKey>(publicKey),
          _getSecureRandom(),
        ),
      );

    final input = utf8.encode('refresh_$timestamp');
    final output = engine.process(Uint8List.fromList(input));

    return output.map((e) => e.toRadixString(16).padLeft(2, '0')).join();
  }

  static pc.SecureRandom _getSecureRandom() {
    final secureRandom = pc.FortunaRandom();
    final seedSource = Random.secure();
    final seeds = <int>[];
    for (int i = 0; i < 32; i++) {
      seeds.add(seedSource.nextInt(255));
    }
    secureRandom.seed(pc.KeyParameter(Uint8List.fromList(seeds)));
    return secureRandom;
  }
}
