import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../common_widgets/grediant_text.dart';
import '../../../../../../localizations.dart';
import 'carousel.dart';
import 'facilities.dart';

class GroundShimmer {
  static buildShemmer(width, height, context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade100,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            centerTitle: false,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: false,
                titlePadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                background: Shimmer.fromColors(
                    baseColor: Colors.grey.shade100,
                    highlightColor: Colors.grey.shade300,
                    child: const Carousel())),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.only(
                      //     topRight: Radius.circular(20),
                      //     topLeft: Radius.circular(20))
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: height * 0.024, vertical: height * 0.033),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade100,
                        highlightColor: Colors.grey.shade300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///titleName
                            GradientText(
                              "      ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.026,
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  decoration: TextDecoration.none),
                              gradient: LinearGradient(colors: [
                                Colors.green.shade100,
                                Colors.lightGreenAccent.shade200,
                                Colors.lightGreenAccent.shade400,
                                Colors.lightGreenAccent.shade700,
                              ]),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),

                            ///description
                            Text(
                              AppLocalizations.of(context)!.descriptionS,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            const ReadMoreText(
                              "    ",
                              trimLength: 2,
                              trimMode: TrimMode.Line,
                              lessStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              moreStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              trimCollapsedText: 'See More',
                              trimExpandedText: 'See Less',
                            ),
                            SizedBox(
                              height: height * 0.025,
                            ),

                            ///GroundList
                            Text(AppLocalizations.of(context)!.academyList,
                                style: TextStyle(fontSize: height * 0.03)),
                            ...List.generate(
                                3,
                                (index) => Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.01,
                                          vertical: height * 0.01),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                spreadRadius: 1,
                                                offset: Offset(0, 1),
                                                blurStyle: BlurStyle.outer,
                                              )
                                            ]),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: width * 0.01,
                                            ),
                                            Container(
                                              height: height * 0.05,
                                              width: width * 0.1,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.03,
                                            ),
                                            const Text(''),
                                            SizedBox(
                                              width: width * 0.3,
                                            ),
                                            Checkbox(
                                                shape: const CircleBorder(),
                                                activeColor: Colors.greenAccent,
                                                value: true,
                                                onChanged: (onChanged) {}),
                                          ],
                                        ),
                                      ),
                                    )),

                            ///facilities
                            const Facilities(),

                            ///location
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: height * 0.008),
                              child: Text(
                                AppLocalizations.of(context)!.location,
                                style: TextStyle(fontSize: height * 0.03),
                              ),
                            ),
                            Card(
                              elevation: 3,
                              child: ExpansionTile(
                                title: const ReadMoreText(
                                  "    ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  trimLength: 2,
                                  trimMode: TrimMode.Line,
                                  lessStyle: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.bold),
                                  moreStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  trimCollapsedText: 'More',
                                  trimExpandedText: '.Less',
                                ),
                                tilePadding: EdgeInsets.symmetric(
                                    vertical: height * 0.02,
                                    horizontal: width * 0.02),
                                trailing: const Icon(Icons.location_searching),
                                children: [
                                  Card(
                                    color: Colors.white70,
                                    child: ListTile(
                                      onTap: () {},
                                      title: const Center(
                                          child: Text('Get Your Location')),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            ///popularFeature
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: height * 0.013),
                              child: Text(
                                'Our Popular Features',
                                style: TextStyle(fontSize: height * 0.03),
                              ),
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                ...List.generate(
                                    5,
                                    (index) => Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: height * .008,
                                              horizontal: width * 0.008),
                                          child: Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: height * 0.0065,
                                                backgroundColor: Colors.grey,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.02),
                                                child: Text(
                                                  '',
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: height * 0.02),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  textWidthBasis:
                                                      TextWidthBasis.parent,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                              ],
                            ),

                            ///BookButton
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.01,
                                  vertical: height * 0.01),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(10)),
                                  height: height * 0.06,
                                  child: const Center(child: Text('Book Now')),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
