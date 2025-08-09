import 'dart:io';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:pdf/widgets.dart' as pw;

class OrderPDFGenerator {
  static Future<Uint8List> generateOrderReceiptPdf({
    required String recipientName,
    required String address,
    required List<Map<String, dynamic>> items,
    required double subtotal,
    required double shipping,
    required double total,
    required String paymentMethod,
  }) async {
    final pdf = pw.Document()
      ..addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Order Receipt',
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.Text('Recipient: $recipientName'),
                pw.Text('Address: $address'),
                pw.Text('Payment Method: $paymentMethod'),
                pw.SizedBox(height: 20),
                pw.Text('Items:'),
                ...items.map((item) => pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('${item['name']} (x${item['quantity']})'),
                        pw.Text('Rs. ${item['total']}'),
                      ],
                    )),
                pw.Divider(),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Subtotal'),
                      pw.Text('Rs. ${subtotal.toStringAsFixed(0)}'),
                    ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Shipping'),
                      pw.Text('Rs. ${shipping.toStringAsFixed(0)}'),
                    ]),
                pw.Divider(),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Total',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      pw.Text('Rs. ${total.toStringAsFixed(0)}',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ]),
              ],
            );
          },
        ),
      );

    // Request permission
    // var hasPermission = false;
    // if (Platform.isAndroid) {
    //   if (await _isAndroid13OrAbove()) {
    //     final status = await Permission.manageExternalStorage.request();
    //     hasPermission = status.isGranted;
    //   } else {
    //     final status = await Permission.storage.request();
    //     hasPermission = status.isGranted;
    //   }

    //   if (!hasPermission) {
    //     await openAppSettings();
    //     throw Exception('Storage permission not granted');
    //   }
    // }

    // // Path
    // var downloadsDir = Directory('/storage/emulated/0/Download');
    // if (!await downloadsDir.exists()) {
    //   downloadsDir = await getExternalStorageDirectory() ??
    //       await getApplicationDocumentsDirectory();
    // }

    // final filePath =
    //     '${downloadsDir.path}/order_receipt_${DateTime.now().millisecondsSinceEpoch}.pdf';
    // final file = File(filePath);
    // await file.writeAsBytes(await pdf.save());

    return pdf.save();
  }

  static Future<bool> _isAndroid13OrAbove() async {
    if (!Platform.isAndroid) return false;
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    return deviceInfo.version.sdkInt >= 33; // Android 13 is API 33
  }
}
