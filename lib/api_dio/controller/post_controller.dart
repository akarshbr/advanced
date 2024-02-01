import 'package:advanced/api_dio/model/post_model.dart';
import 'package:advanced/api_dio/services/dio_service.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PostController extends GetxController {
  var postList = [].obs;
  RxBool isLoading = true.obs;
  RxBool internetConnection = true.obs;
  RxBool isScrollDown = false.obs;
  var url = "https://jsonplaceholder.typicode.com/posts";
  var itemController = ItemScrollController();

  void checkInternetConnection() async {
    internetConnection.value = await InternetConnectionChecker().hasConnection;
  }

  Future<void> loadPost() async {
    checkInternetConnection();
    isLoading.value = true;
    var response = await DioService().fetchPost(url);
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        PostModel.fromJson(element);
        postList.add(PostModel.fromJson(element));
      });
      isLoading.value = false;
    }
  }

  void scrollDown() {
    itemController.scrollTo(
        index: postList.length, duration: Duration(seconds: 3), curve: Curves.linear);
    isScrollDown.value = true;
  }

  void scrollUp() {
    itemController.scrollTo(
        index: 0, duration: Duration(seconds: 3), curve: Curves.linear);
    isScrollDown.value = false;
  }

  @override
  void onInit() {
    loadPost();
    super.onInit();
  }
}
