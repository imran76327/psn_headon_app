import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/home/roster_model.dart';
import '../utils/theme/theme_notifier.dart';

class defaultList extends StatefulWidget {
  const defaultList({super.key, required this.record, required this.onTap});

  final RosterModel record;
  final VoidCallback onTap;
  @override
  State<defaultList> createState() => _defaultListState();
}

class _defaultListState extends State<defaultList> {
  @override
  Widget build(BuildContext context) {
    DateTime shiftDate = widget.record.shiftDate;
    String shiftTimeString = widget.record.shiftTime;
    DateTime now = DateTime.now();

// Check if shift_time contains a hyphen and split it
    DateTime? shiftStartTime;
    if (shiftTimeString.contains('-')) {
      // Split the time string by hyphen
      List<String> times = shiftTimeString.split('-');

      // Get the start time and trim any whitespace
      String startTimeString = times[0].trim();

      // Parse the start time to a DateTime object
      shiftStartTime = DateTime(
        shiftDate.year,
        shiftDate.month,
        shiftDate.day,
        int.parse(startTimeString.split(':')[0]), // Extract hour
        int.parse(startTimeString.split(':')[1]), // Extract minute
      );
    }
    int differenceInHours = 0;
    if (shiftStartTime != null) {
      // Calculate the difference in hours between the current time and the shift start time
      Duration difference = shiftStartTime.difference(now);
      differenceInHours = difference.inHours;
    }
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Material(
          elevation: 20,
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
                      color: Colors.red.shade900,
                      shadowColor: themeNotifier.isDarkMode == true
                          ? const Color.fromARGB(255, 233, 233, 233)
                          : const Color.fromARGB(255, 0, 0, 0),
                      elevation: 3,
                      borderRadius: BorderRadius.circular(10),
                     child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        DateFormat('yyyy-MM-dd').format(widget.record.shiftDate), // Format as needed
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
                      shadowColor: themeNotifier.isDarkMode == true
                          ? const Color.fromARGB(255, 233, 233, 233)
                          : const Color.fromARGB(255, 0, 0, 0),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          widget.record.attendanceCheck == 1
                                ? "Booked"  // If attendanceCheck is 1, show "Booked"
                                : "Unbooked" // If attendanceCheck is 0, show "Unbooked"
                            ,
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
                          children: [
                            TextSpan(text: widget.record.shiftTime),
                            const TextSpan(text: " - "),
                            TextSpan(text: widget.record.endTime),
                          ],
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
