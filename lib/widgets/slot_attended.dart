import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/home/slot_model.dart';
import '../utils/theme/theme_notifier.dart';

class SlotAttended extends StatefulWidget {
  const SlotAttended({
    super.key,
    required this.themeNotifier,
    required this.data,
  });

  final ThemeNotifier themeNotifier;
  final SlotModel data;

  @override
  State<SlotAttended> createState() => _SlotAttendedState();
}

class _SlotAttendedState extends State<SlotAttended> {
  double _elevation = 15;
  bool is_open = false;

  void _onTap() {
    setState(() {
      is_open = !is_open;
    });

    // Optional: Adjust elevation after a slight delay
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        _elevation = is_open ? 0 : 15;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Keep the date as a String (no formatting applied)

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: _onTap,
        child: Stack(
          children: [
            // AnimatedContainer for the sliding effect
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              margin: is_open
                  ? const EdgeInsets.only(top: 10.0)
                  : const EdgeInsets.only(top: 0.0), // Adjust the value as needed
              child: is_open
                  ? Material(
                      elevation: 10,
                      shadowColor: widget.themeNotifier.isDarkMode
                          ? const Color.fromARGB(255, 233, 233, 233)
                          : const Color.fromARGB(255, 0, 0, 0),
                      color: Theme.of(context).colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(20),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 50),
                              Row(
                                children: [
                                  Icon(Icons.business, color: Colors.red.shade900),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "Company Name: ${widget.data.companyName}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        letterSpacing: 1.2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10), // Adjust spacing if needed
                              Row(
                                children: [
                                  Icon(Icons.location_on, color: Colors.red.shade900),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "Work Site: ${widget.data.worksite}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        letterSpacing: 1.2,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.access_time, color: Colors.red.shade900),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          letterSpacing: 1.2,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        text: "Hours Worked: ",
                                        children: [
                                          TextSpan(
                                            text:
                                                "${widget.data.attendanceIn} - ${widget.data.attendanceOut}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
                                              letterSpacing: 1.2,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(), // Hide the widget when is_open is false
            ),
            // Main card that stays on top
            Material(
              elevation: _elevation,
              shadowColor: widget.themeNotifier.isDarkMode
                  ? const Color.fromARGB(255, 233, 233, 233)
                  : const Color.fromARGB(255, 0, 0, 0),
              color: Theme.of(context).colorScheme.onSurface,
              borderRadius: BorderRadius.circular(20),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Spread out the content
                    children: [
                      // Date on the left side
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.red.shade900), // Icon for Date
                        const SizedBox(width: 10),
                        Text(
                          DateFormat('dd-MM-yyyy').format(widget.data.attendanceDate ?? DateTime.now()),
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),

                      // Icon for toggling
                      Icon(
                        is_open ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: Colors.red.shade900,
                      ), // Toggle icon to indicate opening/closing
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
