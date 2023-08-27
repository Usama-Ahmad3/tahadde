import 'package:flutter/material.dart';
import 'firstScreen.dart';
import 'secondScreen.dart';
import 'thirddScreen.dart';

class WalkThroughScreen extends StatefulWidget {
  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  final List<Widget> introWidgetsList = <Widget>[
    FirstScreen(),
    SecondScreen(),
    ThirdScreen(),
  ];
  PageController controller = PageController(initialPage: 0);
  var currentPageValue = 0;
  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? const Color(0XFF032040) : Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        PageView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: introWidgetsList.length,
          onPageChanged: (page) {
            setState(() {
              getChangedPageAndMoveBar(page);
            });
          },
          controller: controller,
          itemBuilder: (context, index) {
            return introWidgetsList[index];
          },
        ),
        Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  currentPageValue == 0 ? circleBar(true) : circleBar(false),
                  currentPageValue == 1 ? circleBar(true) : circleBar(false),
                  currentPageValue == 2 ? circleBar(true) : circleBar(false),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
