import 'package:flutter/material.dart';
import 'package:orodomop/screens/timer_screen.dart';
import 'package:provider/provider.dart';
import 'package:orodomop/models/timer_model.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:orodomop/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final timerModel = await TimerModel.create();
  NotificationService().initNotification();

  FlutterForegroundTask.initCommunicationPort();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => timerModel)],
      child: OrodomopApp(),
    ),
  );
}

class OrodomopApp extends StatelessWidget {
  const OrodomopApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPrint("Restart");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {'/': (context) => const TimerScreen()},
      initialRoute: '/',
      title: 'Orodomop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
