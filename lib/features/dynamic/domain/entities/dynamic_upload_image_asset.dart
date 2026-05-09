import 'dart:typed_data';

class DynamicUploadImageAsset {
  final String filename;
  final Uint8List bytes;

  const DynamicUploadImageAsset({required this.filename, required this.bytes});
}
