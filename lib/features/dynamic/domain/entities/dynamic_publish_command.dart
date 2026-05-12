import 'package:freezed_annotation/freezed_annotation.dart';

part 'dynamic_publish_command.freezed.dart';

@freezed
sealed class PublishMediaAsset with _$PublishMediaAsset {
  const factory PublishMediaAsset({
    required String path,
    required int width,
    required int height,
  }) = _PublishMediaAsset;
}

@freezed
sealed class PublishDynamicCommand with _$PublishDynamicCommand {
  const factory PublishDynamicCommand({
    required String text,
    required List<PublishMediaAsset> media,
  }) = _PublishDynamicCommand;
}
