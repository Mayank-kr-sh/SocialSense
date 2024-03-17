import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_sense/views/home/home_screen.dart';
import 'package:social_sense/views/notification/notification_screen.dart';
import 'package:social_sense/views/profile/profile_screen.dart';
import 'package:social_sense/views/search/search_Screen.dart';
import 'package:social_sense/views/thread/thread_screen.dart';

class NavigationService extends GetxService {
  var currentIndex = 0.obs;
  var prevIndex = 0.obs;

  List<Widget> pages = <Widget>[
    const SearchScreen(),
    ThreadScreen(),
    const HomeScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  void updateIndex(int index) {
    prevIndex.value = currentIndex.value;
    currentIndex.value = index;
  }
}
