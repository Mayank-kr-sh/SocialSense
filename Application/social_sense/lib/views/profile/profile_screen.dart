import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_sense/controllers/login_controller.dart';
import 'package:social_sense/controllers/profile_controller.dart';
import 'package:social_sense/controllers/user_controller.dart';
import 'package:social_sense/routes/route_names.dart';
import 'package:social_sense/utils/styles/button_styles.dart';
import 'package:social_sense/widgets/image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _profileController = Get.put(ProfileController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Icon(Icons.language),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {
                _showLogoutConfirmation(context);
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 160,
                  collapsedHeight: 160,
                  automaticallyImplyLeading: false,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userController.getUser?.name ?? 'User Name',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  userController.getUser?.bio ?? 'User Bio',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Date of Birth: ${userController.getUser?.dob ?? 'User DOB'}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const CircleImage(
                              radius: 50,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: customOutlieStyle(),
                                onPressed: () {
                                  Get.toNamed(RouteNames.editProfile);
                                },
                                child: const Text('Edit Profile'),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: OutlinedButton(
                                style: customOutlieStyle(),
                                onPressed: () {},
                                child: const Text('Share Profile'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    const TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                          text: 'Threads',
                        ),
                        Tab(
                          text: 'Replies',
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                  floating: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Image.asset('assets/images/icon.jpg');
                  },
                ),
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.asset(
                        'assets/images/icon.jpg',
                      ),
                      title: const Text('Title'),
                      subtitle: const Text('Subtitle'),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

void _showLogoutConfirmation(BuildContext context) {
  LoginController loginController = Get.put(LoginController());
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Logout',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Divider(
              color: Colors.grey,
              thickness: 1.0,
              height: 20.0,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Are you sure you want to log out?',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 50),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: () {
                      print('LogOut');
                      Navigator.of(context).pop();
                      loginController.clearToken();
                      Get.offAllNamed(RouteNames.login);
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ],
        ),
      );
    },
  );
}
