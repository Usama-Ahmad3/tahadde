import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/homeFile/utility.dart';
import 'package:flutter_tahaddi/localizations.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/bookingScreens/booking_screen/booking_summary_list.dart';

class BookingWidgetList extends StatelessWidget {
  var academyDetail;
  BookingWidgetList({
    super.key,
    required this.academyDetail,
  });

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap:
          // academyDetail[index].isDecline! ?
          () {
        Map detail = {
          "id": academyDetail['academy_id'],
        };
        navigateToBookings(
          detail,
          context,
        );
        // navigateToManageSlotsDetail(pitchDetail[index]);
      },
      // : () => showMessage(
      //   "Sorry, you can not edit verified and in-review Academy"),
      child: Padding(
        padding: EdgeInsets.only(
            left: sizeWidth * .059,
            right: sizeWidth * .059,
            top: sizeHeight * .02),
        child: Container(
          height: sizeHeight * .1,
          width: sizeWidth,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
            color: MyAppState.mode == ThemeMode.light
                ? AppColors.grey200
                : AppColors.containerColorW12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(sizeHeight * .007),
                child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0) //
                          ),
                    ),
                    child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        child: cachedNetworkImage(
                            height: sizeHeight * .08,
                            width: sizeWidth * .15,
                            cuisineImageUrl: academyDetail['academy_image']
                                [0]))),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  flaxibleGap(1),
                  Text(
                      AppLocalizations.of(context)!.locale == 'en'
                          ? "${academyDetail['Academy_NameEnglish']}"
                          : "${academyDetail['Academy_NameArabic']}",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: MyAppState.mode == ThemeMode.light
                                ? AppColors.themeColor
                                : AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Poppins",
                          )),
                  SizedBox(
                    width: sizeWidth * .7,
                    child: Text(" ${academyDetail['Academy_Location']}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: MyAppState.mode == ThemeMode.light
                                  ? const Color(0XFF646464)
                                  : AppColors.grey,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                            )),
                  ),
                  flaxibleGap(1),
                ],
              ),
              flaxibleGap(4),
            ],
          ),
        ),
      ),
    );
  }

  navigateToBookings(
    detail,
    context,
  ) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingSummaryList(
            detail: detail,
          ),
        ));
  }
}
