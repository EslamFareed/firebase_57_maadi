import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: 10,
                channelKey: 'basic_channel',
                actionType: ActionType.Default,
                title: 'Hello Title',
                body: 'Hello Body, Mother Fathers..',
              ),
            );
          },
          child: const Text("Show Notification"),
        ),
      ),
    );
  }
}
