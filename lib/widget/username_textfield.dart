import 'package:flutter/material.dart';
import 'package:netspend/widget/validator.dart';

class UserNameTextField extends StatefulWidget {
  const UserNameTextField({super.key});

  @override
  State<UserNameTextField> createState() => UserNameTextFieldState();
}

class UserNameTextFieldState extends State<UserNameTextField> {
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            validator: (username) {
              return StatementValidator.validateUsername(username: username);
            },
            textAlign: TextAlign.start,
            controller: userNameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide()),
                labelText: 'Username',
                labelStyle: const TextStyle(
                  fontSize: 16,
                )),
            keyboardType: TextInputType.name,
            autofillHints: const [AutofillHints.name],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
