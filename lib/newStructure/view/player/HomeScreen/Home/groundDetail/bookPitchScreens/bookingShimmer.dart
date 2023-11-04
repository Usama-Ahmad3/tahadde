import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../constant.dart';
import '../../../../../../../drop_down_file.dart';
import '../../../../../../../localizations.dart';
import '../groundDetail.dart';

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
                  horizontal: width * 0.1,
                  vertical: height * 0.07,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FaIcon(
                      AppLocalizations.of(context)!.locale == 'en'
                          ? FontAwesomeIcons.arrowsTurnRight
                          : FontAwesomeIcons.arrowsTurnRight,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: width * 0.12,
                    ),
                    const Text(
                      'Booking a Ground',
                      style: TextStyle(fontSize: 15, color: Colors.white),
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
                      ///ground List
                      Text('Ground List',
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
                                      borderRadius: BorderRadius.circular(10),
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

                      ///select area,player
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppLocalizations.of(context)!.locale == "en"
                                ? SizedBox(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.blueGrey,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .perPlayer),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10.0),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.blueGrey,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .perVenue),
                                        ),
                                        SizedBox(
                                          width: width * 0.01,
                                        )
                                      ],
                                    ),
                                  )
                                : SizedBox(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10.0),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.blueGrey,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .perVenue),
                                        ),
                                        SizedBox(
                                          width: width * 0.01,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.blueGrey,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .perPlayer),
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              width: width * .35,
                            ),
                          ],
                        ),
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
                            SizedBox(
                              width: width * .4,
                              child: CustomDropdown(
                                  leadingIcon: false,
                                  icon: Image.asset(
                                    "assets/images/drop_down.png",
                                    height: 6,
                                    color: appThemeColor,
                                  ),
                                  dropdownButtonStyle: DropdownButtonStyle(
                                    width: width * 0.03,
                                    height: height * 0.05,
                                    elevation: 1,
                                    backgroundColor: Colors.white,
                                  ),
                                  dropdownStyle: DropdownStyle(
                                    borderRadius: BorderRadius.circular(4),
                                    elevation: 6,
                                    padding: const EdgeInsets.all(5),
                                  ),
                                  items: const [],
                                  onChange: (e, int) {},
                                  child: const Text('',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: appThemeColor))),
                            ),
                          ],
                        ),
                      ),

                      Column(
                        children: [
                          ...List.generate(1, (index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.02),
                                  child: Text(
                                    "Select mins Slot )",
                                    style: TextStyle(fontSize: height * 0.02),
                                  ),
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

                      ///Book Button
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                        child: Container(
                            height: height * 0.07,
                            width: width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.bookNowS,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        AppLocalizations.of(context)!.locale ==
                                                "en"
                                            ? 18
                                            : 22,
                                    color: Colors.black),
                              ),
                            )),
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
}
