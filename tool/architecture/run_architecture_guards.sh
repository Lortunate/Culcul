#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

failures=0

fail() {
  echo "architecture guard failed: $*" >&2
  failures=1
}

check_no_dart_symbol() {
  local pattern="$1"
  local description="$2"
  if rg -n --glob '*.dart' --glob '!*.freezed.dart' --glob '!*.g.dart' "$pattern" lib; then
    fail "$description"
  fi
}

if find lib -type f \( \
  -name 'dynamic_publish_response_dto.g.dart' -o -name 'dynamic_publish_response_dto.freezed.dart' -o \
  -name 'default_search.g.dart' -o -name 'default_search.freezed.dart' -o \
  -name 'trending_ranking.g.dart' -o -name 'trending_ranking.freezed.dart' -o \
  -name 'search_suggestion.g.dart' -o -name 'search_suggestion.freezed.dart' -o \
  -name 'private_session.freezed.dart' -o \
  -name 'history_model_dto.g.dart' -o -name 'history_model_dto.freezed.dart' -o \
  -name 'to_view_model_dto.g.dart' -o -name 'to_view_model_dto.freezed.dart' -o \
  -name 'feed_response_dto.g.dart' -o -name 'feed_response_dto.freezed.dart' -o \
  -name 'live_room_summary_contract.g.dart' -o -name 'live_room_summary_contract.freezed.dart' -o \
  -name 'user_card_contract.freezed.dart' -o \
  -name 'relation_user_contract.g.dart' -o -name 'relation_user_contract.freezed.dart' -o \
  -name 'paged_list_state.freezed.dart' -o \
  -name 'endpoint_policy.freezed.dart' -o \
  -name 'video_list_response_dto.g.dart' -o -name 'video_list_response_dto.freezed.dart' -o \
  -name 'emote_response.g.dart' -o -name 'emote_response.freezed.dart' -o \
  -name 'user_space_video_model.g.dart' -o -name 'user_space_video_model.freezed.dart' -o \
  -name 'profile_video.g.dart' -o -name 'profile_video.freezed.dart' -o \
  -name 'like_model.g.dart' -o -name 'like_model.freezed.dart' -o \
  -name 'live_gold_rank_dto.g.dart' -o -name 'live_gold_rank_dto.freezed.dart' -o \
  -name 'live_gold_rank_model.g.dart' -o -name 'live_gold_rank_model.freezed.dart' -o \
  -name 'live_danmu_info_dto.g.dart' -o -name 'live_danmu_info_dto.freezed.dart' -o \
  -name 'live_guard_list_dto.g.dart' -o -name 'live_guard_list_dto.freezed.dart' -o \
  -name 'live_anchor_info_model.g.dart' -o -name 'live_anchor_info_model.freezed.dart' -o \
  -name 'live_danmaku_model.g.dart' -o -name 'live_danmaku_model.freezed.dart' -o \
  -name 'live_recommend_response.g.dart' -o -name 'live_recommend_response.freezed.dart' -o \
  -name 'live_guard_list_model.g.dart' -o -name 'live_guard_list_model.freezed.dart' -o \
  -name 'live_room_detail_model.g.dart' -o -name 'live_room_detail_model.freezed.dart' -o \
  -name 'subtitle.g.dart' -o -name 'subtitle.freezed.dart' -o \
  -name 'subtitle_dto.g.dart' -o -name 'subtitle_dto.freezed.dart' -o \
  -name 'play_url.g.dart' -o -name 'play_url.freezed.dart' -o \
  -name 'video_play_url_dto.g.dart' -o -name 'video_play_url_dto.freezed.dart' -o \
  -name 'video_detail_dto.g.dart' -o -name 'video_detail_dto.freezed.dart' -o \
  -name 'player_info_dto.g.dart' -o -name 'player_info_dto.freezed.dart' \
  -o -name 'image_upload_result.freezed.dart' \
\) | rg .; then
  fail "generated artifacts for archived DTO wrappers must stay archived"
fi

if find lib/features -type f \( \
  -name 'uploaded_publish_image.dart' -o -name 'image_upload_result.dart' \
\) | rg .; then
  fail "feature-local upload image result wrappers must stay archived"
fi

if find lib/features/live -type f -name 'live_anchor_info_model.dart' | rg .; then
  fail "live anchor-info wrapper tree must stay archived"
fi

if find lib/features/live/data -name 'live_danmaku_defaults.dart' -type f | rg .; then
  fail "live danmaku send defaults wrapper must stay API-owned"
fi

if find lib/features -path '*/route_entry.dart' -type f | rg .; then
  fail "feature route_entry.dart files must stay archived"
fi

if find lib/features -path '*/presentation/view_models/*.dart' -type f | rg .; then
  fail "presentation/view_models must stay archived for reusable feature state"
fi

if find lib/features/profile/data -name 'profile_cache_repository.dart' -type f | rg .; then
  fail "profile cache repository wrapper file must stay archived"
fi

if find lib/features/profile \( \
  -name 'profile_cache_database.dart' -o -name 'profile_cache_database.g.dart' -o \
  -name 'profile_session_cleanup.dart' \
\) -type f | rg .; then
  fail "unused profile cache database and logout cleanup adapter must stay archived"
fi

if find lib/features/profile/data -name 'profile_repository_impl.flows.dart' -type f | rg .; then
  fail "profile repository one-owner flow part file must stay repository-owned"
fi

if find lib/features/profile/data -name 'profile_repository_impl.parsers.dart' -type f | rg .; then
  fail "profile repository one-owner parser part file must stay repository-owned"
fi

if find lib/core/services -name 'audio_playback_state_gate.freezed.dart' -type f | rg .; then
  fail "audio playback snapshot Freezed shell must stay hand-owned by its service"
fi
if rg -n '\bcopyWith\b' lib/core/services/audio_playback_state_gate.dart; then
  fail "audio playback snapshot unused copyWith helper must stay archived"
fi

if find lib/features/home/state \( \
  -name 'home_tab_sync_controller.dart' -o \
  -name 'home_tab_sync_controller.g.dart' \
\) -type f | rg .; then
  fail "home tab sync provider files must stay hook-owned"
fi

if find lib/features/favorites/state -name 'favorites_view_model.freezed.dart' -type f | rg .; then
  fail "favorites folder detail state Freezed shell must stay hand-owned by its controller"
fi

if find lib/features/favorites/domain/entities \( \
  -name 'favorite_folder.freezed.dart' -o -name 'favorite_folder.g.dart' -o \
  -name 'favorite_resource.freezed.dart' -o -name 'favorite_resource.g.dart' \
\) -type f | rg .; then
  fail "favorites folder/resource Freezed and JSON shells must stay hand-owned"
fi

if find lib/features/live/state \( \
  -name 'live_room_state.dart' -o \
  -name 'live_room_state.freezed.dart' \
\) -type f | rg .; then
  fail "live room state wrapper files must stay controller-owned"
fi
if find lib/features/live/state -name 'live_danmaku_feed_view_model.freezed.dart' -type f | rg .; then
  fail "live danmaku feed state Freezed shell must stay hand-owned by its controller"
fi
if find lib/features/live/application/models \( \
  -name 'live_danmu_info_model.freezed.dart' -o -name 'live_danmu_info_model.g.dart' \
\) -type f | rg .; then
  fail "live danmu info model Freezed/JSON shell must stay hand-owned by its model"
fi
if find lib/features/live/application/models \( \
  -name 'live_play_url_model.freezed.dart' -o -name 'live_play_url_model.g.dart' \
\) -type f | rg .; then
  fail "live play-url model Freezed/JSON shell must stay hand-owned by its model"
fi
if rg -n '\b(copyWith|toJson)\b' lib/features/live/application/models/live_play_url_model.dart; then
  fail "live play-url model unused copyWith/toJson helpers must stay archived"
fi
if find lib/features/live/application/models \( \
  -name 'live_history_danmaku_model.freezed.dart' -o -name 'live_history_danmaku_model.g.dart' \
\) -type f | rg .; then
  fail "live history danmaku model Freezed/JSON shell must stay hand-owned by its model"
fi
if rg -n '\b_listEquals\b' lib/features/live/application/models/live_room_detail_model.dart; then
  fail "live room detail list equality must stay on flutter listEquals"
fi
if rg -n '\b(_mapEquals|_mapHash)\b' lib/features/live/application/models/live_room_detail_model.dart; then
  fail "live room detail map equality/hash must stay on canonical mapEquals and inline unordered hashing"
fi
if rg -n '\b_listEquals\b' lib/features/live/application/models/live_history_danmaku_model.dart; then
  fail "live history danmaku list equality must stay on flutter listEquals"
fi

if rg -n '\b_ProfileRepositoryImplFlowsMixin\b' lib/features/profile/data; then
  fail "profile repository one-owner flow mixin must stay archived"
fi

if rg -n '\b_ProfileRepositoryParsers\b' lib/features/profile/data; then
  fail "profile repository parser extension must stay archived"
fi

if find lib/features/profile/presentation/widgets -name 'user_home_tab.dart' -type f | rg .; then
  fail "profile home tab wrapper file must stay archived"
fi

if find lib/features/profile/presentation/widgets -name 'profile_video_prefetch_tuning.dart' -type f | rg .; then
  fail "profile video prefetch tuning facade must stay widget-owned"
fi

if find lib/features/profile/presentation/widgets -name 'profile_action_grid.dart' -type f | rg .; then
  fail "profile action grid one-owner widget file must stay page-owned"
fi

if find lib/features/notification/application \( \
  -name 'notification_owner_uid_application_providers.dart' -o \
  -name 'notification_owner_uid_application_providers.g.dart' \
\) -type f | rg .; then
  fail "notification owner uid provider wrapper files must stay archived"
fi

if find lib/features/notification/state \( \
  -name 'system_notification_view_model.dart' -o \
  -name 'system_notification_view_model.g.dart' \
\) -type f | rg .; then
  fail "system notification one-page state provider files must stay page-owned"
fi

if find lib/features/notification/state \( \
  -name 'unread_count_view_model.dart' -o \
  -name 'unread_count_view_model.g.dart' \
\) -type f | rg .; then
  fail "notification unread-count one-page state provider files must stay page-owned"
fi

if find lib/features/notification/state \( \
  -name 'private_session_view_model.dart' -o \
  -name 'private_session_view_model.g.dart' \
\) -type f | rg .; then
  fail "notification private-session one-widget state provider files must stay list-owned"
fi

if find lib/features/notification/state \( \
  -name 'notification_feed_view_model.dart' -o \
  -name 'notification_feed_view_model.g.dart' \
\) -type f | rg .; then
  fail "notification feed one-page state provider files must stay list-page-owned"
fi
if find lib/features/notification/state -name 'chat_view_model.freezed.dart' -type f | rg .; then
  fail "notification chat state Freezed shell must stay hand-owned by Chat"
fi
if rg -n '\b_mapHash\b' lib/features/notification/state/chat_view_model.dart; then
  fail "notification chat emoji-map hash helper must stay inline"
fi
if find lib/features/notification/domain/entities -name 'notification_feed_cursor.freezed.dart' -type f | rg .; then
  fail "notification feed cursor Freezed shell must stay hand-owned by the entity"
fi
if rg -n '\bcopyWith\b' lib/features/notification/domain/entities/notification_feed_cursor.dart; then
  fail "notification feed cursor must not restore an unused copyWith helper"
fi
if find lib/features/notification/domain/entities \( \
  -name 'notification_entry.freezed.dart' -o -name 'notification_entry.g.dart' \
\) -type f | rg .; then
  fail "notification entry Freezed/JSON shell must stay hand-owned by the entity"
fi
if rg -n '\bcopyWith\(' lib/features/notification/domain/entities/notification_entry.dart; then
  fail "notification entry copyWith helpers must stay archived"
fi
if find lib/features/notification/domain/entities \( \
  -name 'private_message.freezed.dart' -o -name 'private_message.g.dart' \
\) -type f | rg .; then
  fail "notification private-message Freezed/JSON shell must stay hand-owned by the entity"
fi
if rg -n '\bcopyWith\(' lib/features/notification/domain/entities/private_message.dart; then
  fail "notification private-message copyWith helper must stay archived"
fi
if rg -n '\bcopyWith\(' lib/features/notification/domain/entities/private_message.types.dart; then
  fail "notification private-message value-type copyWith helpers must stay archived"
