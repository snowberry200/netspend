import 'package:flutter/material.dart';

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
              if (username!.isNotEmpty && username.length < 4) {
                return 'Please enter a correct username';
              } else if (username.isEmpty) {
                return 'username field can not be empty';
              } else {
                return null;
              }
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
