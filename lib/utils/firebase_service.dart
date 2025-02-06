// import 'dart:convert';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/material.dart';

// import '../entry/entry_point.dart';
// import '../model/home/roster_model.dart';
// import '../pages/respond_schedule.dart';
// // import '../main.dart';

// class FirebaseService {
//   final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   FirebaseService() {
//     _initializeLocalNotifications();
//   }

//   Future<void> initializeFirebase() async {
//     // Avoid re-initializing Firebase
//     _requestNotificationPermissions();
//     _configureFirebaseListeners();
//   }

//   void _initializeLocalNotifications() {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     _localNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: _onSelectNotification,
//     );
//   }

//   Future<void> _requestNotificationPermissions() async {
//     print(Firebase.apps.isEmpty);
//     // if (Firebase.apps.isEmpty) {
//     //   //   try {
      // await Firebase.initializeApp(
      //   // name: "appnotification",
      //   options: FirebaseOptions(
      //     apiKey: 'AIzaSyBgXyxpQ7aiGTU-JwXt6S-ysoGZbN4OxHM',
      //     appId: '1:431271578750:android:f2e54d2f5e2bd26ee0dc2f',
      //     messagingSenderId: '431271578750',
      //     projectId: 'appnotification-85128',
      //     storageBucket: 'appnotification-85128.appspot.com',
      //   ),
//     //   );
//     //   //     print("Firebase initialized");
//     //   //   } catch (e) {
//     //   //     print("Firebase initialization error: ${e.toString()}");
//     //   //   }
//     // } else {
//     //   print("Firebase already initialized");
//     // }
//     final FirebaseMessaging _messaging = FirebaseMessaging.instance;

//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print('User granted provisional permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }

//   void _configureFirebaseListeners() {
//     FirebaseMessaging.onMessage.listen(_handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
//   }

//   void _handleMessage(RemoteMessage message) async {
//     // Handle incoming message when the app is in the foreground
//     print("Message received: ${message.messageId}");
//     await _showNotification(message);
//   }

//   void _handleMessageOpenedApp(RemoteMessage message) {
//     // Handle app launch from a notification tap
//     if (message.data.isNotEmpty) {
//       String? shiftDataString = message.data['shift_data'];

//       if (shiftDataString != null) {
//         Map<String, dynamic> shiftData = json.decode(shiftDataString);
//         _onSelectNotification(NotificationResponse(
//           notificationResponseType:
//               NotificationResponseType.selectedNotification,
//           payload: shiftDataString,
//         ));
//       }
//     }
//   }

//   Future<void> _showNotification(RemoteMessage message) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'your_channel_id', // Channel ID
//       'your_channel_name', // Channel Name
//       importance: Importance.high,
//       priority: Priority.high,
//     );

//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     await _localNotificationsPlugin.show(
//       0, // Notification ID
//       message.notification?.title,
//       message.notification?.body,
//       platformChannelSpecifics,
//       payload: message.data['shift_data'] +
//           "&&" +
//           message.data['notification_log_id'],
//     );
//   }

//   Future<void> _onSelectNotification(
//       NotificationResponse notificationResponse) async {
//     // Navigate to the desired screen
//     if (notificationResponse.payload != null) {
//       String payload = notificationResponse.payload!;
//       List<String> data = payload.split("&&");
//       if (data.length == 2) {
//         Map<String, dynamic> shiftData = json.decode(data[0]);
//         RosterModel model = RosterModel.fromJson(shiftData);

//         // Use your navigator to navigate to the appropriate screen
//         Navigator.of(navigatorKey.currentContext!).pushReplacement(
//           MaterialPageRoute(
//             builder: (context) => EntryScreen(
//               body: RespondSchedule(
//                 data: model,
//                 notification_id: int.parse(data[1]),
//               ),
//             ),
//           ),
//         );
//       }
//     }
//   }
// }
