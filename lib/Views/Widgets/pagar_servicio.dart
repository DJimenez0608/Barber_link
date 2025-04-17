import 'package:barber_link/ViewModels/stripe/stripe_payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PagarServicio extends StatelessWidget {
  final int value;
  final String label;
  final String image;

  const PagarServicio({
    super.key,
    required this.value,
    required this.label,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        color: Colors.grey[300],
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(height: 70, width: 70, child: Image.asset(image)),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: TextStyle(fontSize: 15)),
                Text('Preciodel servicio: ${value.toString()}\$'),
              ],
            ),
            SizedBox(width: 40),
            IconButton(
              onPressed: () async {
                final viewModel = context.read<StripePaymentViewModel>();
                await viewModel.makePayment(value);

                if (viewModel.errorMessage != null) {
                  SnackBar(content: Text(viewModel.errorMessage!));
                } else {
                  SnackBar(content: Text('Pago exitoso'));
                }
              },
              icon: Icon(Icons.payment, size: 40, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
