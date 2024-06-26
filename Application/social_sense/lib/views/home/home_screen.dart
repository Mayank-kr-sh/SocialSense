import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_sense/controllers/home_controller.dart';
import 'package:social_sense/models/post_model.dart';
import 'package:social_sense/widgets/card_loader.dart';
import 'package:social_sense/widgets/post_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: RefreshIndicator(
          onRefresh: () async {
            await controller.fetchPost();
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image.asset('assets/images/logo1.png',
                      height: 50, width: 300),
                ),
                centerTitle: true,
                // floating: true,
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Obx(
                      () => controller.posts.isEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return const ShimmerLoading();
                              },
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.posts.length,
                              itemBuilder: (context, index) {
                                final PostModel postModel =
                                    controller.posts.toList()[index];
                                return Column(
                                  children:
                                      postModel.posts.reversed.map((post) {
                                    return PostCard(post: post);
                                  }).toList(),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
