import 'package:barber_link/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FormularioSociedadView extends StatelessWidget {
  const FormularioSociedadView({super.key});

  Future<void> _openForm(BuildContext context) async {
    const String formUrlString =
        'https://docs.google.com/forms/d/e/1FAIpQLSfcXvIvATttCq2z3CdtM4prY0Lq8p66Ya4K7tnfZjxRcznE1g/viewform?usp=dialog';
    try {
      final Uri formUrl = Uri.parse(formUrlString);
      if (!formUrl.isAbsolute || formUrl.scheme != 'https') {
        throw 'Enlace inválido: debe usar HTTPS';
      }
      if (await canLaunchUrl(formUrl)) {
        await launchUrl(formUrl, mode: LaunchMode.externalApplication);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Abriendo formulario...')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir el formulario')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    const String formUrlString =
        'https://docs.google.com/forms/d/e/1FAIpQLSfcXvIvATttCq2z3CdtM4prY0Lq8p66Ya4K7tnfZjxRcznE1g/viewform?usp=dialog';
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inscripción a la Sociedad',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors().azulMorado,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 600,
            width: 330,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'El siguiente boton lo dirigira al formulario que tiene que completar para hacer la solicitud: ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 19),
                ),
                const SizedBox(height: 15),
                ElevatedButton.icon(
                  onPressed: () => _openForm(context),
                  icon: const Icon(Icons.open_in_new, color: Colors.white),
                  label: const Text(
                    'Abrir Formulario',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors().azulMorado,

                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                const Text(
                  'En caso de no funcionar, copie y pegue el siguiente link en su navegador:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 15),
                SelectableText(
                  formUrlString,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