fi
if rg -n '\btoJson\(' lib/features/notification/domain/entities/private_message.types.dart; then
  fail "notification private-message emoji toJson helper must stay archived"
fi
if rg -n '\bcopyWith\(' lib/features/notification/domain/entities/private_session.dart; then
  fail "notification private-session copyWith helpers must stay archived"
fi
if find lib/features/notification/data/dtos \( \
  -name 'reply_model.freezed.dart' -o -name 'reply_model.g.dart' \
\) -type f | rg .; then
  fail "notification reply DTO Freezed/JSON shell must stay hand-owned"
fi
if rg -n '\bcopyWith\(' lib/features/notification/data/dtos/reply_model.dart; then
  fail "notification reply DTO copyWith helpers must stay archived"
fi
if rg -n 'cursor\.toJson\(\)|_items\.map\(\(item\) => item\.toJson\(\)\)' lib/features/notification/data/dtos/reply_model.dart; then
  fail "notification reply response-shell toJson helper must stay archived"
fi
if find lib/features/notification/data/dtos \( \
  -name 'private_message_model.freezed.dart' -o -name 'private_message_model.g.dart' \
\) -type f | rg .; then
  fail "notification private-message DTO Freezed/JSON shell must stay hand-owned"
fi
if rg -n '\bcopyWith\(' lib/features/notification/data/dtos/private_message_model.dart; then
  fail "notification private-message DTO copyWith helpers must stay archived"
fi
if rg -n "'session_list': _sessionList\\?\\.map\\(\\(session\\) => session\\.toJson\\(\\)\\)|'messages': _messages\\?\\.map\\(\\(message\\) => message\\.toJson\\(\\)\\)|'e_infos': _emojiInfos\\?\\.map\\(\\(emoji\\) => emoji\\.toJson\\(\\)\\)" lib/features/notification/data/dtos/private_message_model.dart; then
  fail "notification private-message response-shell toJson helpers must stay archived"
fi
if find lib/features/history/domain/entities -name 'history_entry.freezed.dart' -type f | rg .; then
  fail "history entry Freezed shell must stay hand-owned by the entity"
fi
if rg -n '\bcopyWith\b' lib/features/history/domain/entities/history_entry.dart; then
  fail "history entry must not restore an unused copyWith helper"
fi
if find lib/features/notification/domain/entities -name 'notification_summary.freezed.dart' -type f | rg .; then
  fail "notification unread summary shell must stay hand-owned"
fi
if rg -n '\bcopyWith\b' lib/features/notification/domain/entities/notification_summary.dart; then
  fail "notification unread summary must not restore an unused copyWith helper"
fi
check_no_dart_symbol '\bnotificationSummary(FromJson|ToJson)\b' \
  "notification summary mapper helpers must stay inline or archived"
if find lib/features/notification/domain/entities -name 'system_notice.freezed.dart' -type f | rg .; then
  fail "notification system notice shell must stay hand-owned"
fi
if rg -n '\bcopyWith\b' lib/features/notification/domain/entities/system_notice.dart; then
  fail "notification system notice must not restore an unused copyWith helper"
fi
if find lib/features/notification/domain/entities -name 'send_message_result.freezed.dart' -type f | rg .; then
  fail "notification send-result Freezed shell must stay hand-owned by the entity"
fi
if rg -n '\bcopyWith\b' lib/features/notification/domain/entities/send_message_result.dart; then
  fail "notification send-result must not restore an unused copyWith helper"
fi
if rg -n '\b(_deepEquals|_deepHash)\b' lib/features/notification/domain/entities/send_message_result.dart; then
  fail "notification send-result deep equality helpers must stay archived"
fi

if find lib \( -path '*/application/*_port.dart' -o -path 'lib/core/contracts/relation_port.dart' \) -type f | rg .; then
  fail "archived application/core port files must stay archived"
fi

if find lib/app/shell \( -name 'navigation_items.dart' -o -name 'navigation_items.g.dart' -o -name 'navigation_items.freezed.dart' \) -type f | rg .; then
  fail "shell navigation item wrapper files must stay archived"
fi

if find lib/features/settings/application \( -name 'settings_controller.dart' -o -name 'settings_controller.g.dart' -o -name 'settings_controller.freezed.dart' \) -type f | rg .; then
  fail "settings cache-size provider wrapper files must stay archived"
fi

if find lib/features/ranking/presentation/models -name 'ranking_category.dart' -type f | rg .; then
  fail "ranking page category wrapper file must stay archived"
fi

if find lib/features/home/presentation -name 'home_breakpoints.dart' -type f | rg .; then
  fail "home breakpoint facade file must stay layout-spec-owned"
fi

if find lib/features/search/data/dtos \( -name 'default_search.dart' -o -name 'trending_ranking.dart' \) -type f | rg .; then
  fail "search default/hot-ranking DTO wrapper files must stay archived"
fi

if find lib/features/search/data/dtos -name 'search_suggestion.dart' -type f | rg .; then
  fail "search suggestion DTO wrapper file must stay archived"
fi

if find lib/features/search/data -name 'search_paging_constants.dart' -type f | rg .; then
  fail "search API page-size constants wrapper must stay API-owned"
fi

if rg -n '\b_hasCachedValue\b' lib/features/search/application/search_application_providers.dart; then
  fail "search cache-presence helper must stay shared in search_application_providers.dart"
fi

if find lib/features/search/data/dtos \( -name 'search_result.dart' -o -name 'search_result.g.dart' -o -name 'search_result.freezed.dart' \) -type f | rg .; then
  fail "search result DTO/domain mirror files must stay archived"
fi
if find lib/features/search/application -name 'search_result.freezed.dart' -type f | rg .; then
  fail "search result page Freezed shell must stay hand-owned"
fi
if find lib/features/search/application -name 'search_query.freezed.dart' -type f | rg .; then
  fail "search query Freezed shell must stay hand-owned"
fi
if rg -n 'Search(Query|ResultPage) copyWith\s*\(' lib/features/search/application; then
  fail "search pagination copy helpers must stay result-view-owned"
fi

if find lib/features/search/data -name 'search_mapper.dart' -type f | rg .; then
  fail "search result copy-only mapper file must stay archived"
fi

if find lib/features/search/presentation/hooks -name 'use_search_view_model.dart' -type f | rg .; then
  fail "search page hook wrapper file must stay page-owned"
fi

if find lib/features/search/application \( \
  -name 'search_history_application_providers.dart' -o \
  -name 'search_history_application_providers.g.dart' \
\) -type f | rg .; then
  fail "search history one-page provider files must stay SearchPage-owned"
fi

if find lib/features/search/application \( \
  -name 'search_trending_item.freezed.dart' -o -name 'search_trending_item.g.dart' \
\) -type f | rg .; then
  fail "search hot-ranking item shell files must stay hand-owned"
fi
if rg -n '\b(copyWith|toJson)\b' lib/features/search/application/search_trending_item.dart; then
  fail "search hot-ranking item must not restore unused copy/serialization helpers"
fi

if find lib/features/search/state \( \
  -name 'search_view_model.dart' -o -name 'search_view_model.g.dart' \
\) -type f | rg .; then
  fail "search result one-widget state provider files must stay result-view-owned"
fi

if find lib/features/home/data/dtos -name 'feed_response_dto.dart' -type f | rg .; then
  fail "home recommend feed response DTO wrapper file must stay archived"
fi

if find lib/features/home/data \( -name 'weekly_api.dart' -o -name 'weekly_api.g.dart' \) -type f | rg .; then
  fail "home weekly one-endpoint API wrapper files must stay home-api-owned"
fi

if find lib/features/home/state \( -name 'weekly_view_model.dart' -o -name 'weekly_view_model.g.dart' \) -type f | rg .; then
  fail "home weekly one-page provider must stay weekly-screen-owned"
fi

if find lib/core/data/network/models -name 'video_list_response_dto.dart' -type f | rg .; then
  fail "shared video list response DTO wrapper file must stay archived"
fi

if rg -n '\b_handleRefresh\b' lib/ui/widgets/smart_paging_view.dart; then
  fail "SmartPagingView one-use refresh helper must stay inline"
fi
if rg -n '\b_build(FallbackIcon|Shadows|Border)\b' lib/ui/widgets/users/app_avatar.dart; then
  fail "AppAvatar decorative helpers must stay inline"
fi

if find lib/core/data/network \( \
  -name 'resource_api_provider.dart' -o -name 'resource_api_provider.g.dart' \
\) -type f | rg .; then
  fail "resource API provider wrapper files must stay ResourceApi-owned"
fi

if rg -n "resource_api_provider\\.dart" lib; then
  fail "resource API provider imports must stay archived"
fi

if find lib/features/dynamic/application \( -name 'dynamic_workflows.dart' -o -name 'dynamic_workflows.g.dart' -o -name 'dynamic_workflows.freezed.dart' \) -type f | rg .; then
  fail "dynamic publish workflow wrapper file must stay archived"
fi

if find lib/features/dynamic/state \( \
  -name 'dynamic_detail_view_model.dart' -o \
  -name 'dynamic_detail_view_model.g.dart' -o \
  -name 'dynamic_detail_view_model.freezed.dart' -o \
  -name 'publish_dynamic_view_model.dart' -o \
  -name 'publish_dynamic_view_model.g.dart' -o \
  -name 'publish_dynamic_view_model.freezed.dart' \
\) -type f | rg .; then
  fail "dynamic detail/publish one-page state provider files must stay page-owned"
fi
if find lib/features/dynamic/state -name 'article_detail_view_model.freezed.dart' -type f | rg .; then
  fail "article detail state Freezed shell must stay hand-owned by its controller"
fi
if rg -n 'sealed class ArticleInlineNode with _\$' lib/features/dynamic/domain/entities/article_detail_data.dart; then
  fail "article inline node Freezed shell must stay hand-owned"
fi
if rg -n '\b(_ArticleInlineNode|_\$ArticleInlineNode|ArticleInlineNodePatterns|ArticleInlineNodeCopyWith)\b' lib/features/dynamic/domain/entities/article_detail_data.freezed.dart; then
  fail "article inline node generated private/copyWith shell must stay removed"
fi
if rg -n 'sealed class ArticleBlock with _\$' lib/features/dynamic/domain/entities/article_detail_data.dart; then
  fail "article block union Freezed shell must stay hand-owned"
fi
if rg -n '\b(_ArticleBlock|_\$ArticleBlock|ArticleBlockPatterns|ArticleBlockCopyWith|ArticleBlockParagraph|ArticleBlockImage|ArticleBlockLinkCard|ArticleBlockQuote|ArticleBlockDivider)\b' lib/features/dynamic/domain/entities/article_detail_data.freezed.dart; then
  fail "article block generated private/copyWith variant shells must stay removed"
fi
if rg -n '\b(ArticleBlockParagraph|ArticleBlockImage|ArticleBlockLinkCard|ArticleBlockQuote)\s+copyWith\(' lib/features/dynamic/domain/entities/article_detail_data.dart; then
  fail "article block render-unit copyWith helpers must stay archived"
fi
if find lib/features/dynamic/presentation/pages -name 'article_detail_page_block_renderers.cards.dart' -type f | rg .; then
  fail "article detail card block wrapper file must stay archived"
fi
if rg -n '\b(_ImageBlockView|_LinkCardView|_QuoteBlockView)\b' lib/features/dynamic/presentation/pages/article_detail_page_scaffold.dart; then
  fail "article detail image/link/quote block wrappers must stay inline"
fi
if rg -n '\b_readCachedPlayUrl\b' lib/features/video/presentation/detail/video_detail_view_model.dart; then
  fail "video detail play-url cache read wrapper must stay inline"
fi
if rg -n '\b_ActionItem\b' lib/features/home/presentation/widgets/home_video_actions.dart; then
  fail "home video actions row wrapper must stay inline"
fi
if rg -n '\b_DynamicVoteCard\b' lib/features/dynamic/presentation/widgets/dynamic_content_widget.dart; then
  fail "dynamic vote additional wrapper must stay inline"
fi
if rg -n '\bint\?\s+_int\(|\b_int\(' lib/features/dynamic/data/article_parsing; then
  fail "article parser integer scalar parsing must use JsonUtils"
