import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/core/resources/media.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.image,
    this.unSeenMsgCount = 0,
    this.isLabelVisible = false,
    this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final String time;
  final String? image;
  final bool isLabelVisible;
  final int unSeenMsgCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            CircleAvatar(
              radius: 24,
              backgroundImage:
                  image != null
                      ? NetworkImage(image!)
                      : const AssetImage(Media.defaultShoeImage)
                          as ImageProvider,
            ),
            const SizedBox(width: 12),

            // Title, subtitle, and time
            Expanded(
              child: Badge(
                isLabelVisible: isLabelVisible,
                alignment: const Alignment(0.92, 0.35),
                padding: const EdgeInsets.all(2),
                label: Text(unSeenMsgCount.toString()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row: title and time
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          time,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Subtitle
                    SizedBox(
                      width:
                          isLabelVisible ? context.width * 0.72 : context.width,
                      child: Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.grey,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
