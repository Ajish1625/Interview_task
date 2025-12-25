import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/address_model.dart';
import '../models/company_model.dart';
import '../models/geo_model.dart';
import '../models/user_models.dart';
import '../providers/user_provider.dart';


class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final companyCtrl = TextEditingController();




  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    cityCtrl.dispose();
    companyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Add User'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _wrapField(nameCtrl, 'Name',
                        validator: nameValidator, isMobile: isMobile),

                    _wrapField(emailCtrl, 'Email',
                        validator: emailValidator,
                        keyboardType: TextInputType.emailAddress,
                        isMobile: isMobile),

                    _wrapField(phoneCtrl, 'Phone',
                        validator: phoneValidator,
                        keyboardType: TextInputType.phone,
                        isMobile: isMobile),

                    _wrapField(cityCtrl, 'City',
                        validator: (v) => requiredValidator(v, 'City'),
                        isMobile: isMobile),

                    _wrapField(companyCtrl, 'Company',
                        validator: (v) => requiredValidator(v, 'Company'),
                        isMobile: isMobile),
                  ],
                ),
              );
            },
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: _saveUser,
      ),
    );
  }

  void _saveUser() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields in the form'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final provider = context.read<UsersProvider>();

    provider.addUser(
      UserModel(
        id: DateTime.now().millisecondsSinceEpoch,
        name: nameCtrl.text.trim(),
        username: nameCtrl.text.trim().toLowerCase(),
        email: emailCtrl.text.trim(),
        phone: phoneCtrl.text.trim(),
        website: '',
        address: Address(
          street: '',
          suite: '',
          city: cityCtrl.text.trim(),
          zipcode: '',
          geo: Geo(lat: '0', lng: '0'),
        ),
        company: Company(
          name: companyCtrl.text.trim(),
          catchPhrase: '',
          bs: '',
        ),
      ),
    );


    Navigator.pop(context, true);
  }




  String? requiredValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length < 10) {
      return 'Phone must be at least 10 digits';
    }
    return null;
  }

  Widget _wrapField(
      TextEditingController controller,
      String label, {
        String? Function(String?)? validator,
        TextInputType keyboardType = TextInputType.text,
        required bool isMobile,
      }) {
    return SizedBox(
      width: isMobile
          ? double.infinity
          : (MediaQuery.of(context).size.width / 2) - 32,
      child: _field(
        controller,
        label,
        validator: validator,
        keyboardType: keyboardType,
      ),
    );
  }



  Widget _field(
      TextEditingController controller,
      String label, {
        String? Function(String?)? validator,
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            errorStyle: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

}
