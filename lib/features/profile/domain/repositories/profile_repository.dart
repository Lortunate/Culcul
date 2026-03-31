import 'package:culcul/features/profile/domain/entities/profile_user.dart';
import 'package:culcul/features/profile/domain/entities/profile_video.dart';
import 'package:culcul/features/profile/domain/entities/profile_transport_entities.dart';

abstract class ProfileRepository {
  Future<UserCardModel> getUserCard(int mid);

  Future<ProfileUser> getProfile(int userId);

  Future<List<ProfileVideo>> getSpaceVideos({
    required int mid,
    int page = 1,
    int pageSize = 30,
    String order = 'pubdate',
  });

  Future<ProfileVideo?> getStickyVideo(int vmid);

  Future<List<ProfileVideo>> getMasterpiece(int vmid);

  Future<void> modifyRelation({required int mid, required bool isFollow});
}