fi
if rg -n '\b_parseInitialState\b' lib/features/dynamic/data/article_parsing; then
  fail "article parser initial-state decode helper must stay inline"
fi
if find lib/features/dynamic/application/models \( \
  -name 'dynamic_response.freezed.dart' -o -name 'dynamic_response.g.dart' \
\) -type f | rg .; then
  fail "dynamic response generated Freezed/JSON files must stay archived"
fi
if rg -n "freezed_annotation|dynamic_response\\.(freezed|g)\\.dart" lib/features/dynamic/application/models/dynamic_response*.dart; then
  fail "dynamic response models must not import or part generated Freezed/JSON files"
fi
if rg -n 'sealed class (DynamicData|DynamicItem|DynamicBasic|DynamicModules|ModuleAuthor|ModuleDynamic|ModuleAdditional|AdditionalCommon|AdditionalReserve|ReserveDesc|AdditionalGoods|GoodsItem|AdditionalVote|AdditionalUgc|ModuleDesc|ModuleMajor|MajorArchive|MajorDraw|DrawItem|MajorArticle|MajorCommon|MajorStat|ModuleStat|StatLike|StatCommon|ModuleTopic|MajorPgc|MajorCourses|MajorMusic|MajorOpus|OpusSummary|OpusPic|MajorLive|MajorLiveRcmd) with _\$' lib/features/dynamic/application/models; then
  fail "dynamic response models must stay hand-owned"
fi
if rg -n '\b(_DynamicData|_DynamicItem|_DynamicBasic|_DynamicModules|_ModuleAuthor|_ModuleDynamic|_ModuleAdditional|_AdditionalCommon|_AdditionalReserve|_ReserveDesc|_AdditionalGoods|_GoodsItem|_AdditionalVote|_AdditionalUgc|_ModuleDesc|_ModuleMajor|_MajorArchive|_MajorDraw|_DrawItem|_MajorArticle|_MajorCommon|_MajorStat|_ModuleStat|_StatLike|_StatCommon|_ModuleTopic|_MajorPgc|_MajorCourses|_MajorMusic|_MajorOpus|_OpusSummary|_OpusPic|_MajorLive|_MajorLiveRcmd|DynamicDataCopyWith|DynamicItemCopyWith|DynamicBasicCopyWith|DynamicModulesCopyWith|ModuleAuthorCopyWith|ModuleDynamicCopyWith|ModuleAdditionalCopyWith|AdditionalCommonCopyWith|AdditionalReserveCopyWith|ReserveDescCopyWith|AdditionalGoodsCopyWith|GoodsItemCopyWith|AdditionalVoteCopyWith|AdditionalUgcCopyWith|ModuleDescCopyWith|ModuleMajorCopyWith|MajorArchiveCopyWith|MajorDrawCopyWith|DrawItemCopyWith|MajorArticleCopyWith|MajorCommonCopyWith|MajorStatCopyWith|ModuleStatCopyWith|StatLikeCopyWith|StatCommonCopyWith|ModuleTopicCopyWith|MajorPgcCopyWith|MajorCoursesCopyWith|MajorMusicCopyWith|MajorOpusCopyWith|OpusSummaryCopyWith|OpusPicCopyWith|MajorLiveCopyWith|MajorLiveRcmdCopyWith)\b' lib/features/dynamic/application/models; then
  fail "dynamic response generated private/copyWith shells must stay removed"
fi
if rg -n '\bcopyWith\(' lib/features/dynamic/application/models/dynamic_response.major_secondary.dart; then
  fail "dynamic response major-secondary read-model copyWith helpers must stay archived"
fi
if rg -n '\btoJson\(' lib/features/dynamic/application/models/dynamic_response.major_secondary.dart; then
  fail "dynamic response major-secondary read-model toJson helpers must stay archived"
fi
if rg -n '^[[:space:]]+(DynamicData|DynamicBasic|ModuleAuthor|ModuleDynamic) copyWith\(' lib/features/dynamic/application/models/dynamic_response.core.dart; then
  fail "dynamic response core unused read-model copyWith helpers must stay archived"
fi
if rg -n '\btoJson\(' lib/features/dynamic/application/models/dynamic_response.core.dart; then
  fail "dynamic response core read-model toJson helpers must stay archived"
fi
if rg -n '^[[:space:]]+(ModuleDesc|ModuleMajor|MajorArchive|MajorDraw|DrawItem|MajorArticle|MajorCommon|MajorStat|StatCommon|ModuleTopic) copyWith\(' lib/features/dynamic/application/models/dynamic_response.major_primary.dart; then
  fail "dynamic response major-primary unused read-model copyWith helpers must stay archived"
fi
if rg -n '\b_nullableSentinel\b' lib/features/dynamic/application/models/dynamic_response.major_primary.dart; then
  fail "dynamic response major-primary nullable copy sentinels must stay archived"
fi
if rg -n '\btoJson\(' lib/features/dynamic/application/models/dynamic_response.major_primary.dart; then
  fail "dynamic response major-primary read-model toJson helpers must stay archived"
fi
if rg -n '\b(copyWith|toJson)\(' lib/features/dynamic/application/models/dynamic_response.additional.dart; then
  fail "dynamic response additional read-model copyWith/toJson helpers must stay archived"
fi

if rg -n 'sealed class (CommentLabel|CommentContent|CommentPicture|CommentEmote) with _\$' lib/core/contracts/comment_contract.types.dart; then
  fail "comment contract nested content/media labels must stay hand-owned"
fi
if rg -n '\b(_CommentLabel|_CommentContent|_CommentPicture|_CommentEmote|_\$CommentLabel|_\$CommentContent|_\$CommentPicture|_\$CommentEmote|CommentLabelPatterns|CommentContentPatterns|CommentPicturePatterns|CommentEmotePatterns|CommentLabelCopyWith|CommentContentCopyWith|CommentPictureCopyWith|CommentEmoteCopyWith|_\$CommentLabelFromJson|_\$CommentContentFromJson|_\$CommentPictureFromJson|_\$CommentEmoteFromJson|_\$CommentLabelToJson|_\$CommentContentToJson|_\$CommentPictureToJson|_\$CommentEmoteToJson)\b' lib/core/contracts/comment_contract.freezed.dart lib/core/contracts/comment_contract.g.dart; then
  fail "comment contract generated nested content/media label shells must stay removed"
fi
if rg -n '\bcopyWith\b' lib/core/contracts/comment_contract.types.dart; then
  fail "comment contract nested content/media copyWith helpers must stay archived"
fi
if rg -n '\btoJson\(' lib/core/contracts/comment_contract.types.dart; then
  fail "comment contract nested content/media toJson helpers must stay archived"
fi

if find lib/features/video/data/dtos \( -name 'player_info_dto.dart' -o -name 'player_info_dto.g.dart' -o -name 'player_info_dto.freezed.dart' \) -type f | rg .; then
  fail "video player-info danmaku-mask DTO wrapper files must stay archived"
fi
if rg -n '\b_listEquals\b' lib/features/video/data/dtos/video_detail_dto.dart; then
  fail "video detail DTO list equality must stay on flutter listEquals"
fi
if rg -n '\b(_deepEquals|_deepHash)\b' lib/features/video/data/dtos/video_detail_dto.dart; then
  fail "video detail DTO deep equality/hash must stay on shared DeepCollectionEquality"
fi

if find lib/features/video/data/dtos \( -name 'related_video_dto.dart' -o -name 'related_video_dto.g.dart' -o -name 'related_video_dto.freezed.dart' \) -type f | rg .; then
  fail "video related-video DTO wrapper files must stay archived"
fi

if find lib/features/video/presentation/overlays -name 'video_actions_bottom_sheet.dart' -type f | rg .; then
  fail "video actions bottom-sheet cross-feature wrapper file must stay archived"
fi

if find lib/features/video/presentation -name 'video_navigation_callbacks.dart' -type f | rg .; then
  fail "video comment reply navigation callback wrapper file must stay comment-view-owned"
fi

if find lib/features/video/presentation -name 'video_prefetch_tuning.dart' -type f | rg .; then
  fail "video prefetch constants wrapper file must stay owner-private"
fi

if find lib/features/video/presentation/overlays \( \
  -name 'danmaku_mask_view_model.dart' -o -name 'danmaku_mask_view_model.g.dart' \
\) -type f | rg .; then
  fail "video danmaku mask provider wrapper file must stay application-owned"
fi
if find lib/features/video/presentation/overlays -name 'danmaku_settings_view_model.freezed.dart' -type f | rg .; then
  fail "video danmaku settings Freezed shell must stay hand-owned by its controller"
fi
if find lib/features/video/presentation/overlays/danmaku/ns_danmaku/models -name 'danmaku_option.freezed.dart' -type f | rg .; then
  fail "video danmaku option Freezed shell must stay hand-owned by its controller"
fi
if rg -n '\bcopyWith\(' lib/features/video/presentation/overlays/danmaku/ns_danmaku/models/danmaku_option.dart; then
  fail "video danmaku option copyWith helper must stay archived"
fi
if find lib/features/video/application/models -name 'danmaku.freezed.dart' -type f | rg .; then
  fail "video danmaku model Freezed shell must stay hand-owned"
fi
if rg -n '\b_listEquals\b' lib/features/video/application/models/play_url.dart; then
  fail "video play-url list equality must stay on flutter listEquals"
fi
if rg -n '\bcopyWith\b' lib/features/video/application/models/danmaku.dart; then
  fail "video danmaku read-model copyWith helpers must stay archived"
fi

if rg -n '\bArticleDetailCommentActionResult\b' lib/features/dynamic/application/article_detail_workflows.dart lib/features/dynamic/state/article_detail_view_model.dart lib/features/dynamic/presentation/pages/article_detail_page.dart; then
  fail "article detail comment action wrapper must stay record-owned"
fi

if find lib/features/video/presentation/overlays/danmaku/ns_danmaku/models -name 'danmaku_item.dart' -type f | rg .; then
  fail "video danmaku item transport wrapper file must stay controller-owned"
fi

if find lib/features/video/presentation/comments -name 'video_comment_layout.dart' -type f | rg .; then
  fail "video comment list cache extent wrapper file must stay owner-private"
fi

if find lib/features/video/presentation/detail/info -name 'uploader_section.dart' -type f | rg .; then
  fail "video detail uploader single-use wrapper file must stay archived"
fi

if find lib/features/video/presentation/player/controls -name 'video_progress_bar.dart' -type f | rg .; then
  fail "video progress bar single-use wrapper file must stay archived"
fi

if find lib/features/video/presentation/player/controls \( -name 'seek_ripple_overlay.dart' -o -name 'gesture_indicator.dart' \) -type f | rg .; then
  fail "video gesture overlay single-use wrapper files must stay archived"
fi

if find lib/features/video/presentation/player/controls -name 'controls_utils.dart' -type f | rg .; then
  fail "video controls utility wrapper file must stay controls-owned"
fi

if find lib/features/dynamic/data -name 'dynamic_api_defaults.dart' -type f | rg .; then
  fail "dynamic API defaults wrapper file must stay API-owned"
fi

if find lib/ui/widgets/text -name 'app_min_lines_text.dart' -type f | rg .; then
  fail "single-use min-lines text wrapper file must stay archived"
fi

if find lib/ui/widgets/layout -name 'app_section_header.dart' -type f | rg .; then
  fail "search-only section header wrapper file must stay archived"
fi

if find lib/ui/widgets/skeletons -name 'dynamic_skeleton.dart' -type f | rg .; then
  fail "single-use dynamic skeleton wrapper file must stay archived"
fi

if find lib/ui/widgets/skeletons -name 'page_skeletons.dart' -type f | rg .; then
  fail "generic page skeleton wrappers must stay home-feed-owned"
fi

if find lib/features/favorites/data -name 'favorite_mapper.dart' -type f | rg .; then
  fail "favorites copy-only mapper file must stay archived"
fi

if find lib/features/dynamic/domain/entities -name 'dynamic_queries.dart' -type f | rg .; then
  fail "dynamic feed query-bag file must stay archived"
fi

if find lib/features/dynamic/presentation/widgets/content -name 'dynamic_vote_widget.dart' -type f | rg .; then
  fail "single-use dynamic vote wrapper file must stay content-widget-owned"
fi

