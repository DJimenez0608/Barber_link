// lib/Views/home/admin/memberships/add_edit_membership_view.dart
import 'package:barber_link/Models/membership_model.dart';
import 'package:barber_link/Theme/app_colors.dart';
import 'package:barber_link/ViewModels/admin/membership_view_model.dart';
import 'package:barber_link/Views/Widgets/boton.dart'; // Reutilizando tu widget Boton
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddEditMembershipView extends StatefulWidget {
  final MembershipModel? membership; // Null si es para agregar, con datos si es para editar

  const AddEditMembershipView({super.key, this.membership});

  @override
  State<AddEditMembershipView> createState() => _AddEditMembershipViewState();
}

class _AddEditMembershipViewState extends State<AddEditMembershipView> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nombrePlanController;
  late TextEditingController _descripcionController;
  late TextEditingController _precioController;
  late TextEditingController _duracionController;
  late TextEditingController _condicionesController;
  late List<MembershipBenefit> _beneficios;

  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.membership != null;

    _nombrePlanController = TextEditingController(text: widget.membership?.nombrePlan ?? '');
    _descripcionController = TextEditingController(text: widget.membership?.descripcion ?? '');
    _precioController = TextEditingController(text: widget.membership?.precio.toStringAsFixed(0) ?? ''); // Mostrar sin decimales si es .00
    _duracionController = TextEditingController(text: widget.membership?.duracion ?? '');
    _condicionesController = TextEditingController(text: widget.membership?.condiciones ?? '');
    // Copiar la lista de beneficios para poder modificarla localmente
    _beneficios = widget.membership?.beneficios.map((b) => MembershipBenefit(nombreServicio: b.nombreServicio, cantidad: b.cantidad)).toList() ?? [];
  }

  @override
  void dispose() {
    _nombrePlanController.dispose();
    _descripcionController.dispose();
    _precioController.dispose();
    _duracionController.dispose();
    _condicionesController.dispose();
    super.dispose();
  }

  void _addBenefitField() {
    setState(() {
      _beneficios.add(MembershipBenefit(nombreServicio: '', cantidad: 1));
    });
  }

  void _removeBenefitField(int index) {
    setState(() {
      _beneficios.removeAt(index);
    });
  }

  void _updateBenefitName(int index, String name) {
    setState(() {
      _beneficios[index].nombreServicio = name;
    });
  }

  void _updateBenefitQuantity(int index, String quantity) {
    setState(() {
      _beneficios[index].cantidad = int.tryParse(quantity) ?? 1;
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Asegura que onSaved se llame si los usas

      final viewModel = Provider.of<MembershipViewModel>(context, listen: false);
      
      // Validar que los beneficios tengan nombre y cantidad > 0
      for (var beneficio in _beneficios) {
        if (beneficio.nombreServicio.trim().isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Todos los beneficios deben tener un nombre.'), backgroundColor: Colors.orange),
          );
          return;
        }
        if (beneficio.cantidad <= 0) {
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('La cantidad para cada beneficio debe ser mayor a cero.'), backgroundColor: Colors.orange),
          );
          return;
        }
      }


      final membershipData = MembershipModel(
        id: widget.membership?.id, // Mantener el ID si se está editando
        nombrePlan: _nombrePlanController.text.trim(),
        descripcion: _descripcionController.text.trim(),
        precio: double.tryParse(_precioController.text.trim()) ?? 0.0,
        duracion: _duracionController.text.trim(),
        beneficios: _beneficios,
        condiciones: _condicionesController.text.trim(),
        createdAt: widget.membership?.createdAt, // Mantener el original si se edita
      );

      bool success;
      if (_isEditMode) {
        success = await viewModel.updateMembership(membershipData);
      } else {
        success = await viewModel.addMembership(membershipData);
      }

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Membresía ${(_isEditMode ? "actualizada" : "agregada")} exitosamente.'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop(); // Volver a la lista
        } else if (viewModel.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${viewModel.errorMessage}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MembershipViewModel>(context, listen: false); // Solo para submit

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditMode ? 'Editar Membresía' : 'Agregar Nueva Membresía',
          style: TextStyle(color: AppColors().blanco),
        ),
        backgroundColor: AppColors().azulMorado,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors().blanco),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildTextFormField(
                controller: _nombrePlanController,
                label: 'Nombre del Plan',
                icon: Icons.card_membership,
                validator: (value) => (value == null || value.isEmpty) ? 'Ingresa el nombre del plan' : null,
              ),
              const SizedBox(height: 15),
              _buildTextFormField(
                controller: _descripcionController,
                label: 'Descripción',
                icon: Icons.description,
                maxLines: 3,
                validator: (value) => (value == null || value.isEmpty) ? 'Ingresa una descripción' : null,
              ),
              const SizedBox(height: 15),
              _buildTextFormField(
                controller: _precioController,
                label: 'Precio (Ej: 50000)',
                icon: Icons.attach_money,
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Ingresa el precio';
                  if (double.tryParse(value) == null) return 'Ingresa un número válido';
                  if (double.parse(value) <= 0) return 'El precio debe ser mayor a cero';
                  return null;
                },
              ),
              const SizedBox(height: 15),
              _buildTextFormField(
                controller: _duracionController,
                label: 'Duración (Ej: Mensual, 30 días, Anual)',
                icon: Icons.timer,
                validator: (value) => (value == null || value.isEmpty) ? 'Ingresa la duración' : null,
              ),
              const SizedBox(height: 15),
              _buildTextFormField(
                controller: _condicionesController,
                label: 'Condiciones y Restricciones',
                icon: Icons.gavel,
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              Text(
                'Beneficios Incluidos:',
                style: GoogleFonts.jua(fontSize: 18, color: AppColors().azulMorado),
              ),
              const SizedBox(height: 5),
              if (_beneficios.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Aún no se han agregado beneficios. Haz clic en "Agregar Beneficio".',
                    style: GoogleFonts.inter(color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ..._buildBenefitFields(),
              const SizedBox(height: 10),
              TextButton.icon(
                icon: Icon(Icons.add_circle_outline, color: AppColors().azulMorado),
                label: Text('Agregar Beneficio', style: TextStyle(color: AppColors().azulMorado)),
                onPressed: _addBenefitField,
              ),
              const SizedBox(height: 30),
              Consumer<MembershipViewModel>( // Para el estado de carga del botón
                builder: (context, model, child) {
                  return Boton(
                    label: model.isLoading
                        ? 'Guardando...'
                        : (_isEditMode ? 'Actualizar Membresía' : 'Guardar Membresía'),
                    onTap: model.isLoading ? null : _submitForm,
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBenefitFields() {
    List<Widget> fields = [];
    for (int i = 0; i < _beneficios.length; i++) {
      fields.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _beneficios[i].nombreServicio,
                    decoration: InputDecoration(
                      labelText: 'Nombre del Servicio/Beneficio ${i + 1}',
                      border: const OutlineInputBorder(),
                      suffixIcon: i > 0 || _beneficios.length > 1 // Mostrar solo si hay más de uno o no es el primero
                        ? IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                            onPressed: () => _removeBenefitField(i),
                          )
                        : null,
                    ),
                    onChanged: (name) => _updateBenefitName(i, name),
                    validator: (value) => (value == null || value.isEmpty) ? 'Ingresa nombre del beneficio' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: _beneficios[i].cantidad.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Cantidad Incluida',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (qty) => _updateBenefitQuantity(i, qty),
                    validator: (value) {
                       if (value == null || value.isEmpty) return 'Ingresa cantidad';
                       if (int.tryParse(value) == null) return 'Cantidad inválida';
                       if (int.parse(value) <= 0) return 'Debe ser mayor a 0';
                       return null;
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return fields;
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        prefixIcon: icon != null ? Icon(icon, color: AppColors().azulMorado) : null,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors().azulMorado, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      style: GoogleFonts.inter(),
    );
  }
}
