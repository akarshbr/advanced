import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/post_controller.dart';

class DetailsDio extends StatelessWidget {
  final int index;

  DetailsDio({super.key, required this.index});

  final postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              postController.postList[index].title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(postController.postList[index].body)
          ],
        ),
      ),
    );
  }
}