if find lib/features/dynamic/presentation/widgets/content \( \
  -name 'dynamic_common_widget.dart' -o -name 'dynamic_link_card_widget.dart' -o \
  -name 'dynamic_ugc_widget.dart' -o -name 'dynamic_video_widget.dart' -o \
  -name 'dynamic_goods_widget.dart' -o -name 'dynamic_reserve_widget.dart' -o \
  -name 'dynamic_images_widget.dart' -o -name 'dynamic_content_surface.dart' \
\) -type f | rg .; then
  fail "single-use dynamic content-card wrapper files must stay content-widget-owned"
fi

if find lib/features/dynamic/application/models -name 'dynamic_item_extensions.mappers.dart' -type f | rg .; then
  fail "single-owner dynamic item mapper part file must stay extension-owned"
fi

if find lib/features/dynamic/presentation/widgets -name 'dynamic_forward_widget.dart' -type f | rg .; then
  fail "single-use dynamic forward wrapper file must stay content-widget-owned"
fi

if find lib/features/dynamic/presentation/widgets -name 'dynamic_post_actions.dart' -type f | rg .; then
  fail "single-use dynamic post action sheet file must stay header-owned"
fi

if find lib/features/dynamic/presentation/widgets -name 'recently_followed_widget.dart' -type f | rg .; then
  fail "single-use dynamic recently-followed header file must stay list-view-owned"
fi

if find lib/features/dynamic/application \( \
  -name 'recently_followed_provider.dart' -o -name 'recently_followed_provider.g.dart' \
\) -type f | rg .; then
  fail "single-consumer recently-followed provider must stay dynamic-list-owned"
fi

if find lib/features/dynamic/application \( \
  -name 'topic_dynamic_feed_provider.dart' -o -name 'topic_dynamic_feed_provider.g.dart' \
\) -type f | rg .; then
  fail "single-consumer topic feed provider must stay topic-detail-owned"
fi

if find lib/features/dynamic/presentation/widgets \( \
  -name 'publish_dynamic_bottom_toolbar.dart' -o -name 'publish_dynamic_image_grid.dart' -o \
  -name 'emoji_picker.dart' -o -name 'topic_picker.dart' \
\) -type f | rg .; then
  fail "publish dynamic page-only widget/picker files must stay page-private"
fi

if find lib/features/profile/presentation/pages \( -name 'followers_page.dart' -o -name 'followings_page.dart' \) -type f | rg .; then
  fail "profile relation route page wrapper files must stay archived"
fi

if find lib/ui/widgets/overlays -name 'app_overlay_tag.dart' -type f | rg .; then
  fail "shared app overlay tag wrapper file must stay archived"
fi

if find lib/ui/assemblies/comments -name 'comment_list_state.freezed.dart' -type f | rg .; then
  fail "shared comment list state Freezed shell must stay hand-owned"
fi

if find lib/ui/assemblies/comments -name 'comment_images.dart' -type f | rg .; then
  fail "comment image single-owner wrapper file must stay archived"
fi

if find lib/features/favorites/data/dtos \( \
  -name 'fav_folder_model.dart' -o -name 'fav_folder_model.g.dart' -o -name 'fav_folder_model.freezed.dart' -o \
  -name 'fav_resource_model.dart' -o -name 'fav_resource_model.g.dart' -o -name 'fav_resource_model.freezed.dart' \
\) -type f | rg .; then
  fail "favorites folder/resource DTO mirror files must stay archived"
fi

if find lib/features/notification/data \( -name 'system_notice_mapper.dart' -o -name 'notification_repository_impl.message_support_helpers.dart' -o -name 'notification_repository_impl.message_support.dart' \) -type f | rg .; then
  fail "notification copy/helper mapper and message-support files must stay archived"
fi

if rg -n '\b(systemNoticeFromJson|systemNoticeToJson)\b' lib/features/notification/data/notification_mapper.dart; then
  fail "system notice JSON helpers must stay owned by the SystemNotice entity"
fi

if find lib/features/notification/data -name 'notification_repository_impl.stream_watchers.dart' -type f | rg .; then
  fail "notification repository stream watcher delegate file must stay repository-owned"
fi

if find lib/features/notification/data -name 'notification_repository_impl.local_read_store.dart' -type f | rg .; then
  fail "notification repository local read-store delegate file must stay repository-owned"
fi

if find lib/features/notification/data -name 'notification_repository_impl.message_send_service.dart' -type f | rg .; then
  fail "notification repository message-send delegate file must stay repository-owned"
fi

if find lib/core/data/network -name 'endpoint_policy_provider.dart' -type f | rg .; then
  fail "endpoint policy resolver provider wrapper must stay archived"
fi

if find lib/core/data/network/providers -name 'wbi_signer.dart' -type f | rg .; then
  fail "WBI signer wrapper file must stay helper-owned"
fi

if find lib/features/notification/application \( \
  -name 'notification_resume_sync_application_providers.dart' -o \
  -name 'notification_resume_sync_application_providers.g.dart' \
\) -type f | rg .; then
  fail "notification resume-sync one-caller service provider files must stay lifecycle-owned"
fi

if find lib/features/notification/state \( -name 'chat_view_model.helpers.dart' -o -name 'chat_view_model.send.dart' \) -type f | rg .; then
  fail "notification chat one-owner helper/send part files must stay notifier-owned"
fi

if find lib/features/home/state \( \
  -name 'home_popular_view_model.dart' -o -name 'home_popular_view_model.g.dart' -o \
  -name 'home_recommend_view_model.dart' -o -name 'home_recommend_view_model.g.dart' \
\) -type f | rg .; then
  fail "home popular/recommend one-widget state provider files must stay view-owned"
fi

if rg -n '\bDevLogger\b|\.load_error|\.silent_refresh_result' \
  lib/features/home/presentation/widgets/popular_view.dart \
  lib/features/home/presentation/widgets/recommend_view.dart; then
  fail "home popular/recommend feed load logging must stay in HomeFeedPagingMixin"
fi

if rg -n '\b(_readInt|_readString|_asMap)\b' lib/core/services/relation_service.dart; then
  fail "relation service scalar/map parsing must use JsonUtils"
fi

if find lib/core/contracts -name 'relation_port.dart' -type f | rg .; then
  fail "relation service port interface must stay archived"
fi

if rg -n '\b(_readInt|_readString)\b' lib/features/notification/data/notification_mapper.dart; then
  fail "notification mapper scalar parsing must use JsonUtils"
fi

if rg -n '\b(verticalPageBuilder|_buildVerticalPage)\b' lib/features/video/presentation/detail/video_entry_decision_page.dart; then
  fail "video entry vertical one-line builder seam must stay archived"
fi

if rg -n '\b(normalPageBuilder|_buildNormalPage)\b' lib/features/video/presentation/detail/video_entry_decision_page.dart; then
  fail "video entry normal one-line builder seam must stay archived"
fi

if rg -n '\bSlideFromLeftTransitionPage\b' lib/app/router; then
  fail "unused left-slide route transition wrapper must stay archived"
fi
if rg -n '\bFadeTransitionPage\b' lib/app/router; then
  fail "login fade route transition wrapper must stay archived"
fi

if awk '/class PlayerPanelScaffold /{flag=1} /class PlayerPanelSection /{flag=0} flag' \
  lib/features/video/presentation/player/controls/player_panel.dart |
  rg -n '\b(title|subtitle|trailing)\b'; then
  fail "player panel scaffold must not keep unused title/subtitle/trailing API"
fi

if awk '/class QuickSelectionSheet/{flag=1} /class _PlayerMenuOptionTile/{flag=0} flag' \
  lib/features/video/presentation/player/controls/quick_selection_sheet.dart |
  rg -n '\b(final String title|final String\? subtitle|required this\.title|this\.subtitle)\b'; then
  fail "quick selection sheet must not expose unused title/subtitle forwarding API"
fi

if rg -n '\b(bottomBarHeight|smallIconSize|centerPlayBtnSize|elementSpacing|titleStyle|textButtonStyle|overlayBackgroundColor|sliderTheme)\b' \
  lib/features/video/presentation/player/controls/player_theme.dart; then
  fail "player theme must not keep unused public style/token members"
fi

if rg -n '\b(PlayerWakelock|PlatformPlayerWakelock|syncPlayerWakelock)\b' \
  lib/features/video/presentation/player/hooks/use_player_system_settings.dart; then
  fail "video player wakelock must not keep a single-implementation test seam"
fi

if rg -n '\b(VideoLoaderInput|watchVideoLoaderInput)\b' \
  lib/features/video/presentation/player/hooks/use_video_loader.dart \
  lib/features/video/presentation/player/video_player_view.dart \
  lib/features/video/presentation/player/vertical_video_page.dart; then
  fail "video loader input selection must stay inside useVideoLoader"
fi

if find lib/features/auth/data -name 'auth_repository_impl.helpers.dart' -type f | rg .; then
  fail "auth repository one-owner helper part file must stay repository-owned"
fi

if find lib/features/auth/data -name 'auth_repository_impl.crypto.dart' -type f | rg .; then
  fail "auth repository password crypto helper part file must stay login-flow-owned"
fi

if rg -n "part 'auth_repository_impl\.crypto\.dart'" lib/features/auth/data/auth_repository_impl.dart; then
  fail "auth repository password crypto helpers must stay with auth login flows"
fi

if rg -n '\b(_AuthRepositoryHelpersMixin|_asMapOrNull|_asIntOrNull)\b' lib/features/auth/data/auth_repository_impl.dart; then
  fail "auth cached-user parsing must use JsonUtils map/scalar helpers"
fi

if rg -n '\bLoginDialog\b' lib/features/auth lib/features/home; then
  fail "auth login dialog widget wrapper must stay archived"
fi

if find lib/features/auth/presentation/widgets -name 'login_dialog.dart' -type f | rg .; then
  fail "auth login dialog function must stay login-panel-owned"
fi

if find lib/features/auth/state \( \
  -name 'auth_qr_login_view_model.dart' -o \
  -name 'auth_qr_login_view_model.g.dart' -o \
  -name 'auth_qr_login_view_model.freezed.dart' \
\) -type f | rg .; then
  fail "auth QR login one-page state provider files must stay view-owned"
fi

if find lib/features/auth/application -name 'auth_session_cookie_refresher.dart' -type f | rg .; then
  fail "auth session cookie refresher adapter must stay provider-owned"
fi
if find lib/features/auth/domain/entities -name 'auth_qr_poll_result.freezed.dart' -type f | rg .; then
  fail "auth QR poll result shell must stay hand-owned"
fi
if rg -n '\bcopyWith\b' lib/features/auth/domain/entities/auth_qr_poll_result.dart; then
  fail "auth QR poll result must not restore an unused copyWith helper"
fi
if find lib/features/auth/domain/entities -name 'auth_qr_code.freezed.dart' -type f | rg .; then
  fail "auth QR code shell must stay hand-owned"
fi
if rg -n '\bcopyWith\b' lib/features/auth/domain/entities/auth_qr_code.dart; then
  fail "auth QR code must not restore an unused copyWith helper"
fi
if find lib/features/auth/domain/entities -name 'country_code.freezed.dart' -type f | rg .; then
  fail "auth country code shell must stay hand-owned"
fi
if rg -n '\bcopyWith\b' lib/features/auth/domain/entities/country_code.dart; then
  fail "auth country code must not restore an unused copyWith helper"
fi
if find lib/features/auth/domain/entities -name 'user_entity.freezed.dart' -type f | rg .; then
  fail "auth cached-user shell must stay hand-owned"
fi
if rg -n '\bcopyWith\b' lib/features/auth/domain/entities/user_entity.dart; then
  fail "auth cached user must not restore an unused copyWith helper"
fi
if find lib/features/auth/application -name 'auth_controller.freezed.dart' -type f | rg .; then
  fail "auth controller state shell must stay hand-owned"
fi
if find lib/features/auth/domain/entities -name 'auth_captcha_challenge.freezed.dart' -type f | rg .; then
  fail "auth captcha challenge shell must stay hand-owned"
fi
if rg -n '\bcopyWith\b' lib/features/auth/domain/entities/auth_captcha_challenge.dart; then
  fail "auth captcha challenge must not restore an unused copyWith helper"
fi

if find lib/features/live/application \( \
  -name 'live_recommend_provider.dart' -o -name 'live_recommend_provider.g.dart' \
\) -type f | rg .; then
  fail "live recommend one-consumer provider must stay live-view-owned"
