import 'package:flutter/material.dart';

import '../../../../../../homeFile/utility.dart';
import '../../../../../../localizations.dart';
import '../../../../../../main.dart';
import '../../../../../../modelClass/my_venue_list_model_class.dart';
import '../../../../../app_colors/app_colors.dart';
import '../../../../player/HomeScreen/widgets/app_bar.dart';

class ViewMoreVenueScreen extends StatelessWidget {
  final List<MyVenueModelClass> venues;
  const ViewMoreVenueScreen({Key? key, required this.venues}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.black,
        appBar: appBarWidget(sizeWidth, sizeHeight, context,
            AppLocalizations.of(context)!.academy, true),
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
                        itemCount: venues.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            MyAppState.mode == ThemeMode.light
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
                                              horizontal: sizeWidth * 0.02,
                                              vertical: sizeHeight * 0.005),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${AppLocalizations.of(context)!.status}:',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: AppColors.black),
                                              ),
                                              Text(
                                                venues[index].isVerified!
                                                    ? AppLocalizations.of(
                                                            context)!
                                                        .verified
                                                    : venues[index].isDecline!
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
                                              BorderRadius.circular(12),
                                          child: cachedNetworkImage(
                                            height: sizeHeight * 0.193,
                                            imageFit: BoxFit.fill,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            cuisineImageUrl: venues[index]
                                                    .pitchImage
                                                    .toString() ??
                                                "",
                                          ),
                                        ),
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
                                              cuisineImageUrl: venues[index]
                                                      .sportImage
                                                      .toString() ??
                                                  "",
                                            ),
                                            SizedBox(
                                              width: sizeWidth * 0.01,
                                            ),
                                            Text(
                                              venues[index]
                                                  .venueName
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: AppColors.black),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: sizeHeight * 0.008,
                                              left: sizeWidth * 0.007),
                                          child: Text(
                                            venues[index].location!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: AppColors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: sizeHeight * 0.02,
                      ),
                    ],
                  ),
                ))));
  }
}
