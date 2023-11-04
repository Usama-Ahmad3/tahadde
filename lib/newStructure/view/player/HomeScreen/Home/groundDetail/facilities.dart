import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/constant.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/groundDetail.dart';

import '../../../../../../homeFile/utility.dart';
import '../../../../../../localizations.dart';
import '../../../../../../main.dart';
import '../../../../../app_colors/app_colors.dart';

class Facilities extends StatelessWidget {
  List facility;
  Facilities({super.key, required this.facility});

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
                facility.isEmpty ? 5 : facility.length,
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
                              child: Image.asset(
                                  facility[index] == 'bathroom'
                                      ? facilityImageS[0]
                                      : facility[index] == 'bibs'
                                          ? facilityImageS[1]
                                          : facility[index] == 'car-parking'
                                              ? facilityImageS[3]
                                              : facility[index] == 'locker'
                                                  ? facilityImageS[4]
                                                  : facility[index] ==
                                                          'train-station'
                                                      ? facilityImageS[5]
                                                      : facility[index] ==
                                                              'refree'
                                                          ? facilityImageS[6]
                                                          : facility[index] ==
                                                                  'parking-free'
                                                              ? facilityImageS[
                                                                  7]
                                                              : facility[index] ==
                                                                      'masjid'
                                                                  ? facilityImageS[
                                                                      8]
                                                                  : facility[index] ==
                                                                          'market'
                                                                      ? facilityImageS[
                                                                          9]
                                                                      : '' ??
                                                                          "",
                                  height: height * .065,
                                  width: width * .15,
                                  fit: BoxFit.contain,
                                  color: MyAppState.mode == ThemeMode.light
                                      ? AppColors.black
                                      : AppColors.white),
                              // cachedNetworkImage(
                              //     height: height * .065,
                              //     width: width * .15,
                              //     cuisineImageUrl: facilityImageS[index] ?? "",
                              //     imageFit: BoxFit.contain,
                              //     color: MyAppState.mode == ThemeMode.light
                              //         ? AppColors.black
                              //         : AppColors.white),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.015),
                              child: Text(
                                facility[index] ?? "",
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
