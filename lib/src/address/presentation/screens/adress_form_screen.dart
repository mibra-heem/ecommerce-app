import 'package:ecommerce_app/core/app/resources/colors.dart';
import 'package:ecommerce_app/core/extensions/context_extension.dart';
import 'package:ecommerce_app/src/address/domain/entities/address.dart';
import 'package:ecommerce_app/src/address/presentation/provider/address_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddressFormScreen extends StatefulWidget {
  const AddressFormScreen({super.key, this.existingAddress});
  final Address? existingAddress;

  @override
  State<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _recipientController;
  late TextEditingController _phoneController;
  late TextEditingController _streetController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _postalController;
  late TextEditingController _countryController;

  /// Radio Selection for address type (Home/Work)
  String _addressType = 'Home';
  bool _isDefault = false;

  @override
  void initState() {
    super.initState();
    final address = widget.existingAddress;
    _recipientController = TextEditingController(
        text: address?.recipientName ?? '');
    _phoneController =
        TextEditingController(text: address?.phone ?? '');
    _streetController = TextEditingController(
        text: address?.street ??
            '');
    _cityController = TextEditingController(text: address?.city ?? '');
    _stateController = TextEditingController(text: address?.state ?? '');
    _postalController =
        TextEditingController(text: address?.postalCode ?? '');
    _countryController =
        TextEditingController(text: address?.country ?? '');
    _isDefault = address?.isDefault ?? false;
    _addressType = address?.name ?? 'Home'; // Default to Home
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void _saveAddress() {
    if (_formKey.currentState?.validate() ?? false) {
      final provider = context.read<AddressProvider>();
      final newAddress = Address(
        id: widget.existingAddress?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        name: _addressType, // Home/Work selected
        recipientName: _recipientController.text.trim(),
        phone: _phoneController.text.trim(),
        street: _streetController.text.trim(),
        city: _cityController.text.trim(),
        state: _stateController.text.trim(),
        postalCode: _postalController.text.trim(),
        country: _countryController.text.trim(),
        isDefault: _isDefault,
      );

      if (widget.existingAddress == null) {
        provider.addAddress(newAddress);
      } else {
        provider.updateAddress(newAddress);
      }
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existingAddress != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Address' : 'Add Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Address Type Radio (Home/Work)
              Text(
                'Address Type',
                style: context.theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildRadioOption('Home'),
                  const SizedBox(width: 20),
                  _buildRadioOption('Work'),
                ],
              ),
              const SizedBox(height: 16),

              _buildTextField(
                controller: _recipientController,
                label: 'Recipient Name',
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter recipient name' : null,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _phoneController,
                label: 'Phone Number',
                keyboardType: TextInputType.phone,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter phone number' : null,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _streetController,
                label: 'Street Address',
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter street address' : null,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _cityController,
                label: 'City',
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter city' : null,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _stateController,
                label: 'State',
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter state' : null,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _postalController,
                label: 'Zip Code',
                keyboardType: TextInputType.number,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter zip code' : null,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _countryController,
                label: 'Country',
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter country' : null,
              ),
              const SizedBox(height: 12),

              CheckboxListTile(
                value: _isDefault,
                activeColor: Colours.primary,
                title: const Text('Set as default address'),
                onChanged: (val) {
                  setState(() {
                    _isDefault = val ?? false;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveAddress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colours.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isEdit ? 'Update Address' : 'Save Address',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colours.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: context.color.surfaceContainer,
      ),
    );
  }

  Widget _buildRadioOption(String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: _addressType,
          activeColor: Colours.primary,
          onChanged: (val) {
            setState(() {
              _addressType = val!;
            });
          },
        ),
        Text(value),
      ],
    );
  }
}
