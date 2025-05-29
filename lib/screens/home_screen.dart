import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/models/app_data.dart';
import 'package:social_media_app/screens/post_details_screen.dart';
import '../api/Api_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiController apiController = Get.put(ApiController());
  final AppData appData = AppData();

  @override
  void initState() {
    super.initState();
    apiController.fetchComments();
    apiController.fetchPost();
    apiController.fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: const Text("Posts"),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: Obx(() {
        if (apiController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (appData.postList.isEmpty) {
          return const Center(child: Text('No Posts Found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: appData.postList.length,
          itemBuilder: (context, index) {
            final post = appData.postList[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => const PostDetailsScreen());
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Post #${post.id}",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      post.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      post.body,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.4,
                        color: Colors.grey.shade800,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    const Divider(color: Colors.grey, height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(Icons.comment_outlined, size: 18, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          "View Comments",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
