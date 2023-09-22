import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/vanueList.dart';
import 'package:shimmer/shimmer.dart';

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
                ///location
                Container(
                  margin: EdgeInsets.only(
                      left: 24 * size,
                      right: 24 * size,
                      bottom: 24 * size,
                      top: 24 * size),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12 * size,
                    vertical: 16 * size,
                  ),
                  width: double.infinity,
                  height: 150 * size,
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
              ],
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                    height: 500 * size, child: VanueList(bookPitchData: [])))
          ],
        ),
      ),
    );
  }

  Widget gameWidgetShimmer(double sizeWidth) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: Container(
            height: sizeWidth * 75,
            width: double.infinity,
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
        ));
  }
}
