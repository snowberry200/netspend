import 'package:flutter/material.dart';

class PasswordTextfield extends StatefulWidget {
  const PasswordTextfield({super.key});

  @override
  State<PasswordTextfield> createState() => PasswordTextfieldState();
}

class PasswordTextfieldState extends State<PasswordTextfield> {
  late TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      //obscuringCharacter: '*#',
      validator: (password) {
        if (password!.isNotEmpty && password.length < 5) {
          return 'Password cant be less than 5 characters';
        } else if (password.isEmpty) {
          return 'Password field can not be empty';
        } else {
          return null;
        }
      },
      textAlign: TextAlign.start,
      controller: passwordController = TextEditingController(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
              strokeAlign: BouncingScrollSimulation.maxSpringTransferVelocity),
        ),
        labelText: 'Password',
      ),
    );
  }
}
