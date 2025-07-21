import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({
    required this.message,
    required this.time,
    this.messageColor,
    this.timeColor,
    this.boxColor,
    this.isCurrentUser = true,
    this.isSeen,
    super.key,
  });

  final String message;
  final String time;
  final Color? messageColor;
  final Color? timeColor;
  final Color? boxColor;
  final bool isCurrentUser;
  final bool? isSeen;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.only(top: 8, right: 10, left: 10, bottom: 6),
        decoration: BoxDecoration(
          color: boxColor ??
              (isCurrentUser ? Colours.primaryDark : Colours.grey300),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(isCurrentUser ? 12 : 0),
            bottomRight: Radius.circular(isCurrentUser ? 0 : 12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: messageColor ??
                    (isCurrentUser ? Colours.grey300 : Colors.black),
              ),
            ),
            const SizedBox(width: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: timeColor ??
                        (isCurrentUser
                            ? Colours.grey400
                            : Colours.grey800),
                  ),
                ),
                const SizedBox(width: 3),
                if (isCurrentUser)
                  Icon(
                    Icons.done_all_outlined,
                    size: 12,
                    color: isSeen! ? Colours.success : Colours.grey400,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
