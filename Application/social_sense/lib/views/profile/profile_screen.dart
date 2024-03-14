import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_sense/controllers/profile_controller.dart';
import 'package:social_sense/routes/route_names.dart';
import 'package:social_sense/utils/styles/button_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Icon(Icons.language),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.sort),
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
                                const Text(
                                  'Mayank Kumar Shah',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                    width: context.width * 0.6,
                                    child: const Text('Flutter Developer')),
                              ],
                            ),
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('assets/images/avatar.png'),
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
