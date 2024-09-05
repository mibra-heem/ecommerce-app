class JazzCashPayment {
  String ppAmount;
  String ppBankID;
  String ppBillReference;
  String ppDescription;
  String ppLanguage;
  String ppMerchantID;
  String ppPassword;
  String ppProductID;
  String ppReturnURL;
  String ppTxnCurrency;
  String ppTxnDateTime;
  String ppTxnExpiryDateTime;
  String ppTxnRefNo;
  String ppTxnType;
  String ppVersion;
  String ppmpf1;
  String ppmpf2;
  String ppmpf3;
  String ppmpf4;
  String ppmpf5;

  JazzCashPayment(
      {required this.ppAmount,
      this.ppBankID = "",
      required this.ppBillReference,
      required this.ppDescription,
      this.ppLanguage = "EN",
      required this.ppMerchantID,
      required this.ppPassword,
      this.ppProductID = "",
      required this.ppReturnURL,
      this.ppTxnCurrency = "PKR",
      this.ppTxnDateTime = "",
      this.ppTxnExpiryDateTime = "",
      this.ppTxnRefNo = "",
      this.ppTxnType = "",
      this.ppVersion = "1.1",
      this.ppmpf1 = "",
      this.ppmpf2 = "",
      this.ppmpf3= "",
      this.ppmpf4= "",
      this.ppmpf5= ""});

  // JazzCashPayment.fromJson(Map<String, dynamic> json) {
  //   ppAmount = json['pp_Amount'];
  //   ppBankID = json['pp_BankID'];
  //   ppBillReference = json['pp_BillReference'];
  //   ppDescription = json['pp_Description'];
  //   ppLanguage = json['pp_Language'];
  //   ppMerchantID = json['pp_MerchantID'];
  //   ppPassword = json['pp_Password'];
  //   ppProductID = json['pp_ProductID'];
  //   ppReturnURL = json['pp_ReturnURL'];
  //   ppTxnCurrency = json['pp_TxnCurrency'];
  //   ppTxnDateTime = json['pp_TxnDateTime'];
  //   ppTxnExpiryDateTime = json['pp_TxnExpiryDateTime'];
  //   ppTxnRefNo = json['pp_TxnRefNo'];
  //   ppTxnType = json['pp_TxnType'];
  //   ppVersion = json['pp_Version'];
  //   ppmpf1 = json['ppmpf_1'];
  //   ppmpf2 = json['ppmpf_2'];
  //   ppmpf3 = json['ppmpf_3'];
  //   ppmpf4 = json['ppmpf_4'];
  //   ppmpf5 = json['ppmpf_5'];
  // }
  //
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pp_Amount'] = this.ppAmount;
    data['pp_BankID'] = this.ppBankID;
    data['pp_BillReference'] = this.ppBillReference;
    data['pp_Description'] = this.ppDescription;
    data['pp_Language'] = this.ppLanguage;
    data['pp_MerchantID'] = this.ppMerchantID;
    data['pp_Password'] = this.ppPassword;
    data['pp_ProductID'] = this.ppProductID;
    data['pp_ReturnURL'] = this.ppReturnURL;
    data['pp_TxnCurrency'] = this.ppTxnCurrency;
    data['pp_TxnDateTime'] = this.ppTxnDateTime;
    data['pp_TxnExpiryDateTime'] = this.ppTxnExpiryDateTime;
    data['pp_TxnRefNo'] = this.ppTxnRefNo;
    data['pp_TxnType'] = this.ppTxnType;
    data['pp_Version'] = this.ppVersion;
    data['ppmpf_1'] = this.ppmpf1;
    data['ppmpf_2'] = this.ppmpf2;
    data['ppmpf_3'] = this.ppmpf3;
    data['ppmpf_4'] = this.ppmpf4;
    data['ppmpf_5'] = this.ppmpf5;
    return data;
  }
}
