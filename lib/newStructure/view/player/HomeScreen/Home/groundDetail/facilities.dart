import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/groundDetail.dart';

import '../../../../../../homeFile/utility.dart';
import '../../../../../../localizations.dart';

class Facilities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.facilitiesProvided,
          style: TextStyle(fontSize: height * 0.03),
        ),
        Wrap(
          children: [
            ...List.generate(
                GroundDetailState.privateVenueDetail.venueDetails != null
                    ? GroundDetailState
                        .privateVenueDetail.venueDetails!.facilities!.length
                    : 5,
                (index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: height * .008),
                      child: SizedBox(
                        width: width * 0.44,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: height * 0.028,
                              backgroundColor: Colors.transparent,
                              child: cachedNetworkImage(
                                  height: height * .07,
                                  width: width * .18,
                                  cuisineImageUrl: GroundDetailState
                                          .privateVenueDetail
                                          .venueDetails
                                          ?.facilities![index]
                                          ?.image ??
                                      "",
                                  imageFit: BoxFit.contain),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.015),
                              child: Text(
                                GroundDetailState
                                        .privateVenueDetail
                                        .venueDetails
                                        ?.facilities![index]
                                        ?.name ??
                                    "",
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis),
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                textWidthBasis: TextWidthBasis.parent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
          ],
        ),
      ],
    );
  }
}
