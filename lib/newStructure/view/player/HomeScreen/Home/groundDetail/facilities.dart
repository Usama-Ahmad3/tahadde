import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/groundDetail.dart';

import '../../../../../../homeFile/utility.dart';
import '../../../../../../localizations.dart';
import '../../../../../../main.dart';
import '../../../../../app_colors/app_colors.dart';

class Facilities extends StatelessWidget {
  const Facilities({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.facilitiesProvided,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: MyAppState.mode == ThemeMode.light
                    ? AppColors.black
                    : AppColors.white,
              ),
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
                        width: width * 0.41,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: height * 0.024,
                              backgroundColor: Colors.transparent,
                              child: cachedNetworkImage(
                                  height: height * .065,
                                  width: width * .15,
                                  cuisineImageUrl: GroundDetailState
                                          .privateVenueDetail
                                          .venueDetails
                                          ?.facilities![index]
                                          ?.image ??
                                      "",
                                  imageFit: BoxFit.contain,
                                  color: MyAppState.mode == ThemeMode.light
                                      ? AppColors.black
                                      : AppColors.white),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.normal,
                                        color:
                                            MyAppState.mode == ThemeMode.light
                                                ? AppColors.black
                                                : AppColors.white,
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
