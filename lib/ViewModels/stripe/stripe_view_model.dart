import 'package:barber_link/services/stripe_add_card_services.dart';
import 'package:flutter/material.dart';

class StripeViewModel extends ChangeNotifier {
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> saveCard() async {
    try {
      await StripeAddCardServices.instance.saveCard();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    notifyListeners();
  }
}
