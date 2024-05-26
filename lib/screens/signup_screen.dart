import 'package:flutter/material.dart';
import 'package:workoutamw/components/components.dart';
import 'package:workoutamw/screens/home_screen.dart';
import 'package:workoutamw/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workoutamw/constants.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String id = 'signup_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  late String _email;
  late String _password;
  late String _confirmPass;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, HomeScreen.id);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LoadingOverlay(
          isLoading: _saving,
          child: SafeArea(
            child: SingleChildScrollView( // Added SingleChildScrollView
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 125), // Add some space at the top
                    const ScreenTitle(title: 'Sign Up'),
                    const SizedBox(height: 20), // Add space between the title and text fields
                    CustomTextField(
                      textField: TextField(
                        onChanged: (value) {
                          _email = value;
                        },
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        decoration: kTextInputDecoration.copyWith(
                          hintText: 'Email',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Reduce space between text fields
                    CustomTextField(
                      textField: TextField(
                        obscureText: true,
                        onChanged: (value) {
                          _password = value;
                        },
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        decoration: kTextInputDecoration.copyWith(
                          hintText: 'Password',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Reduce space between text fields
                    CustomTextField(
                      textField: TextField(
                        obscureText: true,
                        onChanged: (value) {
                          _confirmPass = value;
                        },
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        decoration: kTextInputDecoration.copyWith(
                          hintText: 'Confirm Password',
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Password must be at least 6 characters long.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20), // Add some space before the button
                    CustomBottomScreen(
                      textButton: 'Sign Up',
                      heroTag: 'signup_btn',
                      question: 'Have an account?',
                      buttonPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();

                        if (_email.isEmpty || _password.isEmpty || _confirmPass.isEmpty) {
                          showAlert(
                            context: context,
                            title: 'MISSING INFORMATION',
                            desc: 'Please fill in all fields',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ).show();
                          return;
                        }

                        setState(() {
                          _saving = true;
                        });

                        if (_confirmPass == _password) {
                          try {
                            await _auth.createUserWithEmailAndPassword(
                              email: _email,
                              password: _password,
                            );

                            if (mounted) {
                              signUpAlert(
                                // ignore: use_build_context_synchronously
                                context: context,
                                title: 'GOOD JOB',
                                desc: 'Go login now',
                                btnText: 'Login Now',
                                onPressed: () {
                                  setState(() {
                                    _saving = false;
                                    Navigator.popAndPushNamed(
                                      context,
                                      SignUpScreen.id,
                                    );
                                  });
                                  if (mounted) {
                                    Navigator.pushNamed(
                                      context,
                                      LoginScreen.id,
                                    );
                                  }
                                },
                              ).show();
                            }
                          } catch (e) {
                            setState(() {
                              _saving = false;
                            });

                            String errorMessage = 'An error occurred';
                            if (e is FirebaseAuthException) {
                              switch (e.code) {
                                case 'email-already-in-use':
                                  errorMessage = 'This email is already in use.';
                                  break;
                                case 'invalid-email':
                                  errorMessage = 'The email address is not valid.';
                                  break;
                                case 'operation-not-allowed':
                                  errorMessage = 'Operation not allowed. Please contact support.';
                                  break;
                                case 'weak-password':
                                  errorMessage = 'The password is too weak.';
                                  break;
                                default:
                                  errorMessage = 'An undefined error occurred.';
                              }
                            }

                            if (mounted) {
                              signUpAlert(
                                // ignore: use_build_context_synchronously
                                context: context,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                title: 'ERROR',
                                desc: errorMessage,
                                btnText: 'Try Again',
                              ).show();
                            }
                          }
                        } else {
                          setState(() {
                            _saving = false;
                          });
                          if (mounted) {
                            showAlert(
                              context: context,
                              title: 'WRONG PASSWORD',
                              desc: 'Make sure that you write the same password twice',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ).show();
                          }
                        }
                      },
                      questionPressed: () async {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
