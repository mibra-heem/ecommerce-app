import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';

class DialogBox extends StatelessWidget {

  String? title;
  double? height;
  String? message;
  String confirmText;
  String? cancelText;
  bool isMessageDialog;
  bool showTitle;
  void Function()? onConfirm;
  void Function()? onCancel;
  

  DialogBox({
    this.height,
    this.title,
    this.message,
    this.confirmText = 'Yes',
    this.cancelText = 'No',
    this.isMessageDialog = false,
    this.showTitle = true,
    this.onConfirm,
    this.onCancel
    });

  DialogBox.message({
    this.height,
    this.title,
    this.message,
    this.confirmText = 'Ok',
    this.isMessageDialog = true,
    this.showTitle = false,
    this.onConfirm,
    });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        alignment: Alignment.topRight,
        padding: EdgeInsets.all(20.h),
        height: height ?? Get.context!.height * 0.24,
        width: Get.context!.width * 0.75,        
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.h)
        ),
        child: Column(
          crossAxisAlignment: isMessageDialog ? CrossAxisAlignment.start : CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // showTitle 
            // ?
            Text(
              isMessageDialog 
              ? title ?? 'Message'
              : title ?? 'Confirmation',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500
              ),
            ),
           
            // SizedBox(
            //   height: 10.h,
            // ),
            Text(
              isMessageDialog 
              ? message ?? 'message has been sent'
              : message ?? 'Are you sure? you want to exit the app.',
              style: TextStyle(
                fontSize: 14.sp,
                // fontWeight: FontWeight.w300
              ),
            ),
            // SizedBox(
            //   height: 15.h,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onConfirm,
                  child: Text(
                    confirmText,
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                  style: ButtonStyle(
                    splashFactory: InkRipple.splashFactory,
                    overlayColor: WidgetStatePropertyAll(const Color.fromARGB(255, 174, 174, 174).withOpacity(0.2)),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        isMessageDialog 
                        ? 30.h
                        : 12.h
                        ),
                      side: BorderSide(color: Colors.black)
                      ))
                  ),
                ),
                SizedBox(
                  width: 15.h,
                ),
                isMessageDialog
                ? Container()
                : TextButton(
                  onPressed: onCancel,
                  child: Text(
                    cancelText!,
                    style: TextStyle(
                      color: AppColor.white
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColor.mainColor),
                    splashFactory: InkSparkle.splashFactory,
                    overlayColor: WidgetStatePropertyAll(const Color.fromARGB(255, 174, 174, 174).withOpacity(0.1)),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.h),
                      side: BorderSide(color: AppColor.mainColor)
                      ))
                  ),
                )
              ],
            )
          ],
        ),
      ),
      // shadowColor: Colors.white,
      
    );
  }
}
