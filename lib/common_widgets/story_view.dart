import 'package:flutter/material.dart';
import 'package:story/story.dart';

import '../homeFile/utility.dart';

class StoryPage extends StatelessWidget {
  final List<dynamic> files;
  final int initialIndex;

  const StoryPage({Key? key, required this.files, required this.initialIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          Navigator.of(context).pop();
        },
        child: StoryPageView(
          initialPage: initialIndex,
          initialStoryIndex: (i) {
            return initialIndex;
          },
          itemBuilder: (context, pageIndex, storyIndex) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Container(color: Colors.black),
                ),
                Positioned.fill(
                  child: cachedNetworkImage(
                    imageFit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    cuisineImageUrl: files[storyIndex] ?? "",
                  ),
                ),
              ],
            );
          },
          gestureItemBuilder: (context, pageIndex, storyIndex) {
            return Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
          pageLength: 1,
          storyLength: (int pageIndex) {
            return files.length;
          },
          onPageLimitReached: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class UserModel {
  UserModel(this.stories, this.userName, this.imageUrl);

  final List<StoryModel> stories;
  final String userName;
  final String imageUrl;
}

class StoryModel {
  StoryModel(this.imageUrl);

  final String imageUrl;
}
