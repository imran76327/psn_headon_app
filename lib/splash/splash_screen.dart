import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../entry/entry_point.dart';
import '../home/home_page.dart';
import '../widgets/home.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final image = AssetImage('assets/images/logo.png');
//     image.resolve(ImageConfiguration()).addListener(
//           ImageStreamListener((ImageInfo image, bool synchronousCall) {
//             print('Image loaded successfully');
//           }, onError: (error, stackTrace) {
//             print('Error loading image: $error');
//           }),
//         );
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is AuthError) {
//           print(125252);
//           if (state.errorLoading && !state.message.contains("User not found")) {
//             print(state.message);
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(
//                   state.message.replaceAll("Exception: ", ""),
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//             );
//           }
//           print(1245);
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => LoginPage()),
//           );

//           // Navigator.pushReplacementNamed(context, LoginPage.routeName);
//         }
//         if (state is AuthSuccess) {
//           print("Auth Success");
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Center(
//                   child: Text(
//                 "LOGIN SUCCESS!!!",
//                 style:
//                     TextStyle(color: Theme.of(context).colorScheme.onPrimary),
//               )),
//             ),
//           );
//           Future.delayed(Duration(milliseconds: 500), () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const EntryScreen(
//                   body: HomePage(),
//                 ),
//               ),
//             );
//           });
//         }
//       },
//       child:
//           //
//           Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 height: 100,
//                 width: 100,
//                 decoration: BoxDecoration(
//                   // color: Colors.red, // Temporary color to check layout issues
//                   shape: BoxShape.circle,
//                   image: DecorationImage(
//                     image: image,
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20), // Added spacing
//               Text("PSN",
//                   style: TextStyle(
//                       fontSize: 30,
//                       color: Theme.of(context).colorScheme.onPrimary)),
//             ],
//           ),
//         ),
//       ),
//       //
//     );
//   }
// }
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const image = AssetImage('assets/images/logo.png');
    image.resolve(const ImageConfiguration()).addListener(
          ImageStreamListener((ImageInfo image, bool synchronousCall) {
            print('Image loaded successfully');
          }, onError: (error, stackTrace) {
            print('Error loading image: $error');
          }),
        );

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          Future.delayed(Duration.zero, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          });
        }

        if (state is AuthSuccess) {
          Future.delayed(const Duration(milliseconds: 500), () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "LOGIN SUCCESS!!!",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const EntryScreen(
                  body: HomePage(),
                ),
              ),
            );
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => EntryScreen(
            //       body: RosterPage(),
            //     ),
            //   ),
            // );
          });
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // image: DecorationImage(
                  //   image: image,
                  //   fit: BoxFit.fill,
                  // ),
                ),
              ),
              const SizedBox(height: 20), // Added spacing
              Text(
                "PSN-headon",
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              // Fallback text while waiting for state
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
