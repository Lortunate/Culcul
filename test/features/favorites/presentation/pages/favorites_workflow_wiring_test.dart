import 'package:culcul/core/contracts/user_session_contract.dart';
import 'package:culcul/core/session/current_user_provider.dart';
import 'package:culcul/features/favorites/application/favorite_folder_commands.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_folder.dart';
import 'package:culcul/features/favorites/domain/entities/favorite_resource.dart';
import 'package:culcul/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:culcul/features/favorites/feature_scope.dart';
import 'package:culcul/features/favorites/presentation/pages/favorite_detail_page.dart';
import 'package:culcul/features/favorites/presentation/pages/favorites_page.dart';
import 'package:culcul/features/favorites/presentation/widgets/fav_folder_dialog.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  group('favorites workflow wiring', () {
    testWidgets('FavoritesPage create action delegates to workflow and surfaces errors', (
      tester,
    ) async {
      final workflow = _SpyFavoriteFolderWorkflow();

      await _pumpFavoritesPage(tester: tester, workflow: workflow);

      await tester.tap(find.byIcon(Icons.add));
      await _pumpUi(tester);

      await tester.enterText(find.byType(TextField).at(0), 'Folder title');
      await tester.enterText(find.byType(TextField).at(1), 'Folder intro');
      await tester.tap(find.byType(Switch));
      await tester.pump();
      await tester.tap(find.widgetWithText(TextButton, t.common.confirm));
      await _pumpUi(tester);

      expect(workflow.createFolderCalls, 1);
      expect(workflow.lastCreateTitle, 'Folder title');
      expect(workflow.lastCreateIntro, 'Folder intro');
      expect(workflow.lastCreatePrivacy, 1);
      expect(find.byType(FavFolderDialog), findsNothing);
      expect(find.text('${t.common.error}: create failed'), findsNothing);

      workflow.createFolderResult = Failure(AppError.server('create failed'));

      await tester.tap(find.byIcon(Icons.add));
      await _pumpUi(tester);

      await tester.enterText(find.byType(TextField).at(0), 'Folder title');
      await tester.tap(find.widgetWithText(TextButton, t.common.confirm));
      await _pumpUi(tester);

      expect(find.text('${t.common.error}: create failed'), findsOneWidget);
    });

    testWidgets('FavoriteDetailPage edit action delegates to workflow', (tester) async {
      final workflow = _SpyFavoriteFolderWorkflow();

      await _pumpFavoriteDetailPage(tester: tester, workflow: workflow);

      await tester.tap(find.byType(PopupMenuButton<String>));
      await _pumpUi(tester);
      await tester.tap(find.text(t.favorites.edit_info));
      await _pumpUi(tester);

      await tester.enterText(find.byType(TextField).at(0), 'Renamed folder');
      await tester.enterText(find.byType(TextField).at(1), 'Updated intro');
      await tester.tap(find.byType(Switch));
      await tester.pump();
      await tester.tap(find.widgetWithText(TextButton, t.common.confirm));
      await _pumpUi(tester);

      expect(workflow.editFolderCalls, 1);
      expect(workflow.lastEditMediaId, 42);
      expect(workflow.lastEditTitle, 'Renamed folder');
      expect(workflow.lastEditIntro, 'Updated intro');
      expect(workflow.lastEditPrivacy, 1);
    });

    testWidgets(
      'FavoriteDetailPage delete action delegates to workflow and surfaces errors',
      (tester) async {
        final workflow = _SpyFavoriteFolderWorkflow()
          ..deleteFolderResult = Failure(AppError.server('delete failed'));

        await _pumpFavoriteDetailPage(tester: tester, workflow: workflow);

        await tester.tap(find.byType(PopupMenuButton<String>));
        await _pumpUi(tester);
        await tester.tap(find.text(t.favorites.delete_folder));
        await _pumpUi(tester);
        await tester.tap(find.widgetWithText(TextButton, t.common.delete));
        await _pumpUi(tester);

        expect(workflow.deleteFolderCalls, 1);
        expect(workflow.lastDeleteMediaId, 42);
        expect(find.text('${t.common.error}: delete failed'), findsOneWidget);
      },
    );

    testWidgets('FavoriteDetailPage successful delete exits the page', (tester) async {
      final workflow = _SpyFavoriteFolderWorkflow();

      await _pumpFavoriteDetailPage(tester: tester, workflow: workflow);

      await tester.tap(find.byType(PopupMenuButton<String>));
      await _pumpUi(tester);
      await tester.tap(find.text(t.favorites.delete_folder));
      await _pumpUi(tester);
      await tester.tap(find.widgetWithText(TextButton, t.common.delete));
      await _pumpUi(tester);

      expect(workflow.deleteFolderCalls, 1);
      expect(workflow.lastDeleteMediaId, 42);
      expect(find.text('root'), findsOneWidget);
    });

    testWidgets('FavoriteDetailPage resource deletion delegates to workflow', (
      tester,
    ) async {
      final workflow = _SpyFavoriteFolderWorkflow();

      await _pumpFavoriteDetailPage(tester: tester, workflow: workflow);

      await tester.tap(find.byType(PopupMenuButton<String>));
      await _pumpUi(tester);
      await tester.tap(find.text(t.favorites.manage_resources));
      await _pumpUi(tester);

      await tester.tap(find.byType(Checkbox));
      await _pumpUi(tester);
      await tester.tap(
        find.widgetWithText(TextButton, t.favorites.delete_with_count(count: 1)),
      );
      await _pumpUi(tester);

      expect(workflow.deleteResourcesCalls, 1);
      expect(workflow.lastDeleteResourcesMediaId, 42);
      expect(workflow.lastDeleteResourceIds, <int>{7});
    });

    testWidgets(
      'FavoriteDetailPage resource deletion failure surfaces an error and keeps selection mode',
      (tester) async {
        final workflow = _SpyFavoriteFolderWorkflow()
          ..deleteResourcesResult = Failure(AppError.server('delete resources failed'));

        await _pumpFavoriteDetailPage(tester: tester, workflow: workflow);

        await tester.tap(find.byType(PopupMenuButton<String>));
        await _pumpUi(tester);
        await tester.tap(find.text(t.favorites.manage_resources));
        await _pumpUi(tester);

        await tester.tap(find.byType(Checkbox));
        await _pumpUi(tester);
        await tester.tap(
          find.widgetWithText(TextButton, t.favorites.delete_with_count(count: 1)),
        );
        await _pumpUi(tester);

        expect(workflow.deleteResourcesCalls, 1);
        expect(find.text('${t.common.error}: delete resources failed'), findsOneWidget);
        expect(
          find.widgetWithText(TextButton, t.favorites.delete_with_count(count: 1)),
          findsOneWidget,
        );
      },
    );
  });
}

