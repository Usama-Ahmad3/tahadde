import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../constant.dart';
import '../../../../../../../drop_down_file.dart';
import '../../../../../../../localizations.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';

class BookingShimmer {
  static bookingShimmer(width, height, context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Top Widget
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.06,
                  vertical: height * 0.07,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.pop(context);
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.appThemeColor),
                          height: height * 0.032,
                          child: Image.asset(
                            'assets/images/back.png',
                            color: AppColors.white,
                            isAntiAlias: true,
                          )),
                    ),
                    SizedBox(
                      width: width * 0.12,
                    ),
                    Text(
                      AppLocalizations.of(context)!.bookingGround,
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),

            ///Date Widget
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Padding(
                padding:
                    EdgeInsets.only(left: width * 0.022, right: width * 0.022),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 0.018),
                        child: Container(
                          width: width,
                          height: height * 0.08,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.032,
            ),

            ///down white Container
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(height * 0.03),
                      topRight: Radius.circular(height * 0.03))),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03, vertical: height * 0.02),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          ...List.generate(1, (index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                Wrap(
                                  children: [
                                    ...List.generate(5, (slotIndex) {
                                      return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.02,
                                              vertical: height * 0.01),
                                          child: Badge(
                                            label: const Text(
                                              '0',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            alignment: Alignment.topRight,
                                            backgroundColor: Colors.blueGrey,
                                            child: Container(
                                              height: height * 0.06,
                                              width: width * 0.43,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    '',
                                                    style: TextStyle(
                                                        fontSize:
                                                            height * 0.02),
                                                  ),
                                                  Container(
                                                    height: height * 0.022,
                                                    width: width * 0.042,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.blueGrey,
                                                            style: BorderStyle
                                                                .solid,
                                                            width: 1),
                                                        color:
                                                            Colors.transparent,
                                                        shape: BoxShape.circle),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ));
                                    })
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                Wrap(
                                  children: [
                                    ...List.generate(5, (slotIndex) {
                                      return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.02,
                                              vertical: height * 0.01),
                                          child: Badge(
                                            label: const Text(
                                              '0',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            alignment: Alignment.topRight,
                                            backgroundColor: Colors.blueGrey,
                                            child: Container(
                                              height: height * 0.06,
                                              width: width * 0.43,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    '',
                                                    style: TextStyle(
                                                        fontSize:
                                                            height * 0.02),
                                                  ),
                                                  Container(
                                                    height: height * 0.022,
                                                    width: width * 0.042,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.blueGrey,
                                                            style: BorderStyle
                                                                .solid,
                                                            width: 1),
                                                        color:
                                                            Colors.transparent,
                                                        shape: BoxShape.circle),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ));
                                    })
                                  ],
                                )
                              ],
                            );
                          })
                        ],
                      ),

                      ///select area,player
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * .04, vertical: height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.selectnumber,
                              style: TextStyle(
                                  color: appThemeColor,
                                  fontSize: height * 0.017),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static sessionShimmer(width, height, context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(height * 0.03),
              topRight: Radius.circular(height * 0.03))),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.02),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  ...List.generate(1, (index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Wrap(
                          children: [
                            ...List.generate(5, (slotIndex) {
                              return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.02,
                                      vertical: height * 0.01),
                                  child: Badge(
                                    label: const Text(
                                      '0',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    alignment: Alignment.topRight,
                                    backgroundColor: Colors.blueGrey,
                                    child: Container(
                                      height: height * 0.06,
                                      width: width * 0.43,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            '',
                                            style: TextStyle(
                                                fontSize: height * 0.02),
                                          ),
                                          Container(
                                            height: height * 0.022,
                                            width: width * 0.042,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blueGrey,
                                                    style: BorderStyle.solid,
                                                    width: 1),
                                                color: Colors.transparent,
                                                shape: BoxShape.circle),
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                            })
                          ],
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Wrap(
                          children: [
                            ...List.generate(5, (slotIndex) {
                              return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.02,
                                      vertical: height * 0.01),
                                  child: Badge(
                                    label: const Text(
                                      '0',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    alignment: Alignment.topRight,
                                    backgroundColor: Colors.blueGrey,
                                    child: Container(
                                      height: height * 0.06,
                                      width: width * 0.43,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            '',
                                            style: TextStyle(
                                                fontSize: height * 0.02),
                                          ),
                                          Container(
                                            height: height * 0.022,
                                            width: width * 0.042,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blueGrey,
                                                    style: BorderStyle.solid,
                                                    width: 1),
                                                color: Colors.transparent,
                                                shape: BoxShape.circle),
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                            })
                          ],
                        )
                      ],
                    );
                  })
                ],
              ),

              ///select area,player
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .04, vertical: height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.selectnumber,
                      style: TextStyle(
                          color: appThemeColor, fontSize: height * 0.017),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
