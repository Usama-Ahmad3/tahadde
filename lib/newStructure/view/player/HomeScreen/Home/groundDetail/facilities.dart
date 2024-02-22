import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/constant.dart';
import 'package:flutter_tahaddi/homeFile/utility.dart';
import 'package:flutter_tahaddi/localizations.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/modelClass/Facilities.dart';
import 'package:flutter_tahaddi/network/network_calls.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';

class FacilitiesList extends StatefulWidget {
  List<int> facility;
  FacilitiesList({super.key, required this.facility});
  @override
  State<FacilitiesList> createState() => _FacilitiesListState();
}

class _FacilitiesListState extends State<FacilitiesList> {
  List<Facilities> facilities = [];
  bool loading = true;
  getFacility() async {
    await NetworkCalls().facilityList(
        onSuccess: (detail) {
          for (int i = 0; i < detail.length; i++) {
            facilities.add(Facilities.fromJson(detail[i]));
          }
          print('jjaja$facilities');
          setState(() {
            loading = false;
          });
        },
        onFailure: (detail) {},
        tokenExpire: () {});
  }

  @override
  void initState() {
    getFacility();
    print('kkkkkkkk');
    print(widget.facility);
    super.initState();
  }

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
            fontSize: height*0.025
              ),
        ),
        Wrap(
          children: [
            ...List.generate(facilities.length, (index) {
              return widget.facility.contains(facilities[index].id)
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: height * .009),
                      child: SizedBox(
                        width: width * 0.41,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: height * 0.015,
                              backgroundColor: Colors.transparent,
                              child: cachedNetworkImage(
                                  height: height * .065,
                                  width: width * .15,
                                  cuisineImageUrl:
                                      facilities[index].facilityImage ?? "",
                                  imageFit: BoxFit.contain,
                                  color: MyAppState.mode == ThemeMode.light
                                      ? AppColors.black
                                      : AppColors.white),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.015),
                              child: Text(
                                AppLocalizations.of(context)!.locale == 'en'
                                    ? facilities[index].facilityName!.length >
                                            12
                                        ? '${facilities[index].facilityName!.substring(0, 12)}..'
                                        : facilities[index]
                                            .facilityName
                                            .toString()
                                    : facilities[index]
                                            .facilityArabicName
                                            .toString() ??
                                        "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.normal,
                                        fontSize: height*0.015,
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
                    )
                  : const SizedBox.shrink();
            })
          ],
        ),
      ],
    );
  }
}
// Image.asset(
// widget.facility[index] == "bathroom"
// ? facilityImageS[0]
//     : widget.facility[index] == 'bibs'
// ? facilityImageS[1]
//     : widget.facility[index] ==
// 'car-parking'
// ? facilityImageS[2]
//     : widget.facility[index] ==
// 'locker'
// ? facilityImageS[3]
//     : widget.facility[index] ==
// 'metro_station'
// ? facilityImageS[4]
//     : widget.facility[
// index] ==
// 'refree'
// ? facilityImageS[5]
//     : widget.facility[
// index] ==
// 'free_parking'
// ? facilityImageS[
// 6]
//     : widget.facility[
// index] ==
// 'masjid'
// ? facilityImageS[
// 7]
//     : widget.facility[
// index] ==
// 'market'
// ? facilityImageS[
// 8]
//     : '' ??
// "",
// height: height * .065,
// width: width * .15,
// fit: BoxFit.contain,
// color: MyAppState.mode == ThemeMode.light
// ? AppColors.black
// : AppColors.white),
