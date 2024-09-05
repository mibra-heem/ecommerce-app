import 'package:get/get.dart';

enum PaymentMethod { cashOnDelivery, jazzCash, easyPaisa, bankAccount }


class CheckoutController extends GetxController {
    Rx<PaymentMethod?> selectedPaymentMethod = Rx<PaymentMethod?>(null);


var price = 4500;

bool selected = false;
bool selected1 = false;
bool selected2 = false;
bool selected3 = false;



//  void togglePaymentMethod(PaymentMethod? method) {
//     if (selectedPaymentMethod.value == method) {
//       selectedPaymentMethod.value = null; // Deselect if already selected
//     } else {
//       selectedPaymentMethod.value = method; // Select
//     }
//   }


void isSelected ()
{

selected = !selected;
    update();

}

void isSelected1 ()
{

selected1 = !selected1;
    update();

}

void isSelected2 ()
{

selected2 = !selected2;
    update();

}
void isSelected3 ()
{
selected3 = !selected3;
    update();

}



}
