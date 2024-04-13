import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_sense/controllers/comments_controller.dart';
import 'package:social_sense/models/post_model.dart';
import 'package:social_sense/widgets/comment_Shimmer.dart';
import 'package:social_sense/widgets/image.dart';

class Comments extends StatelessWidget {
  Comments({super.key});

  final Post post = Get.arguments;
  final CommentsController commentController = Get.put(CommentsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Comments'),
        actions: [
          Obx(
            () => TextButton(
              onPressed: () {
                commentController.postComment();
              },
              child: commentController.commentLoading.value
                  ? const SizedBox(
                      height: 14,
                      width: 14,
                      child: CircularProgressIndicator(),
                    )
                  : const Text(
                      'Post',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
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
                      const SizedBox(height: 10),
                      TextField(
                        autofocus: true,
                        controller: commentController.commentController,
                        onChanged: (value) =>
                            commentController.comments.value = value,
                        style: const TextStyle(fontSize: 14),
                        maxLines: 10,
                        maxLength: 1000,
                        minLines: 1,
                        decoration: const InputDecoration(
                          hintText: 'Add a comment',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Obx(() => commentController.commentDeleted.value
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const CommentShimmer();
                    },
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: post.comments.length,
                    itemBuilder: (context, index) {
                      final comment = post.comments.reversed.toList()[index];
                      Color bgColor = _getCommentColor(comment.text);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 8.0),
                        child: GestureDetector(
                          onLongPress: () {
                            _showLogoutConfirmation(context, comment.id);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                const CircleImage(
                                  radius: 25,
                                  // imageUrl: comment.user
                                  //     .profilePicture, // Assuming imageUrl is now provided
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20, bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                comment.user.name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const Row(
                                                children: [
                                                  Text('9 Hours ago'),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          comment.text,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: bgColor,
                                          ),
                                          overflow: TextOverflow.visible,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )),
          ],
        ),
      ),
    );
  }

  Color _getCommentColor(String text) {
    if (text.length < 5) {
      return Colors.red;
    } else if (text.length >= 5 && text.length <= 10) {
      return Colors.yellow;
    } else {
      return const Color.fromARGB(255, 4, 104, 255);
    }
  }
}

void _showLogoutConfirmation(BuildContext context, String commentId) {
  CommentsController commentController = Get.find<CommentsController>();
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Delete Comment?',
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
              'Are you sure you want to Delete?',
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
                    print('Deleted');
                    Navigator.of(context).pop();
                    commentController.deleteComment(commentId);
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
