import 'package:flutter/material.dart';
import 'package:netspend/widget/validator.dart';

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
        return StatementValidator.validatePassword(
          password: passwordController.text,
        );
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