fi

if find lib/features/ranking/state -name 'category_ranking_view_model.dart' -type f | rg .; then
  fail "ranking category provider wrapper must stay page-owned"
fi

if rg -n "features/auth/presentation/widgets/login_dialog\.dart" lib; then
  fail "auth login dialog import must point at login_panel.dart"
fi

if rg -n "features/auth/application/auth_session_cookie_refresher\.dart" lib; then
  fail "auth session cookie refresher import must point at auth_session_providers.dart"
fi

if rg -n "features/live/application/live_recommend_provider\.dart" lib; then
  fail "live recommend provider import must point at live_view.dart"
fi

if rg -n "features/ranking/state/category_ranking_view_model\.dart" lib; then
  fail "ranking category provider import must point at ranking_page.dart"
fi

if rg -n "features/video/presentation/player/controls/controls_utils\.dart" lib; then
  fail "video controls utility imports must point at controls owners"
fi

if rg -n "features/dynamic/data/dynamic_api_defaults\.dart" lib; then
  fail "dynamic API defaults import must point at dynamic_api.dart"
fi

if rg -n "features/dynamic/application/topic_dynamic_feed_provider\.dart" lib; then
  fail "topic dynamic feed import must point at topic_detail_page.dart"
fi

if rg -n '\bnotificationSummaryToJson\b' lib/features/notification/data/notification_mapper.dart; then
  fail "unused notification summary write mapper must stay archived"
fi

if find lib/features/notification/data \( \
  -name 'notification_repository_impl.local_read_store.dart' -o \
  -name 'notification_repository_impl.stream_watchers.dart' -o \
  -name 'notification_repository_impl.message_support.dart' -o \
  -name 'notification_repository_impl.message_support_helpers.dart' -o \
  -name 'notification_repository_impl.message_send_service.dart' \
\) -type f | rg .; then
  fail "notification repository helper/service splits must stay archived"
fi

if rg -n '\b(NotificationLocalReadStore|NotificationStreamWatchers|NotificationMessageSupport|NotificationMessageSendService|SyncMessagesHeadFn)\b' lib/features/notification; then
  fail "notification repository-owned persistence, stream, feed, and send behavior must stay on NotificationRepositoryImpl or its sync collaborators"
fi

if rg -n '\bgetUnreadCountFromLocal\b' lib/features/notification; then
  fail "unused notification local unread snapshot API must stay archived"
fi

if rg -n '\b(isMe|textContent|imageUrl|systemTipContent|isWithdrawn|summaryKind)\b' lib/features/notification/data/dtos/private_message_model.dart; then
  fail "unused private-message DTO convenience members must stay archived"
fi

if rg -n '\b(lastViewAt|last_view_at)\b' lib/features/notification/data/dtos/reply_model.dart lib/features/notification/data/notification_repository_impl.feed_sync.dart; then
  fail "unused notification reply last-view-at field must stay archived"
fi

if rg -n '\b(counts|isMulti|is_multi)\b' lib/features/notification/data/dtos/reply_model.dart; then
  fail "unused notification reply item metadata fields must stay archived"
fi

if rg -n '\b(canonicalEmojiKey|putEmojiVariants|rowToPrivateMessage)\b' lib/features/notification/data/notification_repository_impl.feed_sync.dart; then
  fail "notification message-support must not duplicate persistence emoji/message helpers"
fi

if rg -n '\b(resolveSystemTalkerId|extractSystemNoticeText|extractSystemNoticeUri|firstNonEmptyString|toJsonMap)\b' lib/features/notification/data/notification_repository_impl.feed_sync.dart; then
  fail "notification message-support system-notice helpers must stay private"
fi

if (( $(rg -n 'response == null \|\|' lib/features/profile/data/profile_repository_impl.dart | wc -l) > 1 )); then
  fail "profile optional response parser gate must stay centralized"
fi

check_no_dart_symbol '\b(HistoryResponseDataDto|HistoryCursorDto|HistoryTabDto|HistoryItemDto|HistoryDetailDto|_HistoryItemMapper)\b' \
  "history response/item DTO mirrors and copy mapper must stay archived"
if find lib/features/history/application \( -name 'history_controller.dart' -o -name 'history_controller.g.dart' \) -type f | rg .; then
  fail "history page list provider must stay page-owned"
fi
if rg -n '\b_parseHistoryEntries\b' lib/features/history/data/history_repository_impl.dart; then
  fail "history repository list parsing must stay inline"
fi
if rg -n '\b_parseToViewEntries\b' lib/features/to_view/data/to_view_repository_impl.dart; then
  fail "to_view repository list parsing must stay inline"
fi
check_no_dart_symbol '\bHistoryList\b' \
  "history page list provider class must stay page-owned"
check_no_dart_symbol '\b(ToViewListResponseDto|ToViewModelDto|_ToViewModelMapper)\b' \
  "to_view response/item DTO mirrors and copy mapper must stay archived"
if find lib/features/to_view/domain/entities -name 'to_view_entry.freezed.dart' -type f | rg .; then
  fail "to_view entry Freezed shell must stay hand-owned by the entity"
fi
if rg -n '\bcopyWith\b' lib/features/to_view/domain/entities/to_view_entry.dart; then
  fail "to_view entry must not restore an unused copyWith helper"
fi
check_no_dart_symbol '\b(FeedResponseDto|_FeedItemListConverter)\b' \
  "home recommend feed response DTO wrapper must stay archived"
if rg -n '\b_parseRecommendVideos\b' lib/features/home/data/home_repository_impl.dart; then
  fail "home recommend data.item parsing must stay inline"
fi
check_no_dart_symbol '\bWeeklyApi\b' \
  "home weekly one-endpoint API wrapper must stay archived"
check_no_dart_symbol '\b(weeklyList|weeklyListProvider)\b' \
  "home weekly one-page provider must stay weekly-screen-owned"
check_no_dart_symbol '\bVideoListResponseDto\b' \
  "shared video list response DTO wrapper must stay archived"
check_no_dart_symbol '\b(RankingCategory|rankingCategories)\b' \
  "ranking page category wrapper must stay page-private"
check_no_dart_symbol '\b(FavFolderInfoModel|_FavFolderInfoMapper)\b' \
  "favorites folder-info DTO mirror and copy mapper must stay archived"
check_no_dart_symbol '\b(FavCntInfoModel|_FavCntInfoMapper)\b' \
  "favorites resource-stats DTO mirror and copy mapper must stay archived"
check_no_dart_symbol '\b(FavoriteFolderInfo)\b' \
  "favorites folder-resource page info mirror must stay archived"
check_no_dart_symbol '\b(FavFolderModel|FavResourceModel|_FavFolderMapper|_FavResourceMapper)\b' \
  "favorites folder/resource DTO mirrors and copy mappers must stay archived"
check_no_dart_symbol '\b(FavoriteFolderPage)\b' \
  "favorites folder list-only response shell must stay archived"
if rg -n '\b_parseFavoriteResourcePage\b' lib/features/favorites/data/fav_repository_impl.dart; then
  fail "favorites resource list parsing must stay inline"
fi
if rg -n '\b_FavoriteDetailListSection\b' lib/features/favorites/presentation/pages/favorite_detail_page.dart; then
  fail "favorite detail list section wrapper must stay page-inline"
fi
if rg -n '\b_FavResourceItem\b' lib/features/favorites/presentation/pages/favorite_detail_page.dart; then
  fail "favorite detail resource item wrapper must stay row-inline"
fi
if rg -n '\b_FavoriteDetailSkeleton\b' lib/features/favorites/presentation/pages/favorite_detail_page.dart; then
  fail "favorite detail loading skeleton wrapper must stay page-inline"
fi
check_no_dart_symbol '\b(DynamicPublishResponseDto|DynamicUploadImageResponseDto)\b' \
  "unused dynamic publish/upload response DTOs must stay archived"
check_no_dart_symbol '\bPublishDynamicCommand\b' \
  "unused dynamic publish command wrapper must stay archived"
if find lib/features/dynamic/domain/entities -name 'dynamic_publish_command.freezed.dart' -type f | rg .; then
  fail "dynamic publish command Freezed shell must stay archived"
fi
if rg -n '\bcopyWith\b' lib/features/dynamic/domain/entities/dynamic_publish_command.dart; then
  fail "dynamic publish path value must not restore unused copy helper"
fi
check_no_dart_symbol '\b(DynamicDetailData)\b' \
  "dynamic detail response shell must stay archived"
if rg -n '\b_parseDynamicDetailItem\b' lib/features/dynamic/data/dynamic_repository_impl.feed.dart; then
  fail "dynamic detail data.item parsing must stay inline"
fi
check_no_dart_symbol '\b(DynamicPostCardViewData|DynamicPostCardViewDataMapper)\b' \
  "dynamic post card view-data copy wrapper must stay archived"
check_no_dart_symbol '\b(PublishDynamicWorkflow|publishDynamicWorkflowProvider)\b' \
  "dynamic publish workflow wrapper provider must stay archived"
check_no_dart_symbol '\b(PublishDynamicUiState|PublishDynamicViewModel|publishDynamicViewModelProvider)\b' \
  "dynamic publish page-state provider must stay page-private"
check_no_dart_symbol '\b(DynamicDetailUiState|DynamicDetailViewModel|dynamicDetailViewModelProvider)\b' \
  "dynamic detail page-state provider must stay page-private"
check_no_dart_symbol '\b(buildArticleDetailScaffold|buildArticleCommentSlivers)\b' \
  "article-detail scaffold/comment sliver builders must stay library-private"
check_no_dart_symbol '\b(EmoteResponse|EmotePackage)\b|^[[:space:]]*((abstract|base|final|interface|sealed|mixin)[[:space:]]+)*class[[:space:]]+Emote\b' \
  "dynamic emote DTO mirrors must stay archived"
if rg -n '\b_readStringKeyedMap\b' lib/features/dynamic/application/models/emote_catalog.dart; then
  fail "dynamic emote catalog map parsing must use JsonUtils"
fi
if rg -n '\b_readRequiredInt\b' lib/features/dynamic/application/models/emote_catalog.dart; then
  fail "dynamic emote catalog integer parsing must use JsonUtils"
fi
if rg -n '\b_readRequiredString\b' lib/features/dynamic/application/models/emote_catalog.dart; then
  fail "dynamic emote catalog required string parsing must stay inline"
fi
if rg -n '\b_parseEmotePackages\b' lib/features/dynamic/data/emote_repository_impl.dart; then
  fail "dynamic emote package list-envelope parsing must stay inline"
fi
if rg -n '\bint\s+_readInt\(' \
  lib/features/history/domain/entities/history_entry.dart \
  lib/features/to_view/domain/entities/to_view_entry.dart; then
  fail "history/to-view entry integer parsing must use JsonUtils"
fi
if rg -n '\bString\s+_readString\(' \
  lib/features/history/domain/entities/history_entry.dart \
  lib/features/to_view/domain/entities/to_view_entry.dart; then
  fail "history/to-view entry strict string fallback must stay inline"
fi
if rg -n '\b(_readOwner|_readStat)\b' lib/features/to_view/domain/entities/to_view_entry.dart; then
  fail "to_view owner/stat nested parsing must stay inline on ToViewEntry"
fi
if rg -n '\b_readHistory\b' lib/features/history/domain/entities/history_entry.dart; then
  fail "history nested history-map parsing must stay inline on HistoryEntry"
fi
if rg -n '\b_liveHeaderFormatNumber\b' lib/features/live/presentation/widgets/live_header.dart; then
  fail "live header number-format wrapper must stay inlined"
fi
if rg -n '\b_parseWatchedCount\b' lib/core/contracts/live_room_summary_contract.dart; then
  fail "live watched-count parsing must use JsonUtils directly"
fi
if rg -n '\b_parseAnchorMasterLevel\b' lib/features/live/data/live_repository_impl.dart; then
  fail "live anchor master-level parsing must stay inline"
fi
if rg -n '\b_readOptionalInt\b' lib/features/profile/data/profile_repository_impl.dart; then
  fail "profile repository optional integer parsing must use JsonUtils"
fi
if rg -n '\b_parse(Likes|VideoCount)\b' lib/features/profile/data/profile_repository_impl.dart; then
  fail "profile repository optional counter parsing must stay in getProfile"
