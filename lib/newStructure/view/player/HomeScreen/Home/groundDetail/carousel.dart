import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../../../common_widgets/story_view.dart';
import '../../../../../../homeFile/utility.dart';
import '../../../../../app_colors/app_colors.dart';
import 'groundDetail.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
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
    _scrollController.addListener(() {
      _titlePaddingNotifier.value = _horizontalTitlePadding;
    });
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StoryPage(
                      files:
                          GroundDetailState.privateVenueDetail.images!.files!,
                    )));
          },
          child: CarouselSlider.builder(
              carouselController: nextPageController,
              itemCount: GroundDetailState.privateVenueDetail.images == null
                  ? 5
                  : GroundDetailState.privateVenueDetail.images!.files!.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                return cachedNetworkImage(
                  height: height * 0.3,
                  imageFit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  cuisineImageUrl: GroundDetailState.privateVenueDetail.images
                          ?.files![itemIndex]!.filePath ??
                      "",
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
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: DotsIndicator(
            dotsCount: GroundDetailState.privateVenueDetail.images == null
                ? 5
                : GroundDetailState.privateVenueDetail.images!.files!.length,
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
      ],
    );
  }
}
