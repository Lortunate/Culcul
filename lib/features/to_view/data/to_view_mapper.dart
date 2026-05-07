import 'package:culcul/features/to_view/data/dtos/to_view_model_dto.dart';
import 'package:culcul/features/to_view/domain/entities/to_view_entry.dart';

extension ToViewModelMapper on ToViewModelDto {
  ToViewEntry toDomain() {
    return ToViewEntry(
      aid: aid ?? 0,
      bvid: bvid ?? '',
      title: title ?? '',
      coverUrl: pic ?? '',
      duration: duration ?? 0,
      progress: progress ?? 0,
      ownerName: owner?.name ?? '',
      viewCount: stat?.view ?? 0,
      danmakuCount: stat?.danmaku ?? 0,
    );
  }
}
