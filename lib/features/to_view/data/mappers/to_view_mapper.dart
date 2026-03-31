import 'package:culcul/features/to_view/models/to_view_models.dart';
import 'package:culcul/features/to_view/domain/entities/to_view_entry.dart';

extension ToViewModelMapper on ToViewModel {
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
