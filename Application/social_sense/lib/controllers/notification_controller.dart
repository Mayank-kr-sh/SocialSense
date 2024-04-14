import 'package:get/get.dart';
import 'package:social_sense/models/notification_model.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationModel>[].obs;
  RxBool hasUnreadNotifications = false.obs;

  void markNotificationsRead() {
    hasUnreadNotifications.value = false;
  }

  void addNotification(NotificationModel notification) {
    print(
        'Adding notification: ${notification.comment} from ${notification.userName}');
    hasUnreadNotifications.value = true;
    notifications.add(notification);
  }
}
