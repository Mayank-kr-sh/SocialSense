import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_sense/controllers/search_user_controller.dart';
import 'package:social_sense/models/user_model.dart';
import 'package:social_sense/widgets/search_Input.dart';
import 'package:social_sense/widgets/user_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController =
      TextEditingController(text: '');

  final SearchUserController controller = Get.put(SearchUserController());

  void searchUser(String? name) async {
    if (name != null && name.isNotEmpty) {
      controller.searchUser(name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            centerTitle: false,
            title: const Text(
              'Search',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
            ),
            expandedHeight: 105,
            collapsedHeight: 80,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 90),
              child: SearchInput(
                  searchController: _searchController, callback: searchUser),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () => controller.loading.value == null
                  ? const Center(child: CircularProgressIndicator())
                  : controller.notFound.value && controller.user.isEmpty
                      ? const Center(child: Text('No user found'))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.user.length,
                          itemBuilder: (context, index) {
                            UserModel currentUser = controller.user[index];
                            return UserTile(user: currentUser);
                          },
                        ),
            ),
          )
        ],
      ),
    );
  }
}
