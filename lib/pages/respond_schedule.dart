
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:headon/model/home/slot_list_model.dart';
import 'package:headon/model/home/user_slot_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../bloc/notification/notification_bloc.dart';
import '../bloc/respond/respond_bloc.dart';
import '../entry/entry_point.dart';
import '../home/home_page.dart';
import '../utils/theme/theme_notifier.dart';

class RespondSchedule extends StatefulWidget {
  const RespondSchedule(
      {super.key, required this.data, 
      required this.notification_id, 
      required SlotListModel slotData, 
      required this.employee_Id, 
      required UserSlotModel userslotlist, 
      required this.userData,
      required this.mobileNumber});

  static const String routeName = '/respond_schedule';
  final SlotListModel data;
  final UserSlotModel userData;
  final int notification_id;
  final String employee_Id;
  
  final String mobileNumber ;
  
  
  @override
  State<RespondSchedule> createState() => RespondScheduleState();
}

class RespondScheduleState extends State<RespondSchedule> with TickerProviderStateMixin {

  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;

  @override
  void initState() {
    update();
    super.initState();

    _controllers = List.generate(8, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      );
    });

    _animations = List.generate(8, (index) {
      return Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.easeOut,
      ));
    });

    _startAnimation();
  }
   void _startAnimation() async {
    // Start animations with 0.1 second delay between each field.
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(Duration(milliseconds: 100 * i));
      _controllers[i].forward();
    }
  }


  update() {
    if (widget.notification_id != 0) {
      context
          .read<NotificationBloc>()
          .add(NotificationUpdate(id: widget.notification_id, confirmation: 1));
    }
  }

  bool isWithinNotificationTime(DateTime now) {
    DateTime? notiStartTime = widget.data.notiStartTime;
    DateTime? notiEndTime = widget.data.notiEndTime;
    return now.isAfter(notiStartTime) && now.isBefore(notiEndTime);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    final themeNotifier = Provider.of<ThemeNotifier>(context);

  return BlocProvider(
  create: (context) => RespondBloc(),
  child: BlocConsumer<RespondBloc, RespondState>(
    listener: (context, state) {
      if (state is RespondLoading) {
        // Optionally, you can show a loading indicator
        // This may not be needed if you handle it in the UI directly
      } else if (state is RespondSuccess) {
        // Show success dialog
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
                    color:Colors.green.shade900,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(Icons.check_circle, color: Colors.white, size: 50),
                      const SizedBox(height: 10),
                      const Text(
                        'Success!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Slot booked Successfully!',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EntryScreen(body: HomePage()),
                            ),
                          );
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is RespondError) {
          // Show error dialog
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
                    color: Colors.green.shade900,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(Icons.error, color: Colors.white, size: 50),
                      const SizedBox(height: 10),
                      const Text(
                        'Error',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Failed to book the Slot: Please Try Again!',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              );
          },
        );
      }
    },

        builder: (context, state) {
        return SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              const SizedBox(height: 20),
              SlideTransition(
                position: _animations[0], // Slot Name animation
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.onSurface,
                    elevation: 10,
                    shadowColor: Theme.of(context).colorScheme.onPrimary,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Icon(Icons.notification_important, color: Colors.red.shade900),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                widget.data.slotName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  letterSpacing: 1.2,
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
              const SizedBox(height: 20),
              SlideTransition(
                position: _animations[1], // Shift Date animation
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.onSurface,
                    elevation: 10,
                    shadowColor: Theme.of(context).colorScheme.onPrimary,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today, color: Colors.red.shade900),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Date: ${DateFormat('dd-MM-yyyy').format(widget.data.shiftDate)}", // Format DateTime to show date only
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  letterSpacing: 1.2,
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
               // Add this before the widgets section
// Ensure _animations is a list of `Animation<Offset>` properly initialized

const SizedBox(height: 20),
SlideTransition(
  position: _animations[2], // Shift Date animation
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Material(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).colorScheme.onSurface,
      elevation: 10,
      shadowColor: Theme.of(context).colorScheme.onPrimary,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(Icons.business, color: Colors.red.shade900), // Icon for Company
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Company: ${widget.data.companyName}", // Company Name
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    letterSpacing: 1.2,
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
const SizedBox(height: 20),
SlideTransition(
  position: _animations[3], // Work Site animation
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Material(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).colorScheme.onSurface,
      elevation: 10,
      shadowColor: Theme.of(context).colorScheme.onPrimary,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(Icons.location_on, color: Colors.red.shade900), // Icon for Work Site
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Work Site: ${widget.data.worksite}", // Work Site
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    letterSpacing: 1.2,
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
const SizedBox(height: 20),
SlideTransition(
  position: _animations[4], // Working Hours animation
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Material(
      borderRadius: BorderRadius.circular(10),
      color: Theme.of(context).colorScheme.onSurface,
      elevation: 10,
      shadowColor: Theme.of(context).colorScheme.onPrimary,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(Icons.access_time, color: Colors.red.shade900), // Icon for Working Hours
              const SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 15,
                      letterSpacing: 1.2,
                      fontFamily: 'Poppins', // New font family
                    ),
                    text: "Shift Time: ",
                    children: [
                      TextSpan(
                        text: "${widget.data.startTime} - ${widget.data.endTime}", // Working hours
                        style: const TextStyle(
                          fontSize: 16,
                          letterSpacing: 1.2,
                          fontFamily: 'Poppins',
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
    ),
  ),
),


               const SizedBox(height: 20),
                if (state is! RespondLoading)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: isWithinNotificationTime(now)
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              shadowColor: Theme.of(context).colorScheme.onPrimary,
                              backgroundColor: Colors.red.shade900,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () async {
                              // Show confirmation dialog
                              bool? confirmed = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Are you sure?"),
                                    content: const Text("Do you want to book the slot?"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false); // User pressed "No"
                                        },
                                        child: const Text("No"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true); // User pressed "Yes"
                                        },
                                        child: const Text("Yes"),
                                      ),
                                    ],
                                  );
                                },
                              );

                              // If the user confirmed (pressed "Yes"), trigger the event
                              if (confirmed == true) {
                                BlocProvider.of<RespondBloc>(context).add(
                                  RespondFetch(
                                    slotId: widget.data.id, // Slot ID
                                    siteId: widget.data.siteId, // Site ID
                                    companyId: widget.data.companyId,
                                    employee_Id: widget.employee_Id,
                                    mobileNum : widget.mobileNumber
                                  ),
                                );
                              }
                            },
                            child: const Center(
                              child: Text(
                                "Book Slot",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 1.2,
                                  fontFamily: 'Poppins',
                                
                                ),
                              ),
                            ),
                          )
                        : Material(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.onSurface,
                            elevation: 10,
                            child: SizedBox(
                              height: 50,
                              width: size.width,
                              child: const Center(
                                child: Text(
                                  "Outside Notification Period",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                  ),
                if (state is RespondLoading)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        },
      ),
    );
  }
}

