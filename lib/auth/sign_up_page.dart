// ignore_for_file: use_build_context_synchronously

import 'dart:ui';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/sign_up/sign_up_bloc.dart';
import '../entry/entry_point.dart';
import '../model/user/user.dart';
import '../services/dialog_service.dart';
import '../utils/background_moving.dart';
import '../utils/neumorphicButton.dart';
import '../utils/theme/theme_notifier.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const String routeName = '/sign-up';
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

void _showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    },
  );
}

void _hideLoadingDialog(BuildContext context) {
  Navigator.of(context).pop(); // Close the dialog
}

void _showDialog(BuildContext context, String title, String message, Color color, IconData icon) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon, color: Colors.white, size: 50),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: color),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

class _SignUpPageState extends State<SignUpPage> {
  bool isPhoneFieldVisible = true;
  final emailTextEditingController = TextEditingController();
  // final passwordTextEditingController = TextEditingController();
  final nameTextEditingController = TextEditingController();
  final phoneTextEditingController = TextEditingController();
  final otpController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isSignUpEnabled = false;
  bool _obsecurePass = true;
  Future<void> _signUp(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      // Extract values from form fields
      final String name = nameTextEditingController.text.trim();
      final String email = emailTextEditingController.text.trim();
      // final String password = passwordTextEditingController.text.trim();
      final String phone = phoneTextEditingController.text.trim();
      final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String? token = await firebaseMessaging.getToken();
      context
          .read<SignUpBloc>()
          .add(SignUpSubmit(email, "password@123", name, phone, token));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text("SIGN UP SUCCESS!!!")),
        ),
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const EntryScreen(
              body: LoginPage(),
            ),
          ),
        );
      });
    }
  }

  Widget toggleIcon() {
    return IconButton(
      onPressed: () {
        setState(() {
          _obsecurePass = !_obsecurePass;
        });
      },
      icon: _obsecurePass
          ? Icon(
              Icons.visibility,
              color: Theme.of(context).colorScheme.onPrimary,
            )
          : Icon(
              Icons.visibility_off,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpError) {
            DialogService.showErrorDialog(
              context,
              title: "Error signing up",
              message: state.message,
            );
          }
          if (state is SignUpSuccess) {
          final User user = state.user;

          // Show success dialog box
          showDialog(
            context: context,
            barrierDismissible: false, // Prevent closing dialog by tapping outside
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Sign Up Successful'),
                content: const Text('Your account has been created successfully!'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      // Close the dialog
                      Navigator.of(context).pop();

                      // Navigate to the EntryScreen after the dialog is closed
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EntryScreen(
                            body: LoginPage(),
                          ),
                        ),
                      );
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );

          return;
        }

          if (state is OtpVerifiedState) {
            if (state.isVerified) {
              isPhoneFieldVisible = true;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                  'OTP Verified! You can now sign up.',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                )),
              );
              setState(() {
                isSignUpEnabled = true;
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                  'Incorrect OTP, please try again.',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                )),
              );
            }
          }
        },
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            bool isSigningUp = state is SignUpLoading;
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              body: SafeArea(
                child: Stack(
                  children: [
                    const BackgroundMoving(),

                    SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: size.height *
                              0.9, // or any other height constraint you need
                        ),
                        child: IntrinsicHeight(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Form(
                                key: _formkey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.04, // 5% of screen height
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.1, // 20% of screen height
                                        ),
                                     Center(
                                      child:RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'Poppins', // Apply Poppins font family to the entire text
                                          color: Theme.of(context).brightness == Brightness.dark
                                              ? Colors.white // White text for dark theme
                                              : Colors.black, // Black text for light theme
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        text: "Create an Account", // The entire text in one line
                                      ),
                                    ),
                                      ),


                                      const SizedBox(
                                        height: 20,
                                      ),
                                    if (isPhoneFieldVisible)
                                    ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 1, sigmaY: 1),
                                        child: TextFormField(
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary),
                                          focusNode: FocusNode(),
                                          autofocus: false,
                                          controller: nameTextEditingController,
                                          cursorColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          cursorWidth: 5,
                                          // keyboardType: TextInputType.emailAddress,
                                          validator: (name) {
                                            if (name == null || name.isEmpty) {
                                              return "Please enter name";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 20),
                                            hintText: "Name",
                                            hintStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary
                                                    .withOpacity(0.5)),
                                            fillColor: Theme.of(context)
                                                .colorScheme
                                                .onPrimary
                                                .withOpacity(0.08),
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary
                                                      .withOpacity(0.1),
                                                  width: 0.5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary
                                                      .withOpacity(0.5),
                                                  width: 0.5),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error,
                                                  width: 0.5),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary
                                                      .withOpacity(0.1),
                                                  width: 0.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    if (isPhoneFieldVisible)
                                    ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 1, sigmaY: 1),
                                        child: TextFormField(
                                          onChanged: (value) {
                                            setState(() {
                                              isSignUpEnabled = false;
                                            });
                                            context
                                                .read<SignUpBloc>()
                                                .add(const SignUpIni());
                                          },
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                          keyboardType: TextInputType.phone,
                                          focusNode: FocusNode(),
                                          autofocus: false,
                                          controller:
                                              phoneTextEditingController,
                                          cursorColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          cursorWidth: 5,
                                          // keyboardType: TextInputType.emailAddress,
                                          validator: (name) {
                                            if (name == null || name.isEmpty) {
                                              return "Please enter number";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 20),
                                            hintText: "Phone",
                                            hintStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary
                                                    .withOpacity(0.5)),
                                            fillColor: Theme.of(context)
                                                .colorScheme
                                                .onPrimary
                                                .withOpacity(0.08),
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary
                                                      .withOpacity(0.1),
                                                  width: 0.5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary
                                                      .withOpacity(0.5),
                                                  width: 0.5),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error,
                                                  width: 0.5),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary
                                                      .withOpacity(0.1),
                                                  width: 0.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 20,
                                    ),
                                    if (isPhoneFieldVisible)
                                    ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 1, sigmaY: 1),
                                        child: TextFormField(
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary),
                                          focusNode: FocusNode(),
                                          autofocus: false,
                                          controller:
                                              emailTextEditingController,
                                          cursorColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          cursorWidth: 5,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: (email) {
                                            if (email == null ||
                                                email.isEmpty) {
                                              return "Please enter email";
                                            } else if (!RegExp(
                                              r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
                                              caseSensitive: false,
                                            ).hasMatch(email)) {
                                              return "Please enter a valid email";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 20),
                                            hintText: "Email",
                                            hintStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary
                                                    .withOpacity(0.5)),
                                            fillColor: Theme.of(context)
                                                .colorScheme
                                                .onPrimary
                                                .withOpacity(0.08),
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary
                                                      .withOpacity(0.1),
                                                  width: 0.5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary
                                                      .withOpacity(0.5),
                                                  width: 0.5),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error,
                                                  width: 0.5),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary
                                                      .withOpacity(0.1),
                                                  width: 0.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                   
                                    BlocBuilder<SignUpBloc, SignUpState>(
                                      builder: (context, state) {
                                        if (state is SignupInitial) {
                                          return Center(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                isPhoneFieldVisible = false;
                                                BlocProvider.of<SignUpBloc>(
                                                        context)
                                                    .add(
                                                  SendOtpEvent(
                                                      phoneNumber:
                                                          phoneTextEditingController
                                                              .text),
                                                );
                                              },
                                              child: const Text('Send OTP'),
                                            ),
                                          );
                                        } else if (state is OtpSentState) {
                                          return Center(
                                            child: Column(
                                              children: [
                                                TextField(
                                                  controller: otpController,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText:
                                                              'Enter OTP'),
                                                ),
                                                const SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    SignUpBloc>(
                                                                context)
                                                            .add(
                                                          SendOtpEvent(
                                                              phoneNumber:
                                                                  phoneTextEditingController
                                                                      .text),
                                                        );
                                                      },
                                                      child: const Text(
                                                          'Re-Send OTP'),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    SignUpBloc>(
                                                                context)
                                                            .add(
                                                          VerifyOtpEvent(
                                                              enteredOtp:
                                                                  otpController
                                                                      .text),
                                                        );
                                                      },
                                                      child: const Text(
                                                          'Verify OTP'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                        return Container(); // Default case
                                      },
                                    ),

                                    const SizedBox(
                                      height: 20,
                                    ),

                                    Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const LoginPage()));
                                      },
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onPrimary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          text: "If already a member",
                                          children: [
                                            TextSpan(
                                              style: TextStyle(
                                                  color: Theme.of(context).colorScheme.primary),
                                              text: " / Login,",
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  

                                    // BlocBuilder<SignUpBloc, SignUpState>(
                                    //     builder: (context, state) {
                                    // return
                                    GestureDetector(
                                      onTap: () {
                                        if (isSignUpEnabled) {
                                          if (_formkey.currentState!
                                              .validate()) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }

                                          isSignUpEnabled
                                              ? _signUp(context)
                                              : null;
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Center(
                                                  child: Text(
                                                "Please Verify Your Number First !!!!",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary),
                                              )),
                                            ),
                                          );
                                        }
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 40, left: 60, right: 50),
                                        height: 60,
                                        width: double.maxFinite,
                                        decoration: isSignUpEnabled
                                            ? BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.2),
                                                    // Theme.of(context)
                                                    //     .colorScheme
                                                    //     .primary,
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.2),
                                                    // Theme.of(context)
                                                    //     .colorScheme
                                                    //     .primary,
                                                  ],
                                                ),
                                                border: Border.all(
                                                  width: 1,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary
                                                      .withOpacity(1),
                                                ),
                                              )
                                            : BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.grey,
                                                border: Border.all(
                                                  width: 1,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary
                                                      .withOpacity(1),
                                                ),
                                              ),

                                        child: isSigningUp
                                            ? CircularProgressIndicator(
                                                color: Theme.of(context).brightness == Brightness.light
                                              ? Colors.black // Black in light mode
                                              : Colors.white,
                                              )
                                            : const Center(
                                                child: Text(
                                                  'Create Account',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),

                                    // ;
                                    // }),
                                     const SizedBox(
                                      height: 30,
                                    ),
                                    SwitchListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      title:  const Text(
                                        'Dark Mode',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      value: themeNotifier.isDarkMode,
                                      onChanged: (value) {
                                        themeNotifier.toggleTheme();
                                      },
                                      secondary: NeumorphicButton(
                                        size: 60,
                                        distance: 2,
                                        blur: 20,
                                        padding: 8,
                                        paddingColor: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        child: Icon(
                                          themeNotifier.isDarkMode
                                              ? Icons.dark_mode
                                              : Icons.light_mode,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width * 0.5;
    double h = size.height * 0.5;
    final path = Path();
    path.lineTo(0, h);
    path.lineTo(w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = const Color.fromARGB(255, 151, 19, 239)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.2566667, size.height * 0.0260000);
    path_0.lineTo(size.width * 0.2550000, size.height * 0.0220000);
    path_0.lineTo(size.width * 0.2566667, size.height * 0.0240000);
    path_0.close();
    path_0.lineTo(size.width * 0.2566667, size.height * 0.0260000);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = const Color.fromARGB(255, 151, 19, 239)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);

    // Layer 1

    Paint paintFill1 = Paint()
      ..color = const Color.fromARGB(255, 151, 19, 239)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_1 = Path();
    path_1.moveTo(size.width * -0.0033333, size.height * 0.2340000);
    path_1.quadraticBezierTo(size.width * 0.3369000, size.height * 0.2113400,
        size.width * 0.3350000, size.height * -0.0020000);
    path_1.quadraticBezierTo(size.width * 0.2508333, size.height * -0.0020000,
        size.width * -0.0016667, size.height * -0.0020000);

    canvas.drawPath(path_1, paintFill1);

    // Layer 1

    Paint paintStroke1 = Paint()
      ..color = const Color.fromARGB(255, 151, 19, 239)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_1, paintStroke1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
