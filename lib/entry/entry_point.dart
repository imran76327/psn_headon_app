
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_localization/flutter_localization.dart';
import 'package:rive/rive.dart' hide Image;

import '../auth/login_page.dart';
import '../bloc/auth/auth_bloc.dart';
import '../home/home_page.dart';
import '../model/alerts.dart';
import '../model/rive_asset.dart';
import '../pages/default_page.dart';
import '../pages/payment_page.dart';
import '../utils/neumorphicButton.dart';
import '../utils/rive_utils.dart';
import '../utils/side_menu.dart';
import '../utils/theme/theme_notifier.dart';
import '../widgets/animated_bar.dart';
import '../widgets/employee_details.dart';
import '../widgets/notification.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({
    super.key,
    required this.body,
  });
  final Widget body;

  @override
  State<EntryScreen> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<EntryScreen>
    with SingleTickerProviderStateMixin {
  late SMIBool isSideBarClosed;
  bool isSideMenuClosed = true;
  List<Alerts> alertList1 = [
    Alerts("1", "Please Wait While We Load Your Alerts.!!!!"),
  ];
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  RiveAsset selectedBottomNav = bottomNavs.first;
  bool _isSidebarOpen = false;
  bool _isProfilebarOpen = false;
  String name = "UserName";
  
  String? employee_id;
  String? company_id;
  
  void _toggleSidebar() {
    print(_isSidebarOpen);
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  void _toggleProfileBar() {
    setState(() {
      _isProfilebarOpen = !_isProfilebarOpen;
    });
  }
  
Future<void> fetchName() async {
  const storage = FlutterSecureStorage();

  final user = await storage.read(key: 'name');
 setState(() {
    name = user!;
  });
}
Future<void> fetchEmpId() async {
  const storage = FlutterSecureStorage();

  String?  employeeId1 =  await storage.read(key: 'employee_id');
  String?  companyId1 =  await storage.read(key: 'company_id');
 setState(() {
    employee_id = employeeId1;
    company_id = companyId1;
  });
}


_navigateToEmployeeDetails(BuildContext context, String employeeIdp, String companyIdp) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EmployeeDetailsScreen(
        employeeId: employeeIdp,
        companyId: companyIdp,
      ),
    ),
  );
}
String _getInitials(String name) {
  List<String> words = name.split(" ");
  String initials = "";
  for (var word in words) {
    if (word.isNotEmpty) {
      initials += word[0].toUpperCase();
    }
  }
  return initials;
}




@override
void initState() {
  super.initState();
  fetchName(); 
  fetchEmpId(); // Call fetchName when the widget is initialized
  _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  )..addListener(() {
      setState(() {});
    });
  animation = Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn),
  );
  scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
    CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn),
  );
  // getPrevious();
  // fetchAlerts();
}

 @override
