
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/home/home_page.dart';
import '../bloc/save_notification/save_notification_bloc.dart';
import '../bloc/show_notification/show_notification_bloc.dart';
import '../entry/entry_point.dart';
import '../utils/theme/theme_notifier.dart';


class NotificationPage extends StatefulWidget {
  final String? employeeId;
  final ThemeNotifier themeNotifier;

  const NotificationPage({super.key, required this.employeeId, required this.themeNotifier});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    if (widget.employeeId != null) {
      BlocProvider.of<ShowNotificationBloc>(context)
          .add(FetchNotifications(employeeId: widget.employeeId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.red.shade900,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Transform.scale(
            scale: 0.5,
            child: Image.asset(
              'assets/images/undo.png',
              color: Colors.black,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      body: BlocListener<SaveNotificationBloc, SaveNotificationState>(
        listener: (context, state) {
          if (state is SaveNotificationSuccess) {
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
                        'Your notification Marked as Read!',
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
          } else if (state is SaveNotificationError) {
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
                        'Failed to Mark Your Notification!',
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
        child: BlocBuilder<ShowNotificationBloc, ShowNotificationState>(
          builder: (context, state) {
            if (state is ShowNotificationLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ShowNotificationSuccess) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Notifications',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade900,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(10),
                              //   border: Border.all(color: Colors.red.shade900, width: 1),
                              // ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.notifications.length,
                                itemBuilder: (context, index) {
                                  var notification = state.notifications[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Card(
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: ListTile(
                                      onTap: () {
                                        BlocProvider.of<SaveNotificationBloc>(context).add(
                                          SaveNotification(
                                            employeeId: widget.employeeId!,
                                            notificationId: notification.id,
                                          ),
                                        );
                                      },
                                      leading: Icon(
                                        Icons.notifications,
                                        color: Colors.red.shade900,
                                        size: 40,
                                      ),
                                      title: Text(
                                        '${notification.type} Notification', // Added space between type and 'Notification'
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red.shade900,
                                        ),
                                      ),
                                    subtitle: Text(
                                      notification.notificationMessage,
                                      style: TextStyle(
                                        fontSize: 14, // Adjusted font size for subtitle
                                        color: widget.themeNotifier.isDarkMode ? Colors.white : Colors.black, // Change text color based on theme
                                      ),
                                    ),

                                      trailing: notification.updatedAt == null
                                          ? const Icon(Icons.notifications_off, color: Colors.red)
                                          : const Icon(Icons.notifications_active, color: Colors.green),
                                    ),

                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 200,
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        decoration: BoxDecoration(
                          color: Colors.red.shade900,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: const Text(
                          'Go Back',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is ShowNotificationError) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
