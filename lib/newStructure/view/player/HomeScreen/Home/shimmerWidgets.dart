import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/sportList.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/vanueList.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../constant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../utils.dart';

class ShimmerWidgets {
  Widget buildShimmer(double size, context, bookPitchData) {
    return Scaffold(
      body: Shimmer.fromColors(
        highlightColor: Colors.grey.shade100,
        baseColor: Colors.grey.shade300,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///top widget
                Padding(
                  padding: EdgeInsets.only(
                      top: 50 * size,
                      bottom: 36 * size,
                      left: 34 * size,
                      right: 63 * size),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.tahaddi,
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 20 * size,
                              fontWeight: FontWeight.w600,
                              height: 1.25 * size / size,
                              letterSpacing: -0.2 * size,
                              color: const Color(0xffffffff),
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.morning,
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 13 * size,
                              fontWeight: FontWeight.w400,
                              height: 1.3846153846 * size / size,
                              color: const Color(0xff999999),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 36 * size,
                        height: 36 * size,
                        child: Image.asset(
                          'assets/light-design/images/icon-fT7.png',
                          width: 36 * size,
                          height: 36 * size,
                        ),
                      ),
                    ],
                  ),
                ),

                ///location
                Container(
                  margin: EdgeInsets.only(
                      left: 24 * size, right: 67 * size, bottom: 24 * size),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12 * size,
                    vertical: 16 * size,
                  ),
                  width: double.infinity,
                  height: 48 * size,
                  decoration: BoxDecoration(
                    color: const Color(0xff1e1e1e),
                    borderRadius: BorderRadius.circular(16 * size),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.white,
                      ),
                      enabled: false,
                      label: Text(
                        'City',
                        style: const TextStyle(color: Colors.white),
                      ),
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 18 * size,
                      ),
                    ),
                  ),
                ),
                gameWidgetShimmer(size)
              ],
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: VanueList(bookPitchData: []))
          ],
        ),
      ),
    );
  }

  Widget gameWidgetShimmer(double sizeWidth) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Material(
          elevation: 5,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: Container(
              height: sizeWidth * 75,
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          child: Chip(
                            avatar: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.black12,
                            ),
                            backgroundColor: Colors.white10,
                            elevation: 2,
                            padding: EdgeInsets.all(10),
                            label: Text('          '),
                          ),
                        ),
                      ],
                    );
                  })),
            ),
          ),
        ));
  }
}
