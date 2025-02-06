import 'dart:ui';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../bloc/auth/auth_bloc.dart';
import '../entry/entry_point.dart';
import '../home/home_page.dart';
import '../services/dialog_service.dart';
import '../utils/background_moving.dart';
import '../utils/neumorphicButton.dart';
import '../utils/theme/theme_notifier.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = '/login';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPhoneFieldVisible = true;
  final phoneTextEditingController = TextEditingController();
  // final passwordTextEditingController = TextEditingController();
  final otpController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isSignUpEnabled = false;
  final bool _rememberMe = true;
  bool _obsecurePass = true;

  void _signIn() async {
    if (_formkey.currentState!.validate()) {
      final String phone = phoneTextEditingController.text.trim();
      // final String password = passwordTextEditingController.text.trim();

      final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String? token = await firebaseMessaging.getToken();
      context
          .read<AuthBloc>()
          .add(AuthLogin(phone, "password@123", _rememberMe, token));
      // context.read<AuthBloc>().add(RegisterDeviceToken());

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Center(child: Text("LOGIN SUCCESS!!!")),
      //   ),
      // );
      // Future.delayed(Duration(milliseconds: 500), () {
      //   Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => const EntryScreen(body: HomePage())));
      // });
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final size = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          DialogService.showErrorDialog(
            context,
            title: "Error while signing in",
            message: state.message,
          );
          return;
        }
        if (state is AuthSuccess) {
          // state.user.navigateToDashboard(context);
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => const HomePage()));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                  child: Text(
                "LOGIN SUCCESS!!!",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              )),
            ),
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const EntryScreen(
                  body: HomePage(),
                ),
              ),
            );
          });
        }
        if (state is AuthLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          );
        }
        if (state is OtpVerifiedState) {
          if (state.isVerified) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Center(
                child: Text(
                  'OTP Verified! You can now sign up.',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
              )),
            );
            setState(() {
              isPhoneFieldVisible = true;
              isSignUpEnabled = true;
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Center(
                child: Text(
                  'Incorrect OTP, please try again.',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
              )),
            );
          }
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          bool isSigningIn = state is AuthLoading;
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: SafeArea(
              child: Stack(
                children: [
                  const BackgroundMoving(),
                  SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: size.height * 0.9, // Adjust the height as needed
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
                                    const SizedBox(height: 40), // Existing space
                                    // Add more space before the "Headon" text
                                    const SizedBox(height: 40), // Adjust this value as needed
                                    // App Name and Login Hading
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      // "Headon" Centered and Underlined
                                    Center(
                                      child: Text(
                                        "PSN-Headon",
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).brightness == Brightness.light
                                              ? Colors.black // Black in light mode
                                              : Colors.white, // White in dark mode
                                          shadows: [
                                            Shadow(
                                              blurRadius: 15.0, // Adjust the blur radius to make the glow more subtle or stronger
                                              color: Colors.red.shade900, // Red glow color
                                              offset: const Offset(0, 0), // No offset to keep the glow centered around the text
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),


                                      const SizedBox(height: 20), // Space between texts
                                      
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontFamily: 'Poppins', // Apply Poppins font family to the entire text
                                        color: Theme.of(context).colorScheme.onSecondary, // Default color for "Welcome, Login"
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      text: "Welcome, Login ", // "Welcome, Login" part
                                      children: [
                                        TextSpan(
                                          style: TextStyle(
                                            fontFamily: 'Poppins', // Apply Poppins font family to "Now" part
                                            color: Colors.red.shade900, // Color for "Now"
                                          ),
                                          text: "Now", // "Now" part with red color
                                        ),
                                      ],
                                    ),
                                  ),


                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // "If you are new" with GestureDetector
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const SignUpPage(),
                                        ),
                                      );
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        text: "If you are new",
                                        children: [
                                          TextSpan(
                                            style: TextStyle(
                                              color: Colors.red.shade900,
                                            ),
                                            text: " / Create New,",
                                          ),
                                        ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    if (isPhoneFieldVisible)
                                    ClipRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                      child: TextFormField(
                                        obscureText: false,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                        ),
                                        focusNode: FocusNode(),
                                        autofocus: false,
                                        onChanged: (value) {
                                          setState(() {
                                            isSignUpEnabled = false;
                                          });
                                          context.read<AuthBloc>().add(const AuthIni());
                                        },
                                        controller: phoneTextEditingController,
                                        cursorColor: Theme.of(context).colorScheme.primary,
                                        cursorWidth: 5,
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(10), // Limits input to 10 characters
                                          FilteringTextInputFormatter.digitsOnly, // Allows only numeric input
                                        ],
                                        
                                        validator: (phone) {
                                          if (phone == null || phone.isEmpty) {
                                            return "Please enter phone number";
                                          } else if (phone.length != 10) {
                                            return "Please enter a valid phone number";
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                          hintText: "Phone Number",
                                          hintStyle: TextStyle(
                                            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                                          ),
                                          fillColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.08),
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
                                              width: 0.5,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                                              width: 0.5,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                              color: Theme.of(context).colorScheme.error,
                                              width: 0.5,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
                                              width: 0.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                    const SizedBox(
                                      height: 20,
                                    ),
                                    BlocBuilder<AuthBloc, AuthState>(
                                      builder: (context, state) {
                                        if (state is AuthInitial) {
                                          return Center(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      isPhoneFieldVisible = false; // Hide phone number field
                                                    });
                                                    BlocProvider.of<AuthBloc>(context).add(
                                                      SendOtpEvent(phoneNumber: phoneTextEditingController.text),
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
                                                                    AuthBloc>(
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
                                                                    AuthBloc>(
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
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onSecondary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          text: "Forgot Password ? ",
                                          children: [
                                            TextSpan(
                                              style: TextStyle(
                                                  color: Colors.red.shade900),
                                              text: " Reset",
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (isSignUpEnabled) {
                                          if (_formkey.currentState!
                                              .validate()) {
                                            _signIn();
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Center(
                                                  child: Text(
                                                "Please Verify Your Number First !!!!",
                                                style: TextStyle(
                                                    color: Colors.red.shade900),
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
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(0.2),
                                                  ],
                                                ),
                                                border: Border.all(
                                                  width: 0.5,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary
                                                      .withOpacity(0.1),
                                                ),
                                              )
                                            : BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.grey,
                                                border: Border.all(
                                                  width: 0.5,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary
                                                      .withOpacity(0.1),
                                                ),
                                              ),
                                        child: isSigningIn
                                            ? CircularProgressIndicator(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              )
                                            : const Center(
                                                child: Text(
                                                'Sign In',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                      ),
                                    ),
                                      const SizedBox(
                                      height: 60,
                                    ),
                                    const Spacer(),
                                    SwitchListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      title: const Text(
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
                                                .onPrimary),
                                      ),
                                    ),
                                  ],
                                )),
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
