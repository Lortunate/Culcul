import 'package:culcul/features/to_view/domain/entities/to_view_entry.dart';

abstract class ToViewRepository {
  Future<List<ToViewEntry>> getList();

  Future<void> add({required int aid});

  Future<void> delete({required int aid});

  Future<void> clear();
}
