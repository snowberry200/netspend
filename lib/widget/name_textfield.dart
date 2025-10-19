import 'package:flutter/material.dart';

class NameTextFormWidget extends StatefulWidget {
  const NameTextFormWidget({super.key});

  @override
  State<NameTextFormWidget> createState() => NameTextFormWidgetState();
}

class NameTextFormWidgetState extends State<NameTextFormWidget> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (name) {
        if (name!.isNotEmpty && name.length < 4) {
          return 'Please enter a correct name';
        } else if (name.isEmpty) {
          return 'name field can not be empty';
        } else {
          return null;
        }
      },
      textAlign: TextAlign.start,
      controller: nameController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide()),
          labelText: 'name',
          labelStyle: const TextStyle(
            fontSize: 16,
          )),
      keyboardType: TextInputType.name,
      autofillHints: const [AutofillHints.name],
    );
  }
}
