import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_sense/models/post_model.dart';
import 'package:social_sense/routes/route_names.dart';
import 'package:social_sense/widgets/image.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.width * 0.12,
                child: const CircleImage(
                    // imageUrl: post.user.profilePicture,
                    ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: context.width * 0.80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          post.user.name,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            const Text('9 Hours ago'),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              child: const Icon(Icons.more_vert),
                              onTap: () {
                                print('Tap on Poster');
                              },
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    if (post.caption != null) Text(post.caption),
                    const SizedBox(height: 10),
                    if (post.media != null)
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: context.height * 0.50,
                          maxWidth: context.width * 0.80,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            post.media[0],
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_outline),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.toNamed(RouteNames.addComment, arguments: post);
                          },
                          icon: const Icon(Icons.mode_comment_outlined),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.send_outlined),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Text('${post.totalLikes.toString()} likes'),
                        const SizedBox(
                          width: 12,
                        ),
                        Text('${post.totalComments.toString()} replies'),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const Divider(
            color: Color(0xff242424),
          )
        ],
      ),
    );
  }
}
