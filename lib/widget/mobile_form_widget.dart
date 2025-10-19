import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netspend/bloc/auth_bloc.dart';
import 'package:netspend/bloc/auth_event.dart';
import 'package:netspend/bloc/auth_state.dart';
import 'package:netspend/database.dart';
import 'package:netspend/widget/name_textfield.dart';
import 'package:netspend/widget/password_textfield.dart';
import 'package:netspend/widget/username_textfield.dart';
import 'package:netspend/widget/validator.dart';

class MobileFormWidget extends StatefulWidget {
  const MobileFormWidget({super.key});

  @override
  State<MobileFormWidget> createState() => _MobileFormWidgetState();
}

class _MobileFormWidgetState extends State<MobileFormWidget> {
  final userNameControllerKey = GlobalKey<UserNameTextFieldState>();
  final passwordControllerKey = GlobalKey<PasswordTextfieldState>();
  final nameControllerKey = GlobalKey<NameTextFormWidgetState>();
  final GlobalKey<FormState> formKey = GlobalKey();
  final String welcome = "welcome back";
  final String access = "Authenticating";
  final String accCreated = "Account created for";

  bool isSignedIn = true;

  Future<void> _handleLogin() async {
    if (formKey.currentState!.validate()) {
      StatementValidator.authValidateMessage(context, "Authenticating");

      final username =
          userNameControllerKey.currentState?.userNameController.text.trim() ??
              '';
      final password =
          passwordControllerKey.currentState?.passwordController.text.trim() ??
              '';
      final name =
          nameControllerKey.currentState?.nameController.text.trim() ?? '';

      await Database().getInfo(username, password);

      if (mounted) {
        if (isSignedIn) {
          context
              .read<AuthBloc>()
              .add(LoginRequested(email: username, password: password));
        } else {
          context.read<AuthBloc>().add(
              SignUpRequested(name: name, email: username, password: password));
        }
      }
    }
  }

  Future<void> _swap() async {
    setState(() {
      isSignedIn = !isSignedIn;
      formKey.currentState?.reset();
    });
  }

  bool isChecked = false;
  @override
  dispose() {
    userNameControllerKey.currentState?.userNameController.dispose();
    passwordControllerKey.currentState?.passwordController.dispose();
    nameControllerKey.currentState?.nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          final snackBar = SnackBar(
            content: Text(state.error),
            duration: const Duration(seconds: 3),
            backgroundColor: CupertinoColors.systemRed,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is Authenticated) {
          StatementValidator.showLoggedInnStatement(context, welcome);
        } else if (state is SignUpSuccess) {
          StatementValidator.showSignUpMessage(
              context, '$accCreated ${state.name}');
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  !isSignedIn ? "Join Now" : 'Account Login',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: CupertinoColors.systemRed,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (!isSignedIn) ...[
                const NameTextFormWidget(),
                const SizedBox(height: 20),
              ],
              const UserNameTextField(),
              const SizedBox(),
              const PasswordTextfield(),
              const SizedBox(height: 10),
              !isSignedIn
                  ? SizedBox()
                  : Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? checked) {
                            setState(() {
                              isChecked = checked ?? false;
                            });
                          },
                        ),
                        Text(
                          'Remember username',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
              const SizedBox(height: 25),
              //if state is loading show circular progress indicator else show button
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50, // Fixed height
                      child: state is AuthLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                              ),
                              onPressed: _handleLogin,
                              child: Text(
                                !isSignedIn ? 'Sign Up' : "Sign In",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Forgot your username or password?",
                style: TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.black,
                ),
              ),
              const SizedBox(height: 30),
              Flexible(
                child: Container(
                  width: double.infinity,
                  height: 250,
                  color: CupertinoColors.systemGrey6,
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: _swap,
                        child: Text(
                          !isSignedIn
                              ? "Return to sign in page"
                              : "Don't have a card? Sign up now.",
                          style: const TextStyle(
                            fontSize: 16,
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 20,
                              ),
                              child: SizedBox(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        CupertinoColors.systemGrey6,
                                    side: const BorderSide(
                                      color: Color.fromARGB(255, 67, 117, 159),
                                      width: 1,
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'ORDER A NEW CARD',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                      color: Color.fromARGB(255, 67, 117, 159),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Text("Not what you're looking for?"),
                      const SizedBox(height: 15),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: CupertinoColors.activeBlue,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Activate Card",
                style: TextStyle(
                  color: Color.fromARGB(255, 67, 117, 159),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Register for online Access",
                style: TextStyle(
                  color: Color.fromARGB(255, 67, 117, 159),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Reload Your Locations",
                style: TextStyle(
                  color: Color.fromARGB(255, 67, 117, 159),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
