import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:intl/intl.dart';

import '../../../../../../homeFile/utility.dart';

class CampaignCorousel extends StatefulWidget {
  List description;
  List image;
  List links;
  List endDate;
  CampaignCorousel(
      {super.key,
      required this.description,
      required this.image,
      required this.links,
      required this.endDate});

  @override
  State<CampaignCorousel> createState() => _CampaignCorouselState();
}

class _CampaignCorouselState extends State<CampaignCorousel> {
  final nextPageController = CarouselController();
  double _currentIndexPage = 0;
  late ScrollController _controller;
  late ScrollController _scrollController;
  double _boxHeight = 0;
  static const _kBasePadding = 16.0;
  static const kExpandedHeight = 250.0;
  final ValueNotifier<double> _titlePaddingNotifier =
      ValueNotifier(_kBasePadding);

  double get _horizontalTitlePadding {
    const kCollapsedPadding = 60.0;

    if (_scrollController.hasClients) {
      return min(
          _kBasePadding + kCollapsedPadding,
          _kBasePadding +
              (kCollapsedPadding * _scrollController.offset) /
                  (kExpandedHeight - kToolbarHeight));
    }

    return _kBasePadding;
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.image.length; i++) {
      int currentDay = DateTime.now().day;
      DateTime givenDateTime =
          DateFormat("yyyy-MM-dd").parse(widget.endDate[i]);
      int givenDay = givenDateTime.day;
      if (currentDay == givenDay || givenDay < currentDay) {
        widget.links.removeAt(i);
        widget.image.removeAt(i);
        widget.endDate.removeAt(i);
        widget.description.removeAt(i);
      }
    }
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      bool isTop = _scrollController.position.pixels == 250;
      if (isTop) {
        setState(() {
          _boxHeight = 100;
        });
      } else {
        setState(() {
          _boxHeight = 0;
        });
        _controller = ScrollController();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    _scrollController.addListener(() {
      _titlePaddingNotifier.value = _horizontalTitlePadding;
    });
    return Stack(
      children: [
        CarouselSlider.builder(
            carouselController: nextPageController,
            itemCount: widget.image.length ?? 1,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return InkWell(
                onTap: () {
                  launchInBrowser(widget.links[itemIndex]);
                },
                child: cachedNetworkImage(
                  height: height * 0.3,
                  imageFit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  cuisineImageUrl: widget.image[itemIndex] ?? '',
                ),
              );
            },
            options: CarouselOptions(
                height: height,
                viewportFraction: 1,
                initialPage: 0,
                autoPlay: true,
                enableInfiniteScroll: false,
                autoPlayCurve: Curves.fastOutSlowIn,
                pageSnapping: true,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndexPage = index.toDouble();
                  });
                })),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: DotsIndicator(
            dotsCount: widget.image.length ?? 1,
            position: _currentIndexPage.toInt(),
            decorator: DotsDecorator(
              activeSize: const Size(20.0, 10.0),
              color: AppColors.grey,
              activeColor: AppColors.appThemeColor,
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
        ),
        Positioned(
          left: width * 0.02,
          bottom: height * 0.022,
          right: 0,
          child: Text(
            widget.description[_currentIndexPage.toInt()].toString(),
            style: TextStyle(
                backgroundColor: Colors.white, color: AppColors.black),
          ),
        )
      ],
    );
  }
}