fi
if rg -n '\b_parseVip(Type|Status)\b' lib/features/profile/data/profile_repository_impl.dart; then
  fail "profile repository VIP scalar parsing must stay in getProfile"
fi
check_no_dart_symbol '\b(UserSpaceVideoListResponse|UserSpaceVideoList|UserSpacePage|UserSpaceVideoModel)\b' \
  "profile user-space video response/model mirrors must stay archived"
if rg -n '\b_parseUserSpaceVideos\b' lib/features/profile/data/profile_repository_impl.dart; then
  fail "profile user-space list.vlist parsing must stay inline"
fi
if rg -n '\b_parseRelationStats\b' lib/features/profile/data/profile_repository_impl.dart; then
  fail "profile relation stats parsing must stay inline"
fi
check_no_dart_symbol '\b(PrivateMessageEmojiInfo|PrivateMessageEmojiInfoMapper)\b' \
  "notification private-message emoji DTO mirror and copy mapper must stay archived"
check_no_dart_symbol '\b(PrivateMessageAccountInfo|PrivateMessageAccountInfoMapper)\b' \
  "notification private-message account-info DTO mirror and copy mapper must stay archived"
check_no_dart_symbol '\b(_PrivateSession|_PrivateSessionAccountInfo|_\$PrivateSession|_\$PrivateSessionAccountInfo)\b' \
  "notification private-session Freezed shell must stay hand-owned"
check_no_dart_symbol '\b(LikeResponse|LikeLatest|LikeTotal)\b' \
  "notification like response wrapper stack must stay archived"
if rg -n '\b_parseLikeResponse\b' lib/features/notification/data/notification_repository_impl.feed_sync.dart; then
  fail "notification like envelope parsing must stay inline"
fi
check_no_dart_symbol '\b(ReplyUser|ReplyUserMapper)\b' \
  "notification reply actor DTO mirror and copy mapper must stay archived"
check_no_dart_symbol '\b(ReplyItemDetailMapper)\b|extension[[:space:]]+[[:alnum:]_]*[[:space:]]+on[[:space:]]+ReplyItemDetail\b' \
  "notification reply detail copy mapper must stay archived"
if rg -n '\b_readSubjectId\b' lib/features/notification/data/dtos/reply_model.dart; then
  fail "notification reply subject-id wire fallback must stay inline"
fi
check_no_dart_symbol '\b(LiveGoldRankDto|LiveRankItemDto|LiveRankMedalInfoDto)\b' \
  "live gold-rank DTO mirrors must stay archived"
if rg -n '\b(copyWith|toJson)\b' lib/features/live/application/models/live_gold_rank_model.dart; then
  fail "live gold-rank read models must not restore unused copy/serialization helpers"
fi
check_no_dart_symbol '\b(LiveDanmuInfoDto|LiveDanmuHostDto)\b' \
  "live danmu-info DTO mirrors must stay archived"
if rg -n '\b(copyWith|toJson)\b' lib/features/live/application/models/live_danmu_info_model.dart; then
  fail "live danmu-info read models must not restore unused copy/serialization helpers"
fi
if rg -n '\b(copyWith|toJson)\b' lib/features/live/application/models/live_room_detail_model.dart; then
  fail "live room detail read model must not restore unused copy/serialization helpers"
fi
if rg -n '\b(copyWith|toJson)\b' lib/features/live/application/models/live_history_danmaku_model.dart; then
  fail "live history danmaku read models must not restore unused copy/serialization helpers"
fi
if rg -n '\b(copyWith|toJson)\b' lib/features/live/application/models/live_guard_list_model.dart; then
  fail "live guard-list read models must not restore unused copy/serialization helpers"
fi
check_no_dart_symbol '\b(LiveGuardListDto|LiveGuardInfoDto|LiveGuardItemDto|LiveGuardUserInfoDto|LiveGuardUserBaseDto)\b' \
  "live guard-list DTO mirrors must stay archived"
check_no_dart_symbol '\b(_LiveGuardListModel|_LiveGuardInfo|_LiveGuardItem|_LiveGuardUserInfo|_LiveGuardUserBase|_\$LiveGuardListModel|_\$LiveGuardInfo|_\$LiveGuardItem|_\$LiveGuardUserInfo|_\$LiveGuardUserBase)\b' \
  "live guard-list Freezed shell must stay hand-owned"
if rg -n '\b_jsonInt\b' lib/features/live/application/models/live_guard_list_model.dart; then
  fail "live guard-list integer parsing must use JsonUtils directly"
fi
check_no_dart_symbol '\b(LiveDanmakuConfigModel|LiveDanmakuGroup|LiveDanmakuColor|LiveDanmakuMode|getDanmakuConfig|_fetchDanmakuConfig|danmakuConfig)\b' \
  "unused live danmaku config model/fetch state must stay archived"
if find lib/features/live/application/danmaku -name 'live_danmaku_event_parser.dart' -type f | rg .; then
  fail "live danmaku event parser wrapper file must stay socket-owned"
fi
check_no_dart_symbol '\bLiveDanmakuEventParser\b' \
  "live danmaku event parser wrapper class must stay archived"
if rg -n '\b_asInt\b' lib/features/live/application/danmaku; then
  fail "live danmaku event integer parsing must use JsonUtils"
fi
check_no_dart_symbol '\b(LiveRecommendResponse)\b' \
  "live recommend response wrapper must stay archived"
if rg -n '\b_parseRecommendRooms\b' lib/features/live/data/live_repository_impl.dart; then
  fail "live recommend recommend_room_list parsing must stay inline"
fi
check_no_dart_symbol '\b(LiveRecommend|liveRecommendProvider)\b' \
  "live recommend one-consumer provider wrapper must stay live-view-owned"
check_no_dart_symbol '\b(_LiveWatchedShow|_LiveRoomSummary|_\$LiveWatchedShow|_\$LiveRoomSummary|LiveWatchedShowPatterns|LiveRoomSummaryPatterns|LiveWatchedShowCopyWith|LiveRoomSummaryCopyWith)\b' \
  "live room summary Freezed shell must stay hand-owned"
if rg -n '\b(copyWith|toJson)\b' lib/core/contracts/live_room_summary_contract.dart; then
  fail "live room summary copyWith/toJson helpers must stay archived"
fi
check_no_dart_symbol '\b(_UserCardModel|_\$UserCardModel|UserCardModelPatterns|UserCardModelCopyWith)\b' \
  "user card Freezed shell must stay hand-owned"
if rg -n '\bcopyWith\b' lib/core/contracts/user_card_contract.dart; then
  fail "user card read-only handoff contract must not restore unused copyWith helper"
fi
check_no_dart_symbol '\b_parseUserCard\b' \
  "profile user-card parser must stay inline at the repository boundary"
check_no_dart_symbol '\b(_OfficialVerify|_VipInfo|_ProfileRelationUser|_\$OfficialVerify|_\$VipInfo|_\$ProfileRelationUser|OfficialVerifyPatterns|VipInfoPatterns|ProfileRelationUserPatterns|OfficialVerifyCopyWith|VipInfoCopyWith|ProfileRelationUserCopyWith)\b' \
  "relation user Freezed shell must stay hand-owned"
if rg -n '\bcopyWith\b' lib/core/contracts/relation_user_contract.dart; then
  fail "relation user contracts must not restore unused copyWith helpers"
fi
if rg -n '\btoJson\(' lib/core/contracts/relation_user_contract.dart; then
  fail "relation user contracts must not restore unused toJson helpers"
fi
check_no_dart_symbol '\b(_PagedListState|_\$PagedListState|PagedListStatePatterns|PagedListStateCopyWith)\b' \
  "paged list state Freezed shell must stay hand-owned"
check_no_dart_symbol '\b(_LiveRoomDetailModel|_\$LiveRoomDetailModel|LiveRoomDetailModelPatterns|LiveRoomDetailModelCopyWith)\b' \
  "live room detail Freezed shell must stay hand-owned"
check_no_dart_symbol '\b(liveDanmakuDefaultColor|liveDanmakuDefaultFontSize|liveDanmakuDefaultMode|liveDanmakuDefaultBubble)\b' \
  "live danmaku send defaults must stay API-private"
check_no_dart_symbol '\b(VideoSubtitlesDto|SubtitleInfoDto|SubtitleContentDto|SubtitleItemDto)\b' \
  "video subtitle DTO mirrors and copy mappers must stay archived"
check_no_dart_symbol '\b(_VideoSubtitles|_SubtitleInfo|_SubtitleContent|_SubtitleItem|_\$VideoSubtitles|_\$SubtitleInfo|_\$SubtitleContent|_\$SubtitleItem)\b' \
  "video subtitle Freezed shell must stay hand-owned"
if rg -n '\b_jsonInt\b' lib/features/video/application/models/subtitle.dart; then
  fail "video subtitle integer parsing must use JsonUtils directly"
fi
if rg -n '\b(copyWith|toJson)\(' lib/features/video/application/models/subtitle.dart; then
  fail "video subtitle read-model copyWith/toJson helpers must stay archived"
fi
check_no_dart_symbol '\b(_ProfileVideo|_\$ProfileVideo|ProfileVideoPatterns|ProfileVideoCopyWith)\b' \
  "profile video Freezed shell must stay hand-owned"
if rg -n '\bcopyWith\(' lib/features/profile/domain/entities/profile_video.dart; then
  fail "profile video copyWith helper must stay archived"
fi
if rg -n '\btoJson\(' lib/features/profile/domain/entities/profile_video.dart; then
  fail "profile video toJson helper must stay archived"
fi
if rg -n '\b_readPubDate\b' lib/features/profile/domain/entities/profile_video.dart; then
  fail "profile video pub-date helper must stay inline"
fi
check_no_dart_symbol '\b(_FavoriteFolder|_FavoriteResource|_FavoriteResourceStats|_FavoriteResourcePage|_\$FavoriteFolder|_\$FavoriteResource|_\$FavoriteResourceStats|_\$FavoriteResourcePage|FavoriteFolderPatterns|FavoriteResourcePatterns|FavoriteResourceStatsPatterns|FavoriteResourcePagePatterns)\b' \
  "favorites folder/resource Freezed shells must stay hand-owned"
if rg -n '\bcopyWith\(' lib/features/favorites/domain/entities/favorite_resource.dart; then
  fail "favorites resource read-model copyWith helpers must stay archived"
fi
if rg -n '\btoJson\(' lib/features/favorites/domain/entities/favorite_folder.dart; then
  fail "favorites folder read-model toJson helper must stay archived"
fi
if rg -n '\btoJson\(' lib/features/favorites/domain/entities/favorite_resource.dart; then
  fail "favorites resource read-model toJson helpers must stay archived"
fi
check_no_dart_symbol '\b(VideoPlayUrlDto)\b' \
  "video play-url DTO mirror must stay archived"
check_no_dart_symbol '\b(_PlayUrl|_DashInfo|_DashStream|_Durl|_SupportFormat|_\$PlayUrl|_\$DashInfo|_\$DashStream|_\$Durl|_\$SupportFormat|PlayUrlPatterns|DashInfoPatterns|DashStreamPatterns|DurlPatterns|SupportFormatPatterns)\b' \
  "video play-url Freezed shell must stay hand-owned"
if rg -n '\b(copyWith|toJson)\(' lib/features/video/application/models/play_url.dart; then
  fail "video play-url read-model copyWith/toJson helpers must stay archived"
fi
check_no_dart_symbol '\b(DanmakuProvider|danmakuProviderProvider)\b' \
  "video danmaku presentation provider wrapper must stay archived"
check_no_dart_symbol '\b(danmakuMask|danmakuMaskProvider)\b' \
  "video danmaku mask provider wrapper must stay application-owned"
check_no_dart_symbol '\b(DanmakuViewConfig|fetchDanmakuView)\b' \
  "unused video danmaku view metadata seam must stay archived"
check_no_dart_symbol '\b(PlayerInfo|DmMask)\b' \
  "video player-info danmaku-mask DTO wrapper must stay archived"
check_no_dart_symbol '\b_parseDanmakuMaskInfo\b' \
  "video player-info danmaku-mask parser must stay inline at the repository boundary"
check_no_dart_symbol '\b(RelatedVideo|RelatedVideoViewDataMapper)\b' \
  "video related-video DTO mirror and mapper must stay archived"
