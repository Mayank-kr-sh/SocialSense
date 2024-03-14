import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_sense/services/navigation_services.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key) {
    navigationService.currentIndex.value = 2;
  }

  final NavigationService navigationService = Get.put(NavigationService());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          letIndexChange: (index) {
            navigationService.updateIndex(index);
            return true;
          },
          index: navigationService.currentIndex.value,
          color: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          items: const [
            CurvedNavigationBarItem(
              child: Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 25,
              ),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 25,
              ),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.home_outlined, color: Colors.white, size: 25),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 25,
              ),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.favorite_border_outlined,
                color: Colors.white,
                size: 25,
              ),
            ),
          ],
          onTap: (index) {
            navigationService.currentIndex.value = index;
          },
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: navigationService.pages[navigationService.currentIndex.value],
        ),
      ),
    );
  }
}
