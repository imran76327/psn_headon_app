
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../bloc/home/home_bloc.dart';
import '../../entry/entry_point.dart';
import '../../model/home/home.dart';
import '../../model/rive_asset.dart';
import '../../pages/respond_schedule.dart';
import '../../pages/unbook_schdedule.dart';
import '../../pages/user_roster_details.dart';
import '../../utils/theme/theme_notifier.dart';
import '../../widgets/build_card.dart';
import '../../widgets/todays_work.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

  String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour >= 6 && hour < 12) {
    return "Good Morning \n"; // From 6 AM to 12 PM
  } else if (hour >= 12 && hour < 17) {
    return "Good Afternoon \n"; // From 12 PM to 5 PM
  } else {
    return "Good Evening \n"; // From 5 PM onwards
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeFetch()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2,
              ),
            );
          } else if (state is HomeSuccess) {
            HomeModel home = state.home;
            return HomePageContent(home: home);
          } else {
            return GestureDetector(
              onTap: () {
                // Re-dispatch the HomeFetch event to retry
                context.read<HomeBloc>().add(HomeFetch());
              },
              child: const SizedBox(
                width: 200,
                height: 200,
                child: Icon(
                  Icons.replay_outlined,
                  color: Colors.red,
                  size: 60,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key, required this.home});
  final HomeModel home;

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> with RouteAware {
  bool isDark = false;
  bool isPressed = false;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  RiveAsset selectedBottomNav = bottomNavs.first;
  // String notification_id = "";
  int notification_id = 0;
  String roster_model = "";
  
  @override
  void initState() {
    // checkFromNoti();
    // checkTheme();
    super.initState();
  }

  

  @override
  void didPopNext() {
    // This method is called when the current route has been popped back to.
    // Trigger the refresh event here.
    context.read<HomeBloc>().add(HomeFetch());
  }

  @override
  void dispose() {
    // Unsubscribe from the route observer
    // routeObserver.unsubscribe(this);
    super.dispose();
  }

  Future<void> _onRefresh() async {
    context.read<HomeBloc>().add(HomeFetch()); // Trigger the refresh event
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          /// MAIN BODY
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height *
                    0.9, // or any other height constraint you need
              ),
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Use min to shrink-wrap its children
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // GREETINGS
                   Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 20,
                        letterSpacing: 3,
                      ),
                      children: [
                        TextSpan(
                          text: getGreeting(), 
                          style: TextStyle(
                            color: Colors.red.shade900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                  const SizedBox(
                    height: 10,
                  ),

                  // GREETINGS
                  // CENTER BOXEX 1st ROW.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BuildCard(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EntryScreen(
                                          body: SlotDetails(
                                              data: widget
                                                  .home.slot_alloted_list, data1: const [],type: "slot", data2: const [],))));
                            },
                            context: context,
                            number: widget.home.slot_alloted_count.toString(),
                            title: "Slot Booked",
                            type:'slot',
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(1)),
                           
                        BuildCard(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EntryScreen(
                                          body: SlotDetails(
                                              data: widget.home
                                                  .slot_attended_list, data1: const [],type: "slot_attendance", data2: const [],))));
                            },
                            context: context,
                            number:
                                widget.home.slot_attended_count.toString(),
                            title: "Slot Attended",
                            type:'attend',
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(1)),
                      ],
                    ),
                  ),
                  // CENTER BOXEX 1st ROW.
                  const SizedBox(
                    height: 20,
                  ),
                  // CENTER BOXEX 2nd ROW.
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BuildCard(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EntryScreen(
                                    body: SlotDetails(
                                        data1: widget.home.wage_period_list, data: const [],type: "wage", data2: const [],),
                                  ),
                                ),
                              );
                            },
                            context: context,
                            number: widget.home.wage_period_count.toString(),
                            title: "Wages",
                            type:'wage',
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(1)),
                        BuildCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EntryScreen(
                                  body: SlotDetails(
                                      data2: widget.home.utr_list, data1: const [], type: "utr", data: const [],),
                                ),
                              ),
                            );
                          },
                          context: context,
                          number: widget.home.utr_count.toString(),
                          title: "UTR",
                          type:'utr',
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(1),
                        ),
                      ],
                    ),
                  ),
                  // CENTER BOXEX 2nd ROW.
                  const SizedBox(
                    height: 30,
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  // LIST HEADING
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 15,
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold),
                        text: "Weeks Work, \n",
                      ),
                    ),
                  ),
                  // LIST HEADING

                  // LIST
                  ListView.builder(
                    shrinkWrap: true, // Shrink wrap to avoid infinite height
                    physics:
                        const NeverScrollableScrollPhysics(), // Prevent scrolling inside ListView
                    itemCount: widget
                        .home.slot_details_list.length, // Number of items to display
                    itemBuilder: (context, index) {
                    final employeeId = widget.home.employeeId;
                    final weekList = widget.home.slot_details_list;
                    final userslotlist = widget.home.user_slot_list;
                    // final userslotlist = widget.home.user_slot_list;
                    final userSlotCount = userslotlist[index].count;
                    final mobileNumber = widget.home.mobileNo;

                     Widget body = Container(); // Default value for body

                    // Determine the body widget based on the userSlotCount
                    if (userSlotCount == 0) {
                      body = RespondSchedule(
                        slotData: weekList[index],
                        notification_id: 0,
                        data: weekList[index],
                        userslotlist: userslotlist[index],
                        employee_Id: employeeId,
                        userData: userslotlist[index],
                        mobileNumber:mobileNumber
                      );
                    } else if (userSlotCount == 1) {
                      body = UnbookSchdedule(
                        slotData: weekList[index],
                        notification_id: 0, 
                        data: weekList[index],
                        userslotlist: userslotlist[index],
                        employee_Id: employeeId,
                        userData: userslotlist[index],
                      );
                    } 
                      return Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: today_work(
                      data: weekList[index],
                      userData: userslotlist[index],
                      employee: widget.home.employeeId,
                      size: size,
                      onTap: () {
                        print(22);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EntryScreen(body: body),
                          ),
                        );
                      },
                    ),
                  );// Create a new today_work widget for each item
                    },
                  ),
                  const SizedBox(
                    height: 300,
                  ),
        
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