check_no_dart_symbol '\b(VideoTagViewData|VideoTagViewDataMapper)\b' \
  "video tag one-field view-data wrapper must stay archived"
check_no_dart_symbol '\b(VideoDimensionViewData|VideoDimensionViewDataMapper)\b' \
  "video dimension view-data mirror and copy mapper must stay archived"
check_no_dart_symbol '\b(VideoDetailViewDataMapper|VideoPartViewDataMapper|VideoRequestUserStateMapper|toVideoDetailViewData|toVideoPartViewData|toVideoRequestUserState)\b' \
  "video detail single-use mapper extensions must stay inlined"
if rg -n '\bcopyWith\(' lib/features/video/data/dtos/video_detail_dto.dart; then
  fail "video detail DTO copyWith helpers must stay archived"
fi
if rg -n '\btoJson\(' lib/features/video/data/dtos/video_detail_dto.dart; then
  fail "video detail DTO toJson helpers must stay archived"
fi
if find lib/features/video/presentation/detail \( -name 'video_detail_state.dart' -o -name 'video_detail_state.freezed.dart' \) -type f | rg .; then
  fail "video detail one-owner state shell must stay controller-owned"
fi
if find lib/features/video/presentation/comments \( -name 'comment_reply_state.dart' -o -name 'comment_reply_state.freezed.dart' \) -type f | rg .; then
  fail "comment reply one-owner state shell must stay controller-owned"
fi
if find lib/features/video/presentation/comments -name 'comment_reply_view_model.freezed.dart' -type f | rg .; then
  fail "comment reply controller state Freezed shell must stay hand-owned by its controller"
fi
if find lib/features/video/presentation/player -name 'listen_sleep_timer_view_model.freezed.dart' -type f | rg .; then
  fail "listen sleep timer two-field state shell must stay hand-owned by its controller"
fi
if rg -n '\b(copyWith|_unset)\b' lib/features/video/presentation/player/listen_sleep_timer_view_model.dart; then
  fail "listen sleep timer state unused copy helper and sentinel must stay archived"
fi
if rg -n '\b_PresetMinuteTextButton\b' lib/features/video/presentation/player/controls/listen_settings_sheet.dart; then
  fail "listen settings preset-minute button wrapper must stay sheet-owned"
fi
if rg -n '\b_showErrorDetails\b' lib/ui/widgets/feedback/app_error_widget.dart; then
  fail "app error details dialog helper must stay inline with AppErrorWidget"
fi
if rg -n '\b(_ErrorDetailsButton|_RetryButton)\b' lib/ui/widgets/feedback/app_error_widget.dart; then
  fail "app error button wrappers must stay inline with AppErrorWidget"
fi
if find lib/features/video/presentation/player -name 'playback_snapshot_view_model.freezed.dart' -type f | rg .; then
  fail "playback snapshot state Freezed shell must stay hand-owned by its provider"
fi
if find lib/features/video/presentation/overlays -name 'subtitle_view_model.freezed.dart' -type f | rg .; then
  fail "subtitle overlay state Freezed shell must stay hand-owned by its controller"
fi
if rg -n '\b(copyWith|_unset)\b' lib/features/video/presentation/overlays/subtitle_view_model.dart; then
  fail "subtitle overlay state unused copy helper and sentinel must stay archived"
fi
check_no_dart_symbol '\bHomeBreakpoints\b' \
  "home breakpoint facade class must stay layout-spec-owned"
check_no_dart_symbol '\b(videoCommentPrefetchCommentScanLimit|videoCommentPrefetchPictureScanLimit|videoCommentImagePrefetchLimit|videoCommentPictureMinLogicalSize|videoCommentPictureMaxLogicalSize|videoCommentPictureFallbackLogicalSize|videoRelatedImagePrefetchLimit|videoRelatedGridColumns|videoRelatedGridHorizontalPadding|videoRelatedGridColumnGap|videoRelatedCoverAspectRatio)\b' \
  "video prefetch tuning constants must stay owner-private"
check_no_dart_symbol '\bvideoCommentListCacheExtent\b' \
  "video comment cache extent constant must stay owner-private"
check_no_dart_symbol '\bVideoActionsBottomSheet\b' \
  "video actions bottom-sheet wrapper must stay home-owned"
check_no_dart_symbol '\b_buildDragHandle\b' \
  "home video actions drag handle helper must stay sheet-owned"
check_no_dart_symbol '\bUploaderSection\b' \
  "video detail uploader single-use wrapper must stay info-view-owned"
check_no_dart_symbol '\bVideoProgressBar\b' \
  "video progress bar single-use wrapper must stay overlay-private"
check_no_dart_symbol '\b(SeekRippleOverlay|GestureIndicator)\b' \
  "video gesture overlay single-use wrappers must stay interaction-layer-private"
check_no_dart_symbol '\bshowSidePanel\b' \
  "video controls side-panel helper must stay controls-owned"
check_no_dart_symbol '\bAppMinLinesText\b' \
  "single-use min-lines text wrapper must stay archived"
check_no_dart_symbol '\b_LiveAreaTag\b' \
  "live room area tag wrapper must stay card-owned"
check_no_dart_symbol '\bAppSectionHeader\b' \
  "search-only section header wrapper must stay page/section-owned"
check_no_dart_symbol '\bDynamicSkeleton\b' \
  "single-use dynamic skeleton wrapper must stay user-dynamic-feed-owned"
check_no_dart_symbol '\bRecentlyFollowedWidget\b' \
  "single-use dynamic recently-followed header must stay list-view-owned"
check_no_dart_symbol '\b(RecentlyFollowed|recentlyFollowedProvider)\b' \
  "single-consumer recently-followed provider must stay dynamic-list-owned"
check_no_dart_symbol '\b(GridSkeletonView|ListSkeletonView)\b' \
  "generic page skeleton wrappers must stay home-feed-owned"
check_no_dart_symbol '\b(DynamicFeedQuery|SpaceDynamicFeedQuery|TopicDynamicFeedQuery)\b' \
  "dynamic feed query-bag wrappers must stay archived"
check_no_dart_symbol '\b(TopicDynamicNotifier|topicDynamicProvider)\b' \
  "topic dynamic one-consumer provider must stay topic-detail-owned"
check_no_dart_symbol '\bDynamicVoteWidget\b' \
  "single-use dynamic vote wrapper must stay dynamic-content-owned"
check_no_dart_symbol '\b(DynamicCommonWidget|DynamicLinkCardWidget)\b' \
  "single-use dynamic common/link-card wrappers must stay dynamic-content-owned"
check_no_dart_symbol '\b(DynamicUgcWidget|DynamicVideoWidget)\b' \
  "single-use dynamic UGC/video wrappers must stay dynamic-content-owned"
if find lib/features/dynamic/domain/entities -name 'dynamic_content_entities.freezed.dart' -type f | rg .; then
  fail "dynamic content entity value objects must stay hand-written"
fi
if rg -n '\b(copyWith|_undefined)\b' lib/features/dynamic/domain/entities/dynamic_content_entities.dart; then
  fail "dynamic content entity unused copyWith helpers must stay archived"
fi
if rg -n '\b_listEquals\b' lib/features/dynamic/domain/entities/dynamic_content_entities.dart; then
  fail "dynamic content entity list equality must stay on flutter listEquals"
fi
check_no_dart_symbol '\b(DynamicGoodsWidget|DynamicReserveWidget)\b' \
  "single-use dynamic goods/reserve wrappers must stay dynamic-content-owned"
check_no_dart_symbol '\bDynamicImagesWidget\b' \
  "single-use dynamic image wrapper must stay dynamic-content-owned"
check_no_dart_symbol '\bDynamicForwardWidget\b' \
  "single-use dynamic forward wrapper must stay dynamic-content-owned"
check_no_dart_symbol '\b(showDynamicPostActions|DynamicPostAction)\b' \
  "single-use dynamic post action sheet must stay header-owned"
check_no_dart_symbol '\bDynamicContentSurface\b' \
  "single-owner dynamic content surface helper must stay dynamic-content-private"
check_no_dart_symbol '\b(PublishDynamicBottomToolbar|PublishDynamicImageGrid|EmojiPicker|TopicPicker)\b' \
  "publish dynamic page-only widgets/pickers must stay page-private"
check_no_dart_symbol '\b(FollowersPage|FollowingsPage)\b' \
  "profile relation route page wrappers must stay navigation-private"
if find lib/features/profile/domain/entities -name 'profile_user.freezed.dart' -type f | rg .; then
  fail "profile user domain value must stay hand-written"
fi
check_no_dart_symbol '\bAppOverlayTag\b' \
  "shared app overlay tag wrapper must stay card-owned"
check_no_dart_symbol '\bCommentImagesWidget\b' \
  "comment image single-owner wrapper must stay comment-item-owned"
check_no_dart_symbol '\b(PrivacyErrorWidget)\b' \
  "single-use profile privacy error wrapper must stay archived"
check_no_dart_symbol '\b(ProfileCacheRepositoryImpl|profileCacheRepository|ProfileCacheDatabase|profileCacheDatabase|CachedProfileUsers|profileUserCacheTtl|createProfileSessionLogoutCleaner)\b' \
  "profile cache repository/database and cleanup adapter must stay archived"
check_no_dart_symbol '\bUserHomeTab\b' \
  "profile home tab single-owner wrapper must stay page-private"
check_no_dart_symbol '\b(profileUserVideoListImagePrefetchLimit|profileUserVideoListCoverLogicalWidth|profileUserVideoListCoverLogicalHeight|profileVideoCoverAspectRatio)\b' \
  "profile video prefetch tuning constants must stay widget-private"
check_no_dart_symbol '\b(ProfileActionGrid)\b' \
  "profile action grid one-owner widget must stay page-owned"
if rg -n '\b_showMoreMenu\b' \
  lib/features/profile/presentation/widgets/user_profile_app_bar.dart; then
  fail "user profile app-bar more menu helper must stay inline"
fi
if rg -n '\b_showImagePreview\b' \
  lib/features/profile/presentation/widgets/user_profile_info.dart; then
  fail "profile image preview helper must stay inline"
fi
if rg -n '\b(_buildTitle|_buildTitleRow|_buildStatsRow|_buildSubtitle)\b' \
  lib/ui/widgets/users/user_list_tile.dart; then
  fail "user list tile text/stats helpers must stay inline"
fi
if rg -n '\b_resolveLabel\b' \
  lib/ui/widgets/buttons/follow_button.dart; then
  fail "follow button label helper must stay inline"
fi
if rg -n '\b(_backgroundColor|_foregroundColor)\b' \
  lib/ui/widgets/buttons/app_tag.dart; then
  fail "app tag color fallback helpers must stay inline"
fi
if rg -n '\b_buildShadow\b' \
  lib/ui/assemblies/users/user_tags.dart; then
  fail "VIP tag shadow helper must stay inline"
fi
if rg -n '\b_buildDecoration\b' \
  lib/ui/widgets/cards/app_card_container.dart; then
  fail "app card decoration wrapper must stay inline"
fi
if rg -n '\b(_buildTapHandler|_buildLongPressHandler)\b' \
  lib/ui/widgets/buttons/app_clickable.dart; then
  fail "app clickable tap/long-press handlers must stay inline"
fi
if rg -n '\b(_buildDecoration|_buildIndicator)\b' \
  lib/ui/widgets/layout/app_tab_bar.dart; then
  fail "app tab bar decoration/indicator helpers must stay inline"
fi
if rg -n '\b_normalizeBlockText\b' \
  lib/features/dynamic/presentation/pages/article_detail_page_block_renderers.paragraph.dart; then
  fail "article paragraph text normalization helper must stay inline"
fi
if rg -n '\b_StatChip\b' \
  lib/features/dynamic/presentation/pages/article_detail_page_scaffold.dart; then
  fail "article detail stat chip wrapper must stay inline"
fi
if rg -n '\b_ActionTile\b' \
  lib/features/settings/presentation/pages/about_page.dart; then
  fail "settings about-page action tile wrapper must stay inline"
fi
if rg -n '\b(_buildThumbnail|_buildContent)\b' \
  lib/ui/assemblies/feed_cards/video_list_skeleton.dart; then
  fail "video list skeleton thumbnail/content helpers must stay inline"
