import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_sense/controllers/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationController notificationController =
      Get.find<NotificationController>();

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Obx(
        () => notificationController.notifications.isEmpty
            ? const Center(
                child: Text('No New Notifications'),
              )
            : ListView.builder(
                itemCount: notificationController.notifications.length,
                itemBuilder: (context, index) {
                  final notification =
                      notificationController.notifications[index];
                  return Dismissible(
                    key: Key(notification.postId),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      notificationController.notifications.removeAt(index);
                      showAboutDialog(
                        context: context,
                        applicationName: 'Notification Deleted',
                        applicationVersion: 'Notification Deleted Successfully',
                        applicationIcon: const Icon(Icons.delete),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'From: ${notification.userName}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Comments: ${notification.comment}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                notification.url,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.error,
                                  size: 100,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
