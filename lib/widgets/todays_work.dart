import 'dart:async';

import 'package:flutter/material.dart';
import 'package:headon/model/home/user_slot_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/home/slot_list_model.dart';
import '../utils/theme/theme_notifier.dart';

class today_work extends StatefulWidget {
  const today_work({
    super.key,
    required this.size,
    required this.onTap,
    required this.data,
    required this.userData, 
    required this.employee, 
    
  });

  final Size size;
  final VoidCallback onTap;
  final SlotListModel data;
  final UserSlotModel userData;
  final String employee;
  
  
  @override
  State<today_work> createState() => _today_workState();
}

class _today_workState extends State<today_work> {
  double _elevation = 10;

  void _onTap() {
    setState(() {
      _elevation = 0;
    });

    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        _elevation = 10;
      });
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final shiftDate = widget.data.shiftDate;
    String shiftTimeString = widget.data.startTime; 
  
    DateTime now = DateTime.now();

    DateTime? shiftStartTime;
    if (shiftTimeString.contains('-')) {
      List<String> times = shiftTimeString.split('-');
      String startTimeString = times[0].trim();

      shiftStartTime = DateTime(
        shiftDate.year,
        shiftDate.month,
        shiftDate.day,
        int.parse(startTimeString.split(':')[0]),
        int.parse(startTimeString.split(':')[1]),
      );
    }

    int differenceInHours = 0;
    if (shiftStartTime != null) {
      Duration difference = shiftStartTime.difference(now);
      differenceInHours = difference.inHours;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: () {
          final currentTime = DateTime.now(); 
          if (currentTime.isAfter(widget.data.notiStartTime) &&
              currentTime.isBefore(widget.data.notiEndTime)) {
            _onTap();
            print("Current time is between notiStartTime and notiEndTime.");
          } else {
            print("Current time is not within the specified notification time range.");
          }
        },
        onLongPress: () {},
        child: Material(
          elevation: _elevation,
          shadowColor: themeNotifier.isDarkMode == true
              ? const Color.fromARGB(255, 233, 233, 233)
              : const Color.fromARGB(255, 0, 0, 0),
          color: Theme.of(context).colorScheme.onSurface,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      color:Colors.red.shade900,
                      shadowColor: themeNotifier.isDarkMode == true
                          ? const Color.fromARGB(255, 233, 233, 233)
                          : const Color.fromARGB(255, 0, 0, 0),
                      elevation: 3,
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                      child: Text(
                      DateFormat('yyyy-MM-dd').format(widget.data.shiftDate),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),  

                        
                      ),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.cyan,
                      shadowColor: themeNotifier.isDarkMode
                          ? const Color.fromARGB(255, 233, 233, 233)
                          : const Color.fromARGB(255, 0, 0, 0),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          // Check if today’s date falls within the notification window
                          () {
                         final today = DateTime.now();
                          final shiftDateTime = DateTime(
                            widget.data.shiftDate.year,
                            widget.data.shiftDate.month,
                            widget.data.shiftDate.day,
                            20, // 8:00 PM on the shift date
                          );
                          final notiStartDate = widget.data.notiStartTime;
                          final id = widget.data.id;
                          final count = widget.userData.count;
                          final slotId = widget.userData.slotid;
                          final employeeId = widget.userData.employeeId;
                          final employee = widget.employee;

                          if (id == slotId && count == 1 && employee == employeeId) {
                            // "Booked" visible up to 4 hours below shift date
                            if (today.isBefore(shiftDateTime)) {
                              return "Booked";
                            } else {
                              return "Time Expired";
                            }
                          } else {
                            // "Book Slot" visible up to 4 hours below shift date
                            if (today.isBefore(shiftDateTime) && today.isAfter(notiStartDate) && count == 0) {
                              return "Book Slot";
                            } else if (today.isBefore(notiStartDate)) {
                              return "Pending";
                            } else {
                              return "Time Expired";
                            }
                          }
                          }(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          text: widget.data.startTime,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.red.shade900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
