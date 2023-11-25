import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../../../common_widgets/story_view.dart';
import '../../../../../../homeFile/utility.dart';
import '../../../../../app_colors/app_colors.dart';
import 'groundDetail.dart';

class Carousel extends StatefulWidget {
  List? image;
  bool storyView;
  Carousel({super.key, this.image, this.storyView = true});

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
        CarouselSlider.builder(
            carouselController: nextPageController,
            itemCount: widget.image == null ? 5 : widget.image!.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              return InkWell(
                onTap: () {
                  widget.storyView
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StoryPage(
                                files: widget.image ?? [],
                              )))
                      : null;
                },
                child: cachedNetworkImage(
                  height: height * 0.3,
                  imageFit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  cuisineImageUrl:
                      widget.image == null ? '' : widget.image![itemIndex],
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
            dotsCount: widget.image == null ? 5 : widget.image!.length,
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