Future<void> _pumpFavoritesPage({
  required WidgetTester tester,
  required _SpyFavoriteFolderWorkflow workflow,
}) async {
  final container = ProviderContainer(
    overrides: [
      currentUserProvider.overrideWith((ref) => _MockUserSession(uid: '1001', nickname: 'tester')),
      favRepositoryProvider.overrideWithValue(_FakeFavoriteRepository()),
      favoriteFolderCommandWorkflowProvider.overrideWithValue(workflow),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: TranslationProvider(child: const MaterialApp(home: FavoritesPage())),
    ),
  );
  await _pumpUi(tester);
}

Future<void> _pumpFavoriteDetailPage({
  required WidgetTester tester,
  required _SpyFavoriteFolderWorkflow workflow,
}) async {
  final container = ProviderContainer(
    overrides: [
      currentUserProvider.overrideWith((ref) => _MockUserSession(uid: '1001', nickname: 'tester')),
      favRepositoryProvider.overrideWithValue(_FakeFavoriteRepository()),
      favoriteFolderCommandWorkflowProvider.overrideWithValue(workflow),
    ],
  );
  addTearDown(container.dispose);
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (_, _) => const Material(child: Text('root')),
      ),
      GoRoute(
        path: '/favorites/42',
        builder: (_, _) =>
            const FavoriteDetailPage(mediaId: 42, title: 'Folder', mid: 1001),
      ),
    ],
  );
  addTearDown(router.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: TranslationProvider(child: MaterialApp.router(routerConfig: router)),
    ),
  );
  await _pumpUi(tester);
  router.push('/favorites/42');
  await _pumpUi(tester);
}

Future<void> _pumpUi(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 200));
  await tester.pump(const Duration(milliseconds: 200));
}

class _SpyFavoriteFolderWorkflow extends FavoriteFolderCommandWorkflow {
  _SpyFavoriteFolderWorkflow() : super(_FakeFavoriteRepository());

  int createFolderCalls = 0;
  int editFolderCalls = 0;
  int deleteFolderCalls = 0;
  int deleteResourcesCalls = 0;

  String? lastCreateTitle;
  String? lastCreateIntro;
  int? lastCreatePrivacy;

  int? lastEditMediaId;
  String? lastEditTitle;
  String? lastEditIntro;
  int? lastEditPrivacy;

  int? lastDeleteMediaId;
  int? lastDeleteResourcesMediaId;
  Set<int>? lastDeleteResourceIds;

  Result<void, AppError> createFolderResult = const Success(null);
  Result<void, AppError> editFolderResult = const Success(null);
  Result<void, AppError> deleteFolderResult = const Success(null);
  Result<void, AppError> deleteResourcesResult = const Success(null);

