// import 'package:attendance_management/common/utils/coloors.dart';
// import 'package:attendance_management/common/widgets/diagonal_arrow.dart';
import 'package:flutter/material.dart';

import '../routes/routes.dart';
import 'bottom_left_arrow.dart';
import 'top_right_arrow.dart';
// import 'package:flutter/widgets.dart';

// class HalfCircleAvatarCard extends StatelessWidget {
class HalfCircleAvatarCard extends StatefulWidget {
  @override
  const HalfCircleAvatarCard(
      {super.key, this.imgurl, this.startTime, this.endTime});

  final String? imgurl;
  final String? startTime;
  final String? endTime;

  @override
  State<HalfCircleAvatarCard> createState() => _HalfCircleAvatarCardState();
}

class _HalfCircleAvatarCardState extends State<HalfCircleAvatarCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Theme.of(context).cardColor.withOpacity(0.8),
              margin: const EdgeInsets.only(top: 45.0),
              child: SizedBox(
                  height: 250.0,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, right: 40),
                          child: Center(
                            child: Row(
                              children: [
                                const BottomLeftArrow(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.startTime == null
                                            ? "--:-- --"
                                            : widget.startTime!.toUpperCase(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "Start time",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 45,
                                ),
                                Container(
                                  color: Colors
                                      .black, // or any color you want for the divider
                                  width: 1.0,
                                  height: 40.0, // Adjust the height as needed
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const TopRightArrow(),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.endTime == null
                                            ? "--:-- --"
                                            : widget.endTime!.toUpperCase(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "End time",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),

                                // TopRightArrow(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Navigator.pushNamed(
                                      //   context,
                                      //   Routes.applyLeave,
                                      // );
                                      _showOptionsDialog(context);
                                      // Handle button press
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30.0),
                                        ),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        'Correct Attendance',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // const SizedBox(
                              //   width: 30,
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //       left: 10.0, right: 10.0),
                              //   child: Expanded(
                              //     child: ElevatedButton(
                              //       onPressed: () {
                              //         Navigator.pushNamed(
                              //           context,
                              //           Routes.earlyLeave,
                              //         );
                              //         // Handle button press
                              //       },
                              //       style: ElevatedButton.styleFrom(
                              //         backgroundColor: Colors.white,
                              //         shape: const RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.only(
                              //             topLeft: Radius.circular(30.0),
                              //             bottomRight: Radius.circular(30.0),
                              //           ),
                              //         ),
                              //       ),
                              //       child: const Padding(
                              //         padding: EdgeInsets.all(10.0),
                              //         child: Text(
                              //           'EARLY LEAVE',
                              //           style: TextStyle(
                              //             fontWeight: FontWeight.bold,
                              //             fontSize: 17,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),

                        // Center(
                        //   child: SizedBox(
                        //     width: MediaQuery.of(context).size.width * 0.80,
                        //     height: 50,
                        //     child: ElevatedButton(
                        //       onPressed: () {
                        //         Navigator.pushNamed(
                        //           context,
                        //           Routes.markAttendance,
                        //         );
                        //       },
                        //       child: const Text(
                        //         "Record Attendance",
                        //         style: TextStyle(fontSize: 20),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  )),
            ),
          ),
          Positioned(
            top: .0,
            left: .0,
            right: .0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .surface, // Border color
                    width: 4.0, // Border width
                  ),
                ),
                child: CircleAvatar(
                  radius: 45.0,
                  backgroundImage: widget.imgurl == null
                      ? const AssetImage('assets/images/logo.png')
                      : AssetImage(widget.imgurl
                          .toString()), // change to user profile pic
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _showOptionsDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xFF7553F6).withOpacity(0.7),
        title: const Center(
          child: Text(
            'Choose an Option',
            style: TextStyle(color: Colors.white),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pushNamed(
                  context,
                  Routes.correctIntime, // Redirect to the Apply Leave screen
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7553F6).withOpacity(1),
                foregroundColor: Colors.white,
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Correct In Time',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pushNamed(
                  context,
                  Routes.correctOuttime, // Redirect to the Early Leave screen
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7553F6).withOpacity(1),
                foregroundColor: Colors.white,
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Correct Out Time',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
