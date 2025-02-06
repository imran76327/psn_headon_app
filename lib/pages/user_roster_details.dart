import 'package:flutter/material.dart';
import 'package:headon/model/home/salary_model.dart';
import 'package:headon/model/home/slot_model.dart';
import 'package:headon/model/home/utr_model.dart';
import 'package:headon/widgets/slot_attended.dart';
import 'package:provider/provider.dart';

import '../utils/theme/theme_notifier.dart';
import '../widgets/WageWork.dart';
import '../widgets/utr_work.dart';
import '../widgets/weeks_work.dart';


class SlotDetails extends StatefulWidget {
  const SlotDetails({
    super.key,
    required this.data,
    required this.data1,
    required this.data2,  // data2 holds the UTR data
    required this.type, // New property
  });

  final List<SlotModel> data;
  final List<SalaryData> data1;
  final List<UtrData> data2;  // This holds the UTR data
  final String type; // "slot" or "wage" or "utr"

  @override
  State<SlotDetails> createState() => SlotDetailsState();
}

class SlotDetailsState extends State<SlotDetails> {
  bool _isSidebarOpen = false;
  bool _isProfilebarOpen = false;

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  void _toggleProfileBar() {
    setState(() {
      _isProfilebarOpen = !_isProfilebarOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            if (widget.type == "slot") ...[  // Handling slot type
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: WeeksWork(
                      themeNotifier: themeNotifier,
                      data: widget.data[index],
                    ),
                  );
                },
              ),
            ] else if (widget.type == "wage") ...[  // Handling wage type
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.data1.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: WageWork(
                      themeNotifier: themeNotifier,
                      data1: widget.data1[index],
                    ),
                  );
                },
              ),
            ] else if (widget.type == "utr") ...[  // Handling UTR type
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.data2.length,  // Using data2 for UTR data
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: UtrWork(
                      themeNotifier: themeNotifier,
                      data2: widget.data2[index],  // Passing data2 for UTR
                    ),
                  );
                },
              ),
            ] else if (widget.type == "slot_attendance") ...[  // Handling UTR type
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: SlotAttended(
                      themeNotifier: themeNotifier,
                      data: widget.data[index],
                    ),
                  );
                },
              ),
            ],
            const SizedBox(height: 300),
          ],
          
        ),
      ),
    );
  }
}
