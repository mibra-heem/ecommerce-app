import 'dart:io';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewOrderReceipt extends StatelessWidget {
  const ViewOrderReceipt({
    required this.pdfBytes,
    super.key,
  });

  final Uint8List pdfBytes;

  static Future<bool> _isAndroid13OrAbove() async {
    if (!Platform.isAndroid) return false;
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    return deviceInfo.version.sdkInt >= 33; // Android 13 is API 33
  }

  Future<void> savePdfToDownloads(BuildContext context) async {
    // Request permission
    var hasPermission = false;
    if (Platform.isAndroid) {
      if (await _isAndroid13OrAbove()) {
        final status = await Permission.manageExternalStorage.request();
        hasPermission = status.isGranted;
      } else {
        final status = await Permission.storage.request();
        hasPermission = status.isGranted;
      }

      if (!hasPermission) {
        await openAppSettings();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission denied')),
        );
        throw Exception('Storage permission not granted');
      }
      try {
        // Path
        var downloadsDir = Directory('/storage/emulated/0/Download');
        if (!await downloadsDir.exists()) {
          downloadsDir = await getExternalStorageDirectory() ??
              await getApplicationDocumentsDirectory();
        }

        final filePath =
            '${downloadsDir.path}/order_receipt_${DateTime.now().millisecondsSinceEpoch}.pdf';
        final file = File(filePath);
        await file.writeAsBytes(pdfBytes);
        debugPrint('PDF saved to: $filePath');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF saved to: $filePath')),
        );
      } on Exception catch (e) {
        debugPrint('Error saving PDF: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save PDF: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Receipt'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              savePdfToDownloads(context);
              // context.pop();
            },
          ),
        ],
      ),
      body: SfPdfViewer.memory(pdfBytes),
    );
  }
}
