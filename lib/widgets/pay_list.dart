import 'package:flutter/material.dart';
import 'package:headon/model/home/payment_modal.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../utils/theme/theme_notifier.dart';

class PayList extends StatefulWidget {
  const PayList({super.key, required this.record, required this.onTap});

  final PaymentSlip record;
  final VoidCallback onTap;

  @override
  State<PayList> createState() => _PayListState();
}

class _PayListState extends State<PayList> {
  @override
  Widget build(BuildContext context) {
    // Format the created_at date as 'dd-mm-yyyy'
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.record.createdAt));

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
                    // Left Side: Slot Name
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
                          widget.record.slotName, // Display slot name here
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Right Side: Created Date (formatted)
                   Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    formattedDate, // Display formatted date
                    style: TextStyle(
                      color: Colors.red.shade900, // Red color for the date
                      fontWeight: FontWeight.bold,
                    ),
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
