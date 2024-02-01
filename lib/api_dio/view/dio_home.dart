import 'package:advanced/api_dio/controller/post_controller.dart';
import 'package:advanced/api_dio/utils/color_constant.dart';
import 'package:advanced/api_dio/view/details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void main() {
  runApp(GetMaterialApp(
    home: DioHome(),
    debugShowCheckedModeBanner: false,
  ));
}

class DioHome extends StatelessWidget {
  DioHome({super.key});

  final postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgColor,
      floatingActionButton:
          Obx(() => postController.internetConnection.value ? buildFAB() : Container()),
      body: Obx(
        () => SizedBox(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          child: postController.internetConnection.value
              ? (postController.isLoading.value ? loadAnimation() : getData())
              : showNoInternet(context),
        ),
      ),
    );
  }

  FloatingActionButton buildFAB() {
    return FloatingActionButton(
      onPressed: () {
        postController.isScrollDown.value ? postController.scrollUp() : postController.scrollDown();
      },
      child: FaIcon(postController.isScrollDown.value
          ? FontAwesomeIcons.arrowUp
          : FontAwesomeIcons.arrowDown),
    );
  }

  Center loadAnimation() {
    return Center(
      child: Lottie.network(
          "https://lottie.host/e088ae9f-53c9-49f2-8ebc-5860add3026b/BdJLFBq0uU.json"),
    );
  }

  Center showNoInternet(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: Lottie.network(
                "https://lottie.host/f2748d0f-6f2d-414c-a548-45dca61fbf9e/uXRLsJRAxK.json"),
          ),
          MaterialButton(
            onPressed: () {
              onTapTryAgain(context);
            },
            child: Text("Try Again"),
          )
        ],
      ),
    );
  }

  RefreshIndicator getData() {
    return RefreshIndicator(
      onRefresh: () {
        return postController.loadPost();
      },
      child: ScrollablePositionedList.builder(
          itemScrollController: postController.itemController,
          physics: BouncingScrollPhysics(),
          itemCount: postController.postList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(DetailsDio(
                  index: index,
                ));
              },
              child: Card(
                child: ListTile(
                  leading: Text(
                    postController.postList[index].id.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  title: Text(postController.postList[index].title,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  subtitle: Text(postController.postList[index].body),
                ),
              ),
            );
          }),
    );
  }

  void onTapTryAgain(BuildContext context) async {
    if (await InternetConnectionChecker().hasConnection == true) {
      postController.loadPost();
    } else {
      showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message: "No Internet,try again!"));
    }
  }
}
