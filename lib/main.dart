import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'bloc/auth/auth_bloc.dart';
import 'bloc/bank/bank_bloc.dart';
import 'bloc/edit_employee/edit_employee_bloc.dart';
import 'bloc/notification/notification_bloc.dart';
import 'bloc/save_notification/save_notification_bloc.dart';
import 'bloc/show_notification/show_notification_bloc.dart';
import 'entry/entry_point.dart';
import 'firebase_options.dart';
import 'model/home/roster_model.dart';
import 'splash/splash_screen.dart';
import 'utils/theme/theme.dart';
import 'utils/theme/theme_notifier.dart';
import 'widgets/pdf_download.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    print(1);
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    print(22);
  }

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await _localNotificationsPlugin.show(
    0,
    message.data['notification_log_id'],
    message.notification?.body ?? message.data['body'],
    platformChannelSpecifics,
    payload:
        '${message.data['shift_data']}&&${message.data['notification_log_id']}',
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
int noti_if = 0;
String rosterModel = "";
Future<void> main() async {
  // BindingBase.debugZoneErrorsAreFatal = true;
  // runZonedGuarded(() async {
  WidgetsFlutterBinding.ensureInitialized();

  print(1);
  print('test');
  print(Firebase.apps.length);
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.android,
    );
  }

  print(2);
  print('test1');
  print(Firebase.apps.length);

  _initializeLocalNotifications();
  await _requestNotificationPermissions();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  String? token = await firebaseMessaging.getToken();
  print("token$token");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen(_handleMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    _handleNotificationTap(initialMessage);
  }
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
  // }, (error, stackTrace) {
  //   // Log or handle any unhandled exceptions here
  //   print('Caught error in zone: $error');
  // });
}

void _handleNotificationTap(RemoteMessage message) async {
  if (message.data.isNotEmpty) {
    String? shiftDataString = message.data['shift_data'];
    if (shiftDataString != null) {
      Map<String, dynamic> shiftData = json.decode(shiftDataString);
      RosterModel model = RosterModel.fromJson(shiftData);

      final int notificationId = int.parse(message.data['notification_log_id']);
      FlutterSecureStorage storage = const FlutterSecureStorage();
      await storage.write(
          key: 'notification_id', value: notificationId.toString());
      await storage.write(key: 'roster_model', value: json.encode(shiftData));

      // navigatorKey.currentState?.pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => EntryScreen(
      //       body: RespondSchedule(
      //         data: model,
      //         notification_id: notificationId,
      //       ),
      //     ),
      //   ),
      // );
    }
  }
}

void _initializeLocalNotifications() {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  _localNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: _onSelectNotification,
  );
}

Future<void> _requestNotificationPermissions() async {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}

void _handleMessage(RemoteMessage message) async {
  await _showNotification(message);
}

void _handleMessageOpenedApp(RemoteMessage message) {
  _handleNotificationTap(message);
}

Future<void> _showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await _localNotificationsPlugin.show(
    0,
    message.notification?.title ?? message.data['title'],
    message.notification?.body ?? message.data['body'],
    platformChannelSpecifics,
    payload:
        '${message.data['shift_data']}&&${message.data['notification_log_id']}',
  );
}

Future<void> _onSelectNotification(
    NotificationResponse notificationResponse) async {
  if (notificationResponse.payload != null) {
    String payload = notificationResponse.payload!;
    List<String> data = payload.split("&&");
    if (data.length == 2) {
      Map<String, dynamic> shiftData = json.decode(data[0]);
      RosterModel model = RosterModel.fromJson(shiftData);
      if (model.shiftDate == true &&
          model.shiftTime == null) {
        navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                EntryScreen(body: PdfCreatorPage(data: model)),
          ),
        );
      } else {
        final int notificationId = int.parse(data[1]);
        const FlutterSecureStorage storage = FlutterSecureStorage();
        await storage.write(
            key: 'notification_id', value: notificationId.toString());
        await storage.write(key: 'roster_model', value: json.encode(shiftData));

        // navigatorKey.currentState?.pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => EntryScreen(
        //       body: RespondSchedule(
        //         data: model,
        //         notification_id: notificationId,
        //       ),
        //     ),
        //   ),
        // );
      }
    }
  }
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(AuthCheck())),
        BlocProvider(create: (context) => NotificationBloc()),
        BlocProvider(create: (context) => EmployeePostBloc()),
        BlocProvider(create: (context) => BankPostBloc()),
        BlocProvider(create: (context) => ShowNotificationBloc()),
        BlocProvider(create: (context) => SaveNotificationBloc()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        themeMode: themeNotifier.currentTheme,
        title: 'Flutter Demo',
        home:
            //
            //     Scaffold(
            //   body: Container(
            //     height: 20,
            //     width: 20,
            //     color: Colors.red,
            //   ),
            // )
            // SplashScreen(),
            const SplashScreen(),
            
      ),
    );
  }
}
