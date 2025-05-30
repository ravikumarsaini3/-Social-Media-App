import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/models/app_data.dart';
import 'package:social_media_app/screens/user_profile_screen.dart';
import '../api/Api_controller.dart';
import '../models/comment_model.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({super.key});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  final ApiController apiController = Get.put(ApiController());
  final AppData appData = AppData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: const Text("Post Comments"),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(UserProfileScreen());
            },
            icon: Icon(Icons.account_circle_outlined, size: 30),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Obx(() {
        if (apiController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (appData.commentList.isEmpty) {
          return const Center(child: Text('No Comments Found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12.0),
          itemCount: appData.commentList.length,
          itemBuilder: (context, index) {
            final comment = appData.commentList[index];
            return buildCommentCard(comment);
          },
        );
      }),
    );
  }

  Widget buildCommentCard(CommentModel comment) {
    return InkWell(
      onTap: () {
        Get.to(UserProfileScreen());
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue.shade200,
                    child: Text(
                      comment.email[0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      comment.email,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                comment.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Divider(height: 20, color: Colors.grey),
              Text(
                comment.body,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.4,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
