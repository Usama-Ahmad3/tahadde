import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/modelClass/academy_model.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/carousel.dart';

import '../../../../../../homeFile/utility.dart';
import '../../../../../../localizations.dart';
import '../../../../../../main.dart';
import '../../../../../../modelClass/my_venue_list_model_class.dart';
import '../../../../../app_colors/app_colors.dart';
import '../../../../player/HomeScreen/widgets/app_bar.dart';

class ViewMoreAcademyScreen extends StatelessWidget {
  final List<AcademyModel> academy;
  const ViewMoreAcademyScreen({Key? key, required this.academy})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.black,
        appBar: appBarWidget(
            sizeWidth: sizeWidth,
            sizeHeight: sizeHeight,
            context: context,
            title: AppLocalizations.of(context)!.academy,
            back: true),
        body: Container(
            color: Colors.black54,
            child: Container(
                height: sizeHeight,
                width: sizeWidth,
                decoration: BoxDecoration(
                    color: MyAppState.mode == ThemeMode.light
                        ? const Color(0XFFD6D6D6)
                        : AppColors.darkTheme,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: sizeHeight * 0.01,
                      ),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: academy.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return academy[index].status == 'Verified'
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: sizeHeight * 0.01,
                                      horizontal: sizeWidth * 0.06),
                                  child: Container(
                                    width: sizeWidth * 0.9,
                                    decoration: BoxDecoration(
                                      color: MyAppState.mode == ThemeMode.light
                                          ? AppColors.grey200
                                          : AppColors.containerColorW12,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: DefaultTextStyle(
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? AppColors.black
                                                    : AppColors.white),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          sizeWidth * 0.02,
                                                      vertical:
                                                          sizeHeight * 0.005),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '${AppLocalizations.of(context)!.status}:',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                color: MyAppState
                                                                            .mode ==
                                                                        ThemeMode
                                                                            .light
                                                                    ? AppColors
                                                                        .black
                                                                    : AppColors
                                                                        .white),
                                                      ),

                                                      ///status
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .verified,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                color: MyAppState
                                                                            .mode ==
                                                                        ThemeMode
                                                                            .light
                                                                    ? AppColors
                                                                        .appThemeColor
                                                                    : AppColors
                                                                        .white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: SizedBox(
                                                      height:
                                                          sizeHeight * 0.193,
                                                      child: Carousel(
                                                        image: academy[index]
                                                            .academyImage,
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: sizeHeight * 0.005,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    cachedNetworkImage(
                                                      height: sizeHeight * 0.02,
                                                      imageFit: BoxFit.fill,
                                                      width: sizeWidth * 0.05,
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? AppColors.black
                                                          : AppColors.white,
                                                      cuisineImageUrl:
                                                          academy[index]
                                                                  .sportImage
                                                                  .toString() ??
                                                              "",
                                                    ),
                                                    SizedBox(
                                                      width: sizeWidth * 0.01,
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(
                                                                      context)!
                                                                  .locale ==
                                                              'en'
                                                          ? academy[index]
                                                              .academyNameEnglish
                                                              .toString()
                                                          : academy[index]
                                                              .academyNameArabic
                                                              .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              color: MyAppState
                                                                          .mode ==
                                                                      ThemeMode
                                                                          .light
                                                                  ? AppColors
                                                                      .black
                                                                  : AppColors
                                                                      .white),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          sizeHeight * 0.008,
                                                      left: sizeWidth * 0.007),
                                                  child: Text(
                                                    academy[index]
                                                        .academyLocation!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color: MyAppState
                                                                        .mode ==
                                                                    ThemeMode
                                                                        .light
                                                                ? AppColors
                                                                    .black
                                                                : AppColors
                                                                    .white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox.shrink();
                        },
                      ),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: academy.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return academy[index].status != 'Verified'
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: sizeHeight * 0.01,
                                      horizontal: sizeWidth * 0.06),
                                  child: Container(
                                    width: sizeWidth * 0.9,
                                    decoration: BoxDecoration(
                                      color: MyAppState.mode == ThemeMode.light
                                          ? AppColors.grey200
                                          : AppColors.containerColorW12,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: DefaultTextStyle(
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? AppColors.black
                                                    : AppColors.white),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          sizeWidth * 0.02,
                                                      vertical:
                                                          sizeHeight * 0.005),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '${AppLocalizations.of(context)!.status}:',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                      ),

                                                      ///status
                                                      Text(
                                                        academy[index].status ==
                                                                'Verified'
                                                            ? AppLocalizations
                                                                    .of(
                                                                        context)!
                                                                .verified
                                                            : academy[index]
                                                                        .status ==
                                                                    'Decline'
                                                                ? AppLocalizations.of(
                                                                        context)!
                                                                    .rejected
                                                                : AppLocalizations.of(
                                                                        context)!
                                                                    .inReview,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .redAccent),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: SizedBox(
                                                      height:
                                                          sizeHeight * 0.193,
                                                      child: Carousel(
                                                        image: academy[index]
                                                            .academyImage,
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: sizeHeight * 0.005,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    cachedNetworkImage(
                                                      height: sizeHeight * 0.02,
                                                      imageFit: BoxFit.fill,
                                                      width: sizeWidth * 0.05,
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? AppColors.black
                                                          : AppColors.white,
                                                      cuisineImageUrl:
                                                          academy[index]
                                                                  .sportImage
                                                                  .toString() ??
                                                              "",
                                                    ),
                                                    SizedBox(
                                                      width: sizeWidth * 0.01,
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(
                                                                      context)!
                                                                  .locale ==
                                                              'en'
                                                          ? academy[index]
                                                              .academyNameEnglish
                                                              .toString()
                                                          : academy[index]
                                                              .academyNameArabic
                                                              .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium,
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          sizeHeight * 0.008,
                                                      left: sizeWidth * 0.007),
                                                  child: Text(
                                                    academy[index]
                                                        .academyLocation!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox.shrink();
                        },
                      ),
                      SizedBox(
                        height: sizeHeight * 0.02,
                      ),
                    ],
                  ),
                ))));
  }
}
