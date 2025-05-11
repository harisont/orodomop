import 'package:flutter/material.dart';
import 'package:orodomop/services/service_manager.dart';
import 'package:orodomop/models/timer_model.dart';
import 'package:orodomop/widgets/buttons/timer_control_row.dart';
import 'package:orodomop/widgets/buttons/toggle_theme_button.dart';
import 'package:orodomop/widgets/stopwatches/cycle_timer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  void initState() {
    super.initState();
    // Add a callback to receive data sent from the TaskHandler.
    FlutterForegroundTask.addTaskDataCallback(ServiceManager.onReceiveTaskData);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Request permissions and initialize the service.
      ServiceManager.requestPermissions();
      ServiceManager.initService();
      context.read<TimerModel>().onAppRestart();
    });
  }

  @override
  void dispose() {
    // Remove a callback to receive data sent from the TaskHandler.
    FlutterForegroundTask.removeTaskDataCallback(
      ServiceManager.onReceiveTaskData,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WithForegroundTask(
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CycleTimer(),
                        TimerControlRow(),
                        SizedBox(height: 8),
                        ToggleThemeButton(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
