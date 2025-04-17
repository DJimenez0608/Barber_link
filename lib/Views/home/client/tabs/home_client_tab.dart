import 'package:barber_link/Views/Widgets/pagar_servicio.dart';
import 'package:flutter/material.dart';

class HomeClientTab extends StatelessWidget {
  const HomeClientTab({super.key, this.onChanged});

  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                hintText: 'Buscar...',
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text('Servicios disponbles: ', style: TextStyle(fontSize: 18)),

          PagarServicio(
            value: 10,
            label: 'Corte de pelo PREMIUM',
            image: 'assets/Images/corte.png',
          ),
          PagarServicio(
            value: 5,
            label: 'Corte de pelo CLASICO',
            image: 'assets/Images/clasico.png',
          ),
        ],
      ),
    );
  }
}