fi
if rg -n '\b(_buildHeader|_buildContent|_buildFooter)\b' \
  lib/features/dynamic/presentation/widgets/user_dynamic_feed.dart; then
  fail "user dynamic skeleton header/content/footer helpers must stay inline"
fi
if rg -n '\b_buildContent\b' \
  lib/ui/assemblies/feed_cards/video_card_skeleton.dart; then
  fail "video card skeleton content helper must stay inline"
fi
if rg -n '\b_overlayChildren\b' \
  lib/ui/assemblies/feed_cards/video_list_card.dart; then
  fail "video list-card overlay list getter must stay inline"
fi
if rg -n '\b_VideoReasonTag\b' \
  lib/ui/assemblies/feed_cards/video_card.dart; then
  fail "video card reason tag wrapper must stay inline"
fi
if rg -n '\b(_VideoCardTitle|_VideoCardDescription|_VideoCardFooter)\b' \
  lib/ui/assemblies/feed_cards/video_card.dart; then
  fail "video card title/description/footer wrappers must stay inline"
fi
if rg -n '\b_ThumbnailBottomOverlay\b' \
  lib/ui/assemblies/feed_cards/video_thumbnail.dart; then
  fail "video thumbnail bottom overlay wrapper must stay inline"
fi
if rg -n '\b_VideoThumbnailStats\b' \
  lib/ui/assemblies/feed_cards/video_thumbnail.dart; then
  fail "video thumbnail stats row wrapper must stay inline"
fi
if rg -n '\b_resolveCacheSize\b' \
  lib/ui/assemblies/feed_cards/video_thumbnail.dart; then
  fail "video thumbnail cache-size helper must stay inline"
fi
if rg -n '\b_buildSearchIcon\b' \
  lib/ui/widgets/inputs/app_search_bar.dart; then
  fail "app search bar icon helper must stay inline"
fi
if rg -n '\b(_buildReadonlySearchBar|_buildTextStyle)\b' \
  lib/ui/widgets/inputs/app_search_bar.dart; then
  fail "app search bar read-only prompt/text-style helpers must stay inline"
fi
if rg -n '\b(_RankingSkeletonItem|_RankingSkeletonThumbnail|_RankingSkeletonText)\b' \
  lib/features/ranking/presentation/pages/ranking_page.dart; then
  fail "ranking skeleton wrappers must stay inline"
fi
if rg -n '\b(_listEquals|_nullableListEquals)\b' \
  lib/core/data/pagination/paged_list_state.dart \
  lib/features/dynamic/application/models/dynamic_response.core.dart \
  lib/features/dynamic/application/models/dynamic_response.additional.dart \
  lib/features/dynamic/application/models/dynamic_response.major_primary.dart \
  lib/features/dynamic/application/models/dynamic_response.major_secondary.dart \
  lib/features/favorites/domain/entities/favorite_resource.dart \
  lib/features/live/application/models/live_danmu_info_model.dart \
  lib/features/live/application/models/live_gold_rank_model.dart \
  lib/features/live/application/models/live_guard_list_model.dart \
  lib/features/live/application/models/live_play_url_model.dart \
  lib/features/video/application/models/subtitle.dart; then
  fail "shared/dynamic/favorite/live/video read-model list-equality helpers must stay on flutter listEquals"
fi
if rg -n '\b_buildLoadingPlaceholder\b' \
  lib/ui/widgets/media/app_network_image.dart; then
  fail "app network image loading placeholder helper must stay inline"
fi
if rg -n '\b_RelationPrivacyError\b' \
  lib/features/profile/presentation/widgets/relation_user_list.dart; then
  fail "relation privacy error wrapper must stay inline"
fi
if rg -n '\b_showInputSheet\b' \
  lib/features/live/presentation/pages/live_room_page.dart; then
  fail "live room danmaku input sheet helper must stay inline"
fi
check_no_dart_symbol '\b(notificationOwnerUidProvider|notificationOwnerUid)\b' \
  "notification owner uid provider wrapper must stay archived"
check_no_dart_symbol '\b(PrivateSessionList|privateSessionListProvider)\b' \
  "notification private-session list provider must stay widget-private"
if rg -n '\b(_buildMessageSummary|_buildAvatar|_buildUnreadBadge)\b' \
  lib/features/notification/presentation/widgets/private_session_list.dart; then
  fail "notification private-session row helpers must stay inline"
fi
if rg -n '\b(_getActionText|_getSourceText)\b' \
  lib/features/notification/presentation/widgets/notification_item_widget.dart; then
  fail "notification feed item text helpers must stay inline"
fi
if rg -n '\b_refreshList\b' \
  lib/features/to_view/presentation/pages/to_view_page.dart; then
  fail "to-view refresh helper must stay inline"
fi
check_no_dart_symbol '\bshareVideo\b' \
  "video share one-call wrapper must stay archived"
if rg -n '\b_buildViewerAvatar\b' \
  lib/features/live/presentation/widgets/live_header.dart; then
  fail "live header viewer-avatar helper must stay inline"
fi
if rg -n '\b_buildTabs\b' \
  lib/features/home/presentation/pages/home_page.dart; then
  fail "home tab descriptor helper must stay inline"
fi
check_no_dart_symbol '\b(ScrollPrecacheBudget|resolveScrollPrecacheBudget)\b' \
  "scroll precache budget helper wrapper must stay hook-local"
if rg -n '\b_buildAppBar\b' \
  lib/features/video/presentation/player/video_listen_page.dart; then
  fail "video listen page app-bar helper must stay inline"
fi
check_no_dart_symbol '\b(NotificationFeedList|notificationFeedListProvider)\b' \
  "notification feed list provider must stay page-private"
check_no_dart_symbol '\b(CacheMaintenance|cacheMaintenanceProvider)\b' \
  "settings cache maintenance command wrapper must stay archived"
check_no_dart_symbol '\b(cacheSizeProvider)\b' \
  "settings cache-size provider wrapper must stay archived"
if rg -n '\b(_showLanguageSelector|_showThemeSelector|_handleClearCache)\b' \
  lib/features/settings/presentation/pages/settings_page.dart; then
  fail "settings page one-use helpers must stay inline"
fi
check_no_dart_symbol '\bLoginDialog\b' \
  "auth login dialog widget wrapper must stay archived"
check_no_dart_symbol '\bUseGeetestResult\b' \
  "auth Geetest hook result wrapper must stay record-owned by the hook"
check_no_dart_symbol '^[[:space:]]*((abstract|base|final|interface|sealed|mixin)[[:space:]]+)*class[[:space:]]+AuthSessionCookieRefresher\b' \
  "auth session cookie refresher adapter must stay provider-private"
check_no_dart_symbol '\b(categoryRankingList|categoryRankingListProvider)\b' \
  "ranking category provider must stay page-owned"
check_no_dart_symbol '\b(endpointPolicyResolver|endpointPolicyResolverProvider)\b' \
  "endpoint policy resolver provider wrapper must stay interceptor-owned"
check_no_dart_symbol '\bWbiSigner\b' \
  "WBI signer wrapper class must stay helper-owned"
check_no_dart_symbol '\b(RelationPort|relationPortProvider|AuthQrLoginPort|ArticleDetailPort|DynamicDetailPort|DynamicFeedPort|EmotePort|FavoritesPort|HomePort|NotificationChatPort|NotificationFeedPort|NotificationPrivateSessionPort|NotificationResumeSyncPort|NotificationSystemNoticePort|NotificationUnreadCountPort|ProfileCachePort|ProfileReadPort|UserSpacePort|RankingPort|SearchPort|DanmakuPort|SubtitlePort|VideoCommentPort|VideoDetailPort)\b' \
  "archived port/provider wrappers must stay archived"
check_no_dart_symbol '\b(AuthQrLoginStatus|AuthQrLoginState|AuthQrLoginController|authQrLoginControllerProvider)\b' \
  "auth QR login public page-state provider shell must stay archived"
check_no_dart_symbol '\b(NotificationResumeSyncService|notificationResumeSyncServiceProvider)\b' \
  "notification resume-sync one-caller service provider must stay lifecycle-owned"
check_no_dart_symbol '\bNotificationStreamWatchers\b' \
  "notification repository stream watcher delegate must stay repository-owned"
check_no_dart_symbol '\bNotificationLocalReadStore\b' \
  "notification repository local read-store delegate must stay repository-owned"
check_no_dart_symbol '\b(sendMessageResultFromJson|uploadedImageFromJson|_readNullableString)\b' \
  "notification send/upload mapper helpers must stay repository-owned"
check_no_dart_symbol '\b(DefaultSearchData|TrendingRankingResponse|TrendingRankingData)\b' \
  "search default/hot-ranking response shells must stay archived"
check_no_dart_symbol '\b(SearchSuggestionResponse|SearchSuggestionTag|SearchSuggestionTagsConverter)\b' \
  "search suggestion response/tag DTOs must stay archived"
if rg -n '\b_parseSuggestionText\b' lib/features/search/data/search_repository_impl.dart; then
  fail "search suggestion text fallback must stay inline"
fi
if rg -n '\b_parseSuggestionsResponse\b' lib/features/search/data/search_repository_impl.dart; then
  fail "search suggestion JSONP response parsing must stay inline"
fi
if rg -n '\b_parseDefaultSearchName\b' lib/features/search/data/search_repository_impl.dart; then
  fail "search default search-name parsing must stay inline"
fi
if rg -n '\b_parseTrendingRankingItems\b' lib/features/search/data/search_repository_impl.dart; then
  fail "search hot-ranking list-envelope parsing must stay inline"
fi
check_no_dart_symbol '\b(SearchResultResponse)\b' \
  "search result outer response shell must stay archived"
check_no_dart_symbol '\b(SearchResultData|SearchResultItem|SearchResultDataMapper|SearchResultItemMapper|_SearchResultConverter)\b' \
  "search result DTO/domain mirrors and copy mappers must stay archived"
check_no_dart_symbol '\b(SearchPageState|SearchPageMode|useSearchViewModel)\b' \
  "search page hook one-consumer state wrapper must stay archived"
check_no_dart_symbol '\b(class SearchResult|searchResultProvider)\b' \
  "search result one-widget state provider must stay result-view-owned"
check_no_dart_symbol '\bsearchResultPageSize\b' \
  "search API page-size default must stay API-private"
check_no_dart_symbol '\b(ChatImageAttachment|ChatSendResult|ChatSendStatus)\b' \
  "chat image/send result/status wrappers must stay archived"
check_no_dart_symbol '\b(_ChatHelpersMixin|_ChatSendMixin)\b' \
  "notification chat helper/send mixins must stay notifier-owned"
check_no_dart_symbol '\b(UploadedPublishImage|ImageUploadResult|imageUploadResultFromJson)\b' \
  "feature-local upload image result wrappers must stay archived"
check_no_dart_symbol '\b(LiveAnchorInfoModel|LiveAnchorInfo|LiveAnchorVerify|LiveAnchorExp|LiveMasterLevel|liveAnchorInfo)\b' \
  "live anchor-info wrapper tree must stay archived"
check_no_dart_symbol '\b(FavFolderListResponse|_FavFolderListMapper)\b' \
  "favorites folder-list response shell must stay archived"
check_no_dart_symbol '\b(FavResourceListResponse|_FavResourceListMapper)\b' \
  "favorites resource-list response shell must stay archived"
check_no_dart_symbol '\bFavFolderFormData\b' \
  "favorites folder dialog presentation DTO must stay archived"
check_no_dart_symbol '^[[:space:]]*((abstract|base|final|interface|sealed|mixin)[[:space:]]+)*class[[:space:]]+NavigationItems?\b' \
  "shell navigation item wrapper classes must stay archived"
check_no_dart_symbol '\b(buildDynamicRoutePage|buildDynamicDetailRoutePage|buildPublishDynamicRoutePage)\b' \
  "dynamic route page wrapper functions must stay archived"
check_no_dart_symbol '\b(HomeTabSyncState|HomeTabSyncController|homeTabSyncControllerProvider)\b' \
  "home tab sync public provider shell must stay archived"
check_no_dart_symbol '\brunVoid\b' \
  "request executor runVoid wrapper must stay archived"
check_no_dart_symbol '\b_fromBadResponse\b' \
  "AppError bad-response helper must stay in _fromDioException"

if (( failures != 0 )); then
  exit 1
fi

echo "architecture guards passed"