  @override
  Future<Result<void, AppError>> createFolder({
    required String title,
    String? intro,
    int? privacy,
  }) async {
    createFolderCalls++;
    lastCreateTitle = title;
    lastCreateIntro = intro;
    lastCreatePrivacy = privacy;
    return createFolderResult;
  }

  @override
  Future<Result<void, AppError>> editFolder({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
  }) async {
    editFolderCalls++;
    lastEditMediaId = mediaId;
    lastEditTitle = title;
    lastEditIntro = intro;
    lastEditPrivacy = privacy;
    return editFolderResult;
  }

  @override
  Future<Result<void, AppError>> deleteFolder({required int mediaId}) async {
    deleteFolderCalls++;
    lastDeleteMediaId = mediaId;
    return deleteFolderResult;
  }

  @override
  Future<Result<void, AppError>> deleteResources({
    required int mediaId,
    required Set<int> resourceIds,
  }) async {
    deleteResourcesCalls++;
    lastDeleteResourcesMediaId = mediaId;
    lastDeleteResourceIds = resourceIds;
    return deleteResourcesResult;
  }
}

class _FakeFavoriteRepository implements FavoriteRepository {
  @override
  Future<Result<void, AppError>> cleanInvalidResources({required int mediaId}) async {
    return const Success(null);
  }

  @override
  Future<Result<FavoriteFolder, AppError>> createFolder({
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    return Success(_folder());
  }

  @override
  Future<Result<void, AppError>> deleteFolder({required String mediaIds}) async {
    return const Success(null);
  }

  @override
  Future<Result<void, AppError>> deleteResources({
    required String resources,
    required int mediaId,
  }) async {
    return const Success(null);
  }

  @override
  Future<Result<FavoriteFolderPage, AppError>> getCollectedFolders(
    FavoriteFolderListQuery query,
  ) async {
    return const Success(FavoriteFolderPage(count: 0, folders: <FavoriteFolder>[]));
  }

  @override
  Future<Result<FavoriteFolderPage, AppError>> getCreatedFolders({
    required int upMid,
  }) async {
    return Success(FavoriteFolderPage(count: 1, folders: <FavoriteFolder>[_folder()]));
  }

  @override
  Future<Result<FavoriteResourcePage, AppError>> getFolderResources(
    FavoriteFolderResourcesQuery query,
  ) async {
    return Success(
      FavoriteResourcePage(
        info: _folderInfo(),
        medias: <FavoriteResource>[_resource()],
        hasMore: false,
      ),
    );
  }

  @override
  Future<Result<FavoriteFolder, AppError>> updateFolder({
    required int mediaId,
    required String title,
    String? intro,
    int? privacy,
    String? cover,
  }) async {
    return Success(
      _folder().copyWith(title: title, intro: intro, attr: privacy == 1 ? 1 : 0),
    );
  }
}

FavoriteFolder _folder() {
  return const FavoriteFolder(
    id: 42,
    fid: 42,
    mid: 1001,
    attr: 0,
    title: 'Folder',
    favState: 0,
    mediaCount: 1,
    cover: 'https://example.com/cover.jpg',
    upper: FavoriteOwner(mid: 1001, name: 'tester', face: 'https://example.com/face.jpg'),
    intro: 'Existing intro',
    ctime: 0,
    mtime: 0,
    state: 0,
  );
}

FavoriteFolderInfo _folderInfo() {
  return const FavoriteFolderInfo(
    id: 42,
    fid: 42,
    mid: 1001,
    attr: 0,
    title: 'Folder',
    cover: 'https://example.com/cover.jpg',
    upper: FavoriteOwner(mid: 1001, name: 'tester', face: 'https://example.com/face.jpg'),
    mediaCount: 1,
  );
}

FavoriteResource _resource() {
  return const FavoriteResource(
    id: 7,
    type: 2,
    title: 'Resource title',
    cover: 'https://example.com/resource.jpg',
    intro: 'Resource intro',
    page: 1,
    duration: 120,
    upper: FavoriteOwner(mid: 1001, name: 'tester', face: 'https://example.com/face.jpg'),
    attr: 0,
    stats: FavoriteResourceStats(collect: 1, play: 2, danmaku: 3),
    link: 'https://example.com/video',
    ctime: 0,
    pubtime: 0,
    favTime: 0,
    bvId: 'BV1',
    bvid: 'BV1',
  );
}

class _MockUserSession implements UserSession {
  @override
  final String uid;
  @override
  final bool isLoggedIn;
  @override
  final String? avatarUrl;
  @override
  final String? nickname;

  _MockUserSession({required this.uid, this.isLoggedIn = true, this.avatarUrl, this.nickname});
}
