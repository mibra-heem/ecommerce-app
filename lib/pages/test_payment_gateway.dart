// import 'package:flutter/material.dart';
// import '../api/api_client.dart';
// import '../constants/app_colors.dart';
// import '../utils/dimensions.dart';
//
// class TestPaymentGateway extends StatefulWidget {
//   TestPaymentGateway({super.key});
//
//   @override
//   State<TestPaymentGateway> createState() => _TestPaymentGatewayState();
// }
//
// class _TestPaymentGatewayState extends State<TestPaymentGateway> {
//
//
//   Api _api = Api()..postAmount();
//
//   void getPrice() {
//     setState(() {});
//   }
//
//   int price = 1000;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           margin: EdgeInsets.all(Dimensions.height30),
//           height: Dimensions.height45 * 10,
//           width: double.maxFinite,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(Dimensions.radius15),
//               boxShadow: [
//                 BoxShadow(
//                     color: const Color.fromARGB(255, 210, 210, 210),
//                     // spreadRadius:10,
//                     blurRadius: 10,
//                     offset: Offset(4, 4))
//               ]),
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: Dimensions.height45* 2,
//               ),
//               // Image(image: AssetImage("")),
//               Text(
//                 'Rs ${price}',
//                 style: TextStyle(fontSize: Dimensions.font20 *1.5),
//               ),
//               SizedBox(
//                 height: Dimensions.height45* 2,
//               ),
//               InkWell(
//                   onTap: () {
//                     // _payViaJazzCash(context);
//                     // Get.to(()=> Payment(), arguments: price);
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(Dimensions.height10),
//                     height: Dimensions.height30 * 2,
//                     width: Dimensions.height30 * 6,
//                     decoration: BoxDecoration(
//                       color: AppColor.mainColor,
//                       borderRadius: BorderRadius.circular(Dimensions.radius12),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Purchase Now",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: Dimensions.font20,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   // Future _payViaJazzCash(BuildContext c) async {
//   //   // print("clicked on Product ${element.name}");
//
//   //   DateTime date = DateTime.now();
//   //   DateFormat formatter = DateFormat('yyyyMMddHHmmss');
//   //   String ppTxnRefNo = 'T' + formatter.format(date);
//   //   String ppTxnDateTime = formatter.format(date);
//   //   DateTime expiryDate = date.add(Duration(hours: 2));
//   //   String ppTxnExpiryDateTime = formatter.format(expiryDate);
//   //   String paymentStatus = "pending";
//   //   String productPrice = '1000' ;
//   //   String productName = 'book';
//   //   String integritySalt= "3843w35439";
//   //   String merchantID= "MC94341";
//   //   String merchantPassword = "s2z85z0wx9";
//   //   // String transactionUrl= "";
//
//   //   // mobile no 03123456789 cnic last 6 digits 345678
//
//   //   try {
//   //     JazzCashFlutter jazzCashFlutter = JazzCashFlutter(
//   //       merchantId: merchantID,
//   //       merchantPassword: merchantPassword,
//   //       integritySalt: integritySalt,
//   //       isSandbox: true,
//   //     );
//
//
//   //     JazzCashPaymentDataModelV1 paymentDataModelV1 = JazzCashPaymentDataModelV1(
//   //       ppAmount: '${productPrice}',
//   //       ppBillReference:'refbill${date}${date.month}${date.day}${date.hour}${date.millisecond}',
//   //       ppDescription: 'Product details  ${productName} - ${productPrice}',
//   //       ppMerchantID: merchantID,
//   //       ppPassword:  merchantPassword,
//   //       ppReturnURL: 'https://localhost/test.com',
//   //       ppBankID: '',
//   //       ppLanguage: 'EN',
//   //       ppProductID: '1',
//   //       ppTxnCurrency: 'PKR',
//   //       ppTxnDateTime: ppTxnDateTime,
//   //       ppTxnExpiryDateTime: ppTxnExpiryDateTime,
//   //       ppTxnRefNo: ppTxnRefNo,
//   //       ppVersion: '1.1',
//   //       ppTxnType: 'MWALLET',
//   //       ppmpf1: '1',
//   //       ppmpf2: '2',
//   //       ppmpf3: '3',
//   //       ppmpf4: '4',
//   //       ppmpf5: '5'
//   //     );
//
//   //     print(paymentDataModelV1.ppTxnExpiryDateTime);
//   //     print(paymentDataModelV1.ppTxnDateTime);
//
//   //     print(paymentDataModelV1.ppTxnRefNo);
//
//   //     jazzCashFlutter.startPayment(paymentDataModelV1: paymentDataModelV1, context: context).then((_response) {
//   //       print("response from jazzcash $_response");
//
//   //       // _checkIfPaymentSuccessfull(_response, context).then((res) {
//   //       //   // res is the response you returned from your return url;
//   //       //   return res;
//   //       // });
//
//   //       setState(() {});
//   //     });
//   //   } catch (err) {
//   //     print("Error in payment $err");
//   //     // CommonFunctions.CommonToast(
//   //     //   message: "Error in payment $err",
//   //     // );
//   //     return false;
//   //   }
//   // }
//
// }
//
//
//
//