Widget build(BuildContext context) {
  final themeNotifier = Provider.of<ThemeNotifier>(context);
  final size = MediaQuery.of(context).size;

  return Scaffold(
    resizeToAvoidBottomInset: false,
    extendBody: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Stack(
          children: [
            // Main Screen Body
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Material(
                      elevation: 10,
                      shadowColor: const Color.fromARGB(255, 233, 233, 233),
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.onSurface,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _navigateToEmployeeDetails(context, employee_id!, company_id!);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  shape: BoxShape.circle,
                                  
                                ),
                                child: CircleAvatar(
                                  minRadius: 30,
                                  backgroundColor: Theme.of(context).colorScheme.surface,
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Image.asset(
                                        "assets/images/logo.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                           Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the children evenly
                                  children: [
                                    // RichText will take up as much space as needed but allow for responsive resizing
                                    Flexible(
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.red.shade900, // Changed text color to red
                                            fontSize: MediaQuery.of(context).size.width * 0.05, // Responsive font size
                                            fontWeight: FontWeight.bold,
                                          ),
                                          text: name.toString(),
                                        ),
                                      ),
                                    ),
                                    // Use a SizedBox with dynamic width to maintain space between name and notification icon
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.1), // Adjust this based on the screen size
                                    // Wrap the Image with GestureDetector to enable click functionality
                                    GestureDetector(
                                      onTap: () {
                                        // Navigate to the NotificationPage when clicked
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NotificationPage(employeeId: employee_id, themeNotifier: themeNotifier,),
                                          ),
                                        );
                                      },
                                      child: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                          Colors.red.shade900, // Apply the red color filter
                                          BlendMode.srcATop, // This blend mode will overlay the color filter
                                        ),
                                        child: Image.asset(
                                          'assets/gif/notification.gif', // Path to your GIF
                                          width: MediaQuery.of(context).size.width * 0.1, // Make the width responsive
                                          height: MediaQuery.of(context).size.width * 0.1, // Make the height responsive
                                          fit: BoxFit.cover, // Make sure the GIF fits within the container
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                           GestureDetector(
                              onTap: () {
                                _toggleSidebar();
                              },
                              child: Icon(
                                Icons.menu,
                                color: Colors.red.shade900, // Color remains red for the menu icon
                                size: 40, // Size remains 40 for the icon
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  widget.body,
                ],
              ),
            ),
            // Left Side Menu
            SideMenu(
              isSidebarOpen: _isSidebarOpen,
              size: size,
              right: true,
              body: _isSidebarOpen
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Close Button on the Right Side
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: NeumorphicButton(
                                    size: 50,
                                    distance: 5,
                                    blur: 15,
                                    padding: 3,
                                    paddingColor: const Color.fromARGB(255, 220, 216, 216),
                                    onPressed: _toggleSidebar,
                                    child: Icon(
                                      Icons.cancel,
                                      color: Theme.of(context).colorScheme.onPrimary,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // User Initials Avatar
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.red.shade900,
                              child: Text(
                                _getInitials(name),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // User Greeting
                            Text(
                              "Hello, $name",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            const Divider(
                              height: 40,
                              thickness: 1,
                            ),
                            // Dark Mode/Light Mode Toggle
                            ListTile(
                              leading: NeumorphicButton(
                                size: 40,
                                distance: 5,
                                blur: 15,
                                padding: 3,
                                paddingColor: const Color.fromARGB(255, 220, 216, 216),
                                child: Icon(
                                  themeNotifier.isDarkMode
                                      ? Icons.dark_mode
                                      : Icons.light_mode,
                                  size: 24,
                                  color: Colors.red.shade900,
                                ),
                              ),
                              title: Text(
                                'Dark Mode',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                              trailing: Switch(
                                value: themeNotifier.isDarkMode,
                                onChanged: (value) {
                                  themeNotifier.toggleTheme();
                                },
                              ),
                            ),
                            const Divider(
                              height: 20,
                              thickness: 1,
                            ),
                            // Logout Button
                            ListTile(
                              leading: NeumorphicButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(AuthLogout());
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginPage()),
                                  );
                                },
                                size: 40,
                                distance: 5,
                                blur: 15,
                                padding: 3,
                                paddingColor: const Color.fromARGB(255, 220, 216, 216),
                                child: Icon(
                                  Icons.logout,
                                  size: 24,
                                  color: Colors.red.shade900,
                                ),
                              ),
                              title: Text(
                                'Logout',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.red.shade900,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            // Positioned Bottom Navigation
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
               decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade800 // Grey for dark theme
                  : Theme.of(context).colorScheme.onSecondary, // Default color for light theme
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      bottomNavs.length,
                      (index) => GestureDetector(
                        onTap: () {
                          if (bottomNavs[index] != selectedBottomNav) {
                            setState(() {
                              selectedBottomNav = bottomNavs[index];
                            });
                          }
                          bottomNavs[index].input!.change(true);
                          Future.delayed(const Duration(seconds: 1), () {
                            bottomNavs[index].input!.change(false);
                          });
                          switch (index) {
                            case 0:
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              } else {
                                SystemNavigator.pop();
                              }
                              break;
                            case 3:
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EntryScreen(body: HomePage()),
                                ),
                              );
                              break;
                            case 2:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EntryScreen(body: SlotPage()),
                                ),
                              );
                              break;
                            case 1:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EntryScreen(
                                    body: PaymentPage(employeeId: employee_id),
                                  ),
                                ),
                              );
                              break;
                          }
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedBar(
                              isActive: bottomNavs[index] == selectedBottomNav,
                            ),
                           SizedBox(
                              height: 30,
                              width: 30,
                              child: Opacity(
                                opacity: bottomNavs[index] == selectedBottomNav ? 1 : 0.7, // Reduced opacity to make the active icon more visible
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.red.shade900.withOpacity(1.0), // Increased opacity for a bolder color
                                    BlendMode.srcIn,
                                  ),
                                  child: RiveAnimation.asset(
                                    bottomNavs[index].src,
                                    artboard: bottomNavs[index].artboard,
                                    onInit: (artboard) {
                                      StateMachineController controller =
                                          RiveUtils.getRiveController(
                                        artboard,
                                        stateMachineName: bottomNavs[index].stateMachineName,
                                      );
                                      bottomNavs[index].input =
                                          controller.findSMI("active") as SMIBool;
                                    },
                                  ),
                                ),
                              ),
                            )
                            
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

}
    }