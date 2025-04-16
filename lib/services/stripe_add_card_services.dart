import 'package:barber_link/const/stripe_key.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeAddCardServices {
  StripeAddCardServices._();

  static final StripeAddCardServices instance = StripeAddCardServices._();

  Future<void> saveCard() async {
    try {
      final customerId = await _createCustomer();
      if (customerId == null) return;

      String? setUpIntentClientSecret = await _createSetUpIntent();
      if (setUpIntentClientSecret == null) return;

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          setupIntentClientSecret: setUpIntentClientSecret,
          merchantDisplayName: 'BarberLink',
        ),
      );

      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      rethrow;
    }
  }

  //CREAR CUSTOMER
  Future<String?> _createCustomer() async {
    try {
      final Dio dio = Dio();
      final response = await dio.post(
        'https://api.stripe.com/v1/customers',
        options: Options(headers: {"Authorization": "Bearer $secretKey"}),
      );
      if (response.data != null) {
        return response.data['id'];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> _createSetUpIntent() async {
    try {
      final Dio dio = Dio();
      final response = await dio.post(
        'https://api.stripe.com/v1/setup_intents',
        data: {"usage": "off_session"},
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $secretKey",
            "Content-Type": 'application/x-www-form-urlencoded',
          },
        ),
      );
      if (response.data != null) {
        return response.data['client_secret'];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
