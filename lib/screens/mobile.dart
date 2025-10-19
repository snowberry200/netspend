import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as Colors;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netspend/bloc/auth_bloc.dart';
import 'package:netspend/bloc/auth_event.dart';
import 'package:netspend/bloc/auth_state.dart';
import 'package:netspend/database.dart';
import 'package:netspend/widget/password_textfield.dart';
import 'package:netspend/widget/username_textfield.dart';
import 'package:netspend/widget/name_textfield.dart';
import 'package:netspend/widget/validator.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
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
        return Container(
          color: CupertinoColors.tertiarySystemFill,
          child: Column(
            children: [
              Container(
                color: CupertinoColors.white,
                width: double.infinity,
                height: 100,
                child: const Image(
                  image: NetworkImage(
                    'data:image/png;base64,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',
                    scale: 0.5,
                  ),
                ),
              ),
              const SafeArea(child: SizedBox(height: 30)),
              Expanded(
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 25,
                    ),
                    child: Form(
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
                                color: Colors.CupertinoColors.systemRed,
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
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                onChanged: (bool? checked) {
                                  setState(() {
                                    isChecked = checked ?? false;
                                  });
                                },
                              ),
                              const Text(
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
                                            minimumSize:
                                                const Size.fromHeight(50),
                                          ),
                                          onPressed: _handleLogin,
                                          child: Text(
                                            !isSignedIn ? 'Sign Up' : "Sign In",
                                            style:
                                                const TextStyle(fontSize: 20),
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
                              color: Colors.CupertinoColors.black,
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
                                        color:
                                            Colors.CupertinoColors.activeBlue,
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
                                                  color: Color.fromARGB(
                                                      255, 67, 117, 159),
                                                  width: 1,
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: const Text(
                                                'ORDER A NEW CARD',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w200,
                                                  color: Color.fromARGB(
                                                      255, 67, 117, 159),
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
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
