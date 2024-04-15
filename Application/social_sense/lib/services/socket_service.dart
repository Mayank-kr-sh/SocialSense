import 'package:social_sense/models/notification_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;
  Function(dynamic)? onNotificationReceived;

  void createSocketConnection() {
    socket = IO.io(
        // 'http://10.0.5.212:3000',
        'https://socialsense.onrender.com',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();

    socket.onConnect((_) {
      print('Connected to Socket Server');
    });

    socket.on('notify_user', (data) {
      print('New comment notification received: $data');
      NotificationModel notification = NotificationModel.fromJson(data);
      print('Notification received: $notification');
      if (onNotificationReceived != null) {
        onNotificationReceived!(notification);
      }
    });

    socket.onError((data) {
      print("Socket Error: $data");
    });

    socket.onDisconnect((_) => print('Disconnected from Socket Server'));
  }

  void setNotificationHandler(Function(dynamic) handler) {
    print('Setting notification handler');
    onNotificationReceived = handler;
  }

  void listenToNotifications(Function(dynamic) handleData) {
    socket.on('notify_user', (data) {
      handleData(data);
    });
  }

  void sendComment(String postId, String userId, String comment,
      String userName, String url) {
    var data = {
      "postId": postId,
      "userId": userId,
      "comment": comment,
      "userName": userName,
      'url': url
    };
    print('Sending new Comment to server: $data');
    socket.emit('new_comment', data);
  }

  void disconnect() {
    if (socket != null) {
      socket.disconnect();
    }
  }
}
