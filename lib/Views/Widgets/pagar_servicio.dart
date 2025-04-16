import 'package:barber_link/ViewModels/stripe/stripe_payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PagarServicio extends StatelessWidget {
  final int value;
  const PagarServicio({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.grey[300],
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/Images/corte.png'),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Corte de pelo PREMIUM', style: TextStyle(fontSize: 15)),
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
            icon: Icon(Icons.monetization_on, size: 40),
          ),
        ],
      ),
    );
  }
}
