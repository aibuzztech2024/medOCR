
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

enum PaymentMethod {
  upi,
  card,
  cod,
}

class PaymentController extends GetxController {
  var selectedMethod = PaymentMethod.upi.obs;

  void selectMethod(PaymentMethod method) {
    selectedMethod.value = method;
  }
}
