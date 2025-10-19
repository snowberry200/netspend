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
import 'package:url_launcher/link.dart';

class ExpandedWidget extends StatefulWidget {
  const ExpandedWidget({
    super.key,
    required this.width,
  });

  final double width;

  @override
  State<ExpandedWidget> createState() => _ExpandedWidgetState();
}

class _ExpandedWidgetState extends State<ExpandedWidget> {
  final userNameControllerKey = GlobalKey<UserNameTextFieldState>();
  final passwordControllerKey = GlobalKey<PasswordTextfieldState>();
  final nameControllerKey = GlobalKey<NameTextFormWidgetState>();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isSignedIn = true;

  Future<void> _handleLogin() async {
    if (formKey.currentState!.validate()) {
      debugPrint(
          'name: ${nameControllerKey.currentState?.nameController.text} , password: ${passwordControllerKey.currentState?.passwordController.text}, username: ${userNameControllerKey.currentState?.userNameController.text}');
      // FutureBuilder(
      //     future: authClient.signIn(
      //         email: nameController.text.trim(),
      //         password: passwordController.text.trim()),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState ==
      //           ConnectionState.done) {
      //         return const TextfieldContainer();
      //       } else {
      //         return const CircularProgressIndicator(
      //             color: Colors.blue);
      //       }
      //     });
      const info = 'Authenticating';
      const snackBar = SnackBar(
        content: Text(info),
        duration: Duration(seconds: 5),
        backgroundColor: CupertinoColors.activeBlue,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      final username =
          userNameControllerKey.currentState?.userNameController.text.trim() ??
              '';
      final password =
          passwordControllerKey.currentState?.passwordController.text.trim() ??
              '';
      final name =
          nameControllerKey.currentState?.nameController.text.trim() ?? '';

      await Database().getInfo(username, password);

      if (isSignedIn) {
        if (mounted) {
          context
              .read<AuthBloc>()
              .add(LoginRequested(email: username, password: password));
        }
      } else {
        if (mounted) {
          context.read<AuthBloc>().add(
              SignUpRequested(name: name, email: username, password: password));
        }
      }
    }
  }

  void _swap() {
    setState(() {
      isSignedIn = !isSignedIn;
      formKey.currentState?.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          !isSignedIn ? state is SignUpSuccess : state is Authenticated;
          if (state is AuthError) {
            final snackBar = SnackBar(
              content: Text(state.error),
              duration: const Duration(seconds: 3),
              backgroundColor: CupertinoColors.systemRed,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is Authenticated) {
            final snackBar = SnackBar(
              content: Text('Welcome back, ${state.email}'),
              duration: const Duration(seconds: 3),
              backgroundColor: CupertinoColors.activeGreen,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is SignUpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Account created for ${state.name}'),
                duration: const Duration(seconds: 3),
                backgroundColor: CupertinoColors.activeGreen,
              ),
            );
          }
        },
        builder: (context, state) {
          return Container(
              padding: const EdgeInsets.only(top: 60, bottom: 0),
              decoration: const BoxDecoration(color: Color(0XFFEEEEEE)),
              child: Center(
                  child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView(
                  children: [
                    Center(
                      child: Container(
                          height: 500,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          decoration: const BoxDecoration(
                            color: CupertinoColors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                          width: widget.width / 2.5,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(!isSignedIn ? "Join Now" : 'Account Login',
                                    style: const TextStyle(
                                        letterSpacing: 1.5,
                                        fontSize: 27,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 20),
                                Form(
                                  key: formKey,
                                  child: Column(children: [
                                    if (!isSignedIn) ...[
                                      NameTextFormWidget(
                                          key: nameControllerKey),
                                    ],
                                    const SizedBox(height: 20),
                                    UserNameTextField(
                                        key: userNameControllerKey),
                                    PasswordTextfield(
                                        key: passwordControllerKey),

                                    const SizedBox(
                                      height: 30,
                                    ),

                                    //if state is loading show circular progress indicator else show button
                                    state is AuthLoading
                                        ? const CircularProgressIndicator()
                                        : SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 40,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 50, right: 50),
                                              child: Link(
                                                target: LinkTarget.self,
                                                uri: Uri.parse(
                                                    'https://www.netspend.com/account/login'),
                                                builder:
                                                    (context, followLink) =>
                                                        ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              const Color(
                                                                  0XFFEEEEEE)),
                                                  onPressed: _handleLogin,
                                                  child: Text(
                                                      !isSignedIn
                                                          ? 'Sign Up'
                                                          : 'LOG IN',
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Color.fromARGB(
                                                              255,
                                                              35,
                                                              35,
                                                              38))),
                                                ),
                                              ),
                                            ),
                                          ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 60, top: 30, right: 60),
                                      child: Center(
                                        child: Text(
                                          'Forgot your user name and password?',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    )
                                  ]),
                                )
                              ],
                            ),
                          )),
                    ),
                    const SizedBox(height: 30),
                    Center(
                        child: TextButton(
                            onPressed: _swap,
                            child: Text(
                              !isSignedIn
                                  ? "Return to sign in page"
                                  : "Don't have a Card? Sign Up Today",
                              style: const TextStyle(fontSize: 15),
                            ))),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: const Color(0XFFEEEEEE),
                              side: const BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 68, 171, 183)),
                              fixedSize: const Size(350, 40)),
                          onPressed: () async {
                            // }
                          },
                          child: const Center(
                            child: Text(' Order A New Card',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 68, 171, 183),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )));
        },
      ),
    );
  }
}
