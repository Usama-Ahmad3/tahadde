import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/localizations.dart';
import 'firstScreen.dart';
import 'secondScreen.dart';
import 'thirddScreen.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({super.key});

  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  final List<Widget> introWidgetsList = <Widget>[
    const FirstScreen(),
    const SecondScreen(),
    const ThirdScreen(),
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
          color: isActive ? Colors.yellow : Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              Positioned(
                bottom: 100,
                left: 135,
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      currentPageValue == 0
                          ? circleBar(true)
                          : circleBar(false),
                      currentPageValue == 1
                          ? circleBar(true)
                          : circleBar(false),
                      currentPageValue == 2
                          ? circleBar(true)
                          : circleBar(false),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            left: AppLocalizations.of(context)!.locale == 'en' ? 30 : 250,
            right: AppLocalizations.of(context)!.locale == 'en' ? 250 : 30,
            child: TextButton(
                onPressed: () {
                  controller.animateToPage(2,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.bounceInOut);
                  getChangedPageAndMoveBar(2);
                },
                child: Text(
                  AppLocalizations.of(context)!.skip,
                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                )),
          )
        ],
      ),
    );
  }
}
