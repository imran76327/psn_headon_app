
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:headon/model/home/utr_model.dart';
import '../utils/theme/theme_notifier.dart';

class UtrWork extends StatefulWidget {
  const UtrWork({
    super.key,
    required this.themeNotifier,
    required this.data2,
  });

  final ThemeNotifier themeNotifier;
  final UtrData data2;

  @override
  State<UtrWork> createState() => UtrWorkState();
}

class UtrWorkState extends State<UtrWork> {
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
                                  Icon(Icons.monetization_on,
                                      color: Colors.red.shade900),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        text: "Salary: ",
                                        children: [
                                          TextSpan(
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.onPrimary,
                                                fontSize: 20,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              text: widget.data2.amount.toStringAsFixed(2), // Assuming you want 2 decimal places
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Icon(Icons.list_alt,
                                      color: Colors.red.shade900),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "Utr: ${widget.data2.utr}",
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Colors.red.shade900),
                          const SizedBox(width: 10),
                          Text(
                            "Generated Date: ${widget.data2.formattedDate}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        is_open ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: Colors.red.shade900,
                      ), 
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
