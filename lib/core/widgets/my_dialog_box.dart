import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/core/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDialogBox extends StatelessWidget {
  const AppDialogBox({
    super.key,
    this.height,
    this.title,
    this.content,
    this.confirmText = 'Yes',
    this.cancelText = 'No',
    this.titleColor = Colours.primary,
    this.onConfirmColor = Colours.primary,
    this.onCancelColor,
    this.onConfirmTextColor = Colours.white,
    this.onCancelTextColor,
    this.isMessageDialog = false,
    this.showTitle = true,
    this.onConfirm,
    this.onCancel,
  });

  const AppDialogBox.message({
    super.key,
    this.height,
    this.title,
    this.content,
    this.confirmText = 'Ok',
    this.showTitle = false,
    this.onConfirm,
    this.titleColor,
    this.onConfirmColor,
    this.onConfirmTextColor,
  }) : isMessageDialog = true,
       cancelText = null,
       onCancel = null,
       onCancelColor = null,
       onCancelTextColor = null,
       assert(content != '', 'Content is required for message dialog');

  const AppDialogBox.alert({
    super.key,
    this.height,
    this.title,
    this.content,
    this.confirmText = 'Yes',
    this.cancelText = 'No',
    this.titleColor = Colors.red,
    this.onConfirmColor = Colors.red,
    this.onCancelColor,
    this.onConfirmTextColor = Colours.white,
    this.onCancelTextColor,
    this.showTitle = true,
    this.onConfirm,
    this.onCancel,
  }) : isMessageDialog = false,
       assert(content != '', 'Content is required for message dialog');

  final String? title;
  final double? height;
  final String? content;
  final String confirmText;
  final String? cancelText;
  final Color? titleColor;
  final Color? onConfirmColor;
  final Color? onCancelColor;
  final Color? onConfirmTextColor;
  final Color? onCancelTextColor;
  final bool isMessageDialog;
  final bool showTitle;
  final void Function()? onConfirm;
  final void Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        alignment: Alignment.topRight,
        padding: const EdgeInsets.all(20),
        height: height ?? context.height * 0.24,
        width: context.width * 0.80,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment:
              isMessageDialog
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (showTitle)
              Text(
                isMessageDialog ? title ?? 'Message' : title ?? 'Confirmation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: titleColor,
                ),
              ),
            Text(
              isMessageDialog
                  ? content ?? 'message has been sent'
                  : content ?? 'Are you sure? you want to exit the app.',
              style: const TextStyle(fontSize: 14),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onConfirm,
                  style: TextButton.styleFrom(
                    backgroundColor: onConfirmColor,
                    foregroundColor: onConfirmTextColor,
                    splashFactory: InkRipple.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        isMessageDialog ? 30 : 12,
                      ),
                    ),
                  ),
                  child: Text(
                    confirmText,
                  ),
                ),
                const SizedBox(width: 15),
                if (isMessageDialog)
                  const SizedBox()
                else
                  TextButton(
                    onPressed:
                        onCancel ?? () => context.pop(false),
                    style: TextButton.styleFrom(
                      backgroundColor: onCancelColor,
                      foregroundColor: onCancelTextColor,
                      splashFactory: InkSparkle.splashFactory,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      cancelText!,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
