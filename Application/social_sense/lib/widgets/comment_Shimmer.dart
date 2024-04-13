import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CommentShimmer extends StatelessWidget {
  const CommentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: const Color.fromARGB(115, 127, 127, 127),
      period: const Duration(milliseconds: 2000),
      direction: ShimmerDirection.ttb,
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.width * 0.12,
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 24,
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
                          Container(
                            width: 100,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(12), // Rounded corners
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(12), // Rounded corners
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(12), // Rounded corners
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: context.width * 0.50,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(12), // Rounded corners
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            const Divider(
              color: Color(0xff242424),
              thickness: 0.5,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
