
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';



class BackgroundMoving extends StatelessWidget {
  const BackgroundMoving({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Replacing the top background image with WavyBackground
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: WavyBackground(),
        ),

        // Light-1 effect
        Positioned(
          left: 30,
          width: 80,
          height: 150,
          child: FadeInUp(
            duration: const Duration(seconds: 1),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/light1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        // Light-2 effect
        Positioned(
          left: 140,
          width: 80,
          height: 120,
          child: FadeInUp(
            duration: const Duration(milliseconds: 1200),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/light2.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        // Clock effect with reduced size
        Positioned(
          right: 40,
          top: 40,
          width: 50, // Reduced width
          height: 50, // Reduced height to make it smaller and circular
          child: FadeInUp(
            duration: const Duration(milliseconds: 1300),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle, // Makes the image circular
                image: DecorationImage(
                  image: AssetImage('assets/images/clock.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        // 180-degree rotated WavyBackground at the bottom
        Positioned(
          bottom: 0, // Ensures it's at the very bottom
          left: 0,
          right: 0,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationZ(3.14159), // Rotate the WavyBackground 180 degrees
            child: const WavyBackground1(), // Replacing the previous background with WavyBackground
          ),
        ),
      ],
    );
  }
}




class WavyBackground extends StatelessWidget {
  const WavyBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: 210, // Adjust the height of the wavy background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 122, 0, 0), // Start color (bright red at the top)
              Color.fromARGB(255, 124, 6, 6), // End color (darker red at the bottom)
            ],
            begin: Alignment.topCenter, // Gradient starts from the top-center
            end: Alignment.bottomCenter, // Gradient ends at the bottom-center
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start at the top-left corner
    path.lineTo(0, size.height * 0.7); // Starting high at 70% height
    
    // First wave: curve down and then back up
    path.quadraticBezierTo(
      size.width * 0.25, // Control point (x-axis at 25% width)
      size.height * 0.85, // Control point (y-axis high, but not too low)
      size.width * 0.5,  // End point (x-axis at 50% width)
      size.height * 0.6, // End point (y-axis low, but not too deep)
    );

    // Second wave: curve up and then down
    path.quadraticBezierTo(
      size.width * 0.75, // Control point (x-axis at 75% width)
      size.height * 0.4, // Control point (y-axis high again, but not too high)
      size.width,        // End point (x-axis at 100% width)
      size.height * 0.7, // End point (y-axis back to 70%)
    );

    // Finish the path by connecting to the top-right corner
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // No need to reclip
  }
}

class WavyBackground1 extends StatelessWidget {
  const WavyBackground1({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper(),
      child: Container(
        height: 250, // Adjust the height of the wavy background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 122, 0, 0), // Start color (bright red at the top)
              Color.fromARGB(255, 124, 6, 6), // End color (darker red at the bottom)
            ],
            begin: Alignment.topCenter, // Gradient starts from the top-center
            end: Alignment.bottomCenter, // Gradient ends at the bottom-center
          ),
        ),
      ),
    );
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start at the top-left corner
    path.lineTo(0, size.height * 0.7); // Starting high at 70% height
    
    // First wave: curve down and then back up
    path.quadraticBezierTo(
      size.width * 0.25, // Control point (x-axis at 25% width)
      size.height * 0.85, // Control point (y-axis high, but not too low)
      size.width * 0.5,  // End point (x-axis at 50% width)
      size.height * 0.6, // End point (y-axis low, but not too deep)
    );

    // Second wave: curve up and then down
    path.quadraticBezierTo(
      size.width * 0.75, // Control point (x-axis at 75% width)
      size.height * 0.4, // Control point (y-axis high again, but not too high)
      size.width,        // End point (x-axis at 100% width)
      size.height * 0.7, // End point (y-axis back to 70%)
    );

    // Finish the path by connecting to the top-right corner
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // No need to reclip
  }
}




// import 'package:flutter/material.dart';

// class BackgroundMoving extends StatefulWidget {
//   const BackgroundMoving({super.key});

//   @override
//   _BackgroundMovingState createState() => _BackgroundMovingState();
// }

// class _BackgroundMovingState extends State<BackgroundMoving>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 5),
//       vsync: this,
//     )..repeat(reverse: true);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         return Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               stops: [
//                 0.0,
//                 _controller.value * 0.5,
//                 0.7,
//                 1.0,
//               ],
//               colors: const [
//                 Color.fromARGB(255, 88, 3, 3), // Deep red
//                 Color.fromARGB(255, 136, 2, 2), // Firebrick red
//                 Color(0xFFDC143C), // Crimson
//                 Color(0xFFFF6347), // Tomato red
//               ],
//             ),
//           ),
//           child: Stack(
//             children: [
//               Floating decorative elements
//               Positioned(
//                 top: 100,
//                 left: 50,
//                 child: Container(
//                   width: 100,
//                   height: 100,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white.withOpacity(0.1),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 150,
//                 right: 50,
//                 child: Container(
//                   width: 120,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white.withOpacity(0.1),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 250,
//                 right: 100,
//                 child: Container(
//                   width: 80,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white.withOpacity(0.07),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
