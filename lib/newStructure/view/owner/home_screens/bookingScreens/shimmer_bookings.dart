import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';

class ShimmerBookings {
  static buildShimmer(sizeWidth, sizeHeight, context) {
    return SizedBox(
      width: sizeWidth,
      height: sizeHeight,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: PreferredSize(
              preferredSize: Size(sizeWidth, sizeHeight * 0.105),
              child: AppBar(
                title: Text(
                  AppLocalizations.of(context)!.academyBook,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
                centerTitle: true,
                backgroundColor: Colors.black,
              )),
          body: Container(
            height: sizeHeight,
            width: sizeWidth,
            decoration: BoxDecoration(
                color: MyAppState.mode == ThemeMode.light
                    ? Colors.white
                    : const Color(0xff686868),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizeWidth * .05, vertical: sizeHeight * .01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              width: sizeWidth * .4,
                              height: 5,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              width: sizeWidth * .2,
                              height: 5,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      flaxibleGap(4),
                      Container(
                        height: sizeHeight * .06,
                        width: sizeHeight * .07,
                        decoration: BoxDecoration(
                          color: Colors.teal.shade100,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/closed.png',
                              fit: BoxFit.cover,
                              height: sizeHeight * .03,
                            ),
                            Text(
                              AppLocalizations.of(context)!.closed,
                              style: const TextStyle(
                                  fontSize: 8, color: Color(0XFF9B9B9B)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Material(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0XFF25A163).withOpacity(.18),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                      //border: Border.all(width: 3,color: Color(0XFFE0E0E0),style: BorderStyle.solid)
                    ),
                    constraints: BoxConstraints(maxHeight: sizeHeight * .06),
                    child: TabBar(
                      labelColor: const Color(0XFF032040),
                      //controller: tabController,
                      labelStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins"),
                      unselectedLabelColor: const Color(0XFFADADAD),
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorPadding: const EdgeInsets.only(),
                      indicatorColor: const Color(0XFF032040),
                      indicatorWeight: 4,

                      tabs: [
                        Tab(
                            child: Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Container(
                            width: sizeWidth * .4,
                            alignment: Alignment.bottomCenter,
                            child: Text(AppLocalizations.of(context)!.booking,
                                style: const TextStyle(
                                    //color: Color(0XFF032040),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins")),
                          ),
                        )),
                        Tab(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Container(
                              width: sizeWidth * .4,
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                AppLocalizations.of(context)!.manageSlots,
                                style: const TextStyle(
                                    // color: Color(0XFF032040),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [buildBodySimmer(), buildBodySimmer()],
                  ),
                ),
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }

  static buildBodySimmer() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ListView.builder(
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: shimmerCard(),
        ),
        itemCount: 5,
      ),
    );
  }

  static shimmerCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: 80,
        decoration: const BoxDecoration(
          color: Color(0XFFF7F7F7),
          borderRadius: BorderRadius.all(Radius.circular(5.0) //

              ),
        ),
        child: Row(
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
            flaxibleGap(2),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: Container(
                    height: 5,
                    width: 250,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0) //

                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: Container(
                    height: 5,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0) //

                          ),
                    ),
                  ),
                ),
              ],
            ),
            flaxibleGap(14),
          ],
        ),
      ),
    );
  }
}
