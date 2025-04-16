import 'package:barber_link/services/stripe_payment_service.dart';
import 'package:flutter/foundation.dart';

class StripePaymentViewModel extends ChangeNotifier {
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> makePayment(int value) async {
    try {
      StripePaymentService.instance.makePayment(value);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    notifyListeners();
  }
}
