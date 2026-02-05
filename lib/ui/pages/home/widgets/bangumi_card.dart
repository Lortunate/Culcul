import 'package:culcul/data/models/bangumi/timeline_model.dart';
import 'package:culcul/ui/theme/app_colors.dart';
import 'package:culcul/ui/widgets/app_network_image.dart';
import 'package:flutter/material.dart';

class BangumiCard extends StatelessWidget {
  final TimelineResponse item;

  const BangumiCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Text(
                item.isToday == 1 ? '今天' : item.date,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (item.dayOfWeek > 0) ...[
                const SizedBox(width: 8),
                Text(
                  _getDayOfWeek(item.dayOfWeek),
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.7,
          ),
          itemCount: item.episodes.length,
          itemBuilder: (context, epIndex) {
            final ep = item.episodes[epIndex];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: AppNetworkImage(
                      url: ep.squareCover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  ep.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  ep.pubIndex,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  String _getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return '周一';
      case 2:
        return '周二';
      case 3:
        return '周三';
      case 4:
        return '周四';
      case 5:
        return '周五';
      case 6:
        return '周六';
      case 7:
        return '周日';
      default:
        return '';
    }
  }
}
