import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/viewMoreBookPitch/viewMoreBookPitch.dart';

import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../utils/utils.dart';

class VanueList extends StatefulWidget {
  var academyDetail;
  bool tagForView;
  bool empty;
  bool? searchflag;
  String text;

  VanueList(
      {super.key,
      this.searchflag = false,
      required this.text,
      required this.academyDetail,
      this.tagForView = true,
      this.empty = false});

  @override
  State<VanueList> createState() => _VanueListState();
}

class _VanueListState extends State<VanueList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mode = MyAppState.mode;
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: widget.academyDetail != null
          ? widget.academyDetail.length <= 2
              ? 720 * fem
              : null
          : null,
      // margin: EdgeInsets.only(top: 24 * fem),
      padding: EdgeInsets.fromLTRB(24 * fem, 24 * fem, 24 * fem, 15 * fem),
      decoration: BoxDecoration(
        color: mode == ThemeMode.light
            ? const Color(0xffffffff)
            : const Color(0xff5A5C60),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24 * fem),
            topRight: Radius.circular(24 * fem)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            widget.tagForView
                ? Container(
                    margin: EdgeInsets.only(bottom: 16 * fem),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            var details = {"bool": false};
                            navigateToViewMorePitch(details);
                          },
                          child: Text(
                            widget.text,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    height: 1.25 * ffem / fem,
                                    letterSpacing: -0.2 * fem,
                                    color: mode == ThemeMode.light
                                        ? const Color(0xff050505)
                                        : const Color(0xffffffff)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            var details = {"bool": false};
                            navigateToViewMorePitch(details);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.viewAll,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontWeight: FontWeight.w400,
                                  height: 1.3846153846 * ffem / fem,
                                  color: mode == ThemeMode.light
                                      ? AppColors.darkTheme
                                      : Colors.white70,
                                ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            ...List.generate(
              widget.empty == false ? widget.academyDetail.length : 1,
              (index) => widget.empty
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 16 * fem),
                      child: Container(
                        padding: EdgeInsets.only(bottom: 16 * fem),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.75,
                        decoration: BoxDecoration(
                          color: mode == ThemeMode.light
                              ? const Color(0xffffffff)
                              : const Color(0xff373737),
                          borderRadius: BorderRadius.circular(15 * fem),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x0f050818),
                              offset: Offset(10 * fem, 40 * fem),
                              blurRadius: 30 * fem,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                AppLocalizations.of(context)!.noAcademy,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: MyAppState.mode == ThemeMode.light
                                          ? AppColors.black
                                          : AppColors.white,
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            )
                          ],
                        ),
                      ))
                  : InkWell(
                      onTap: () {
                        dynamic detail = {
                          "academy_id":
                              widget.academyDetail[index]["academy_id"] ?? 0,
                          "Academy_NameEnglish": widget.academyDetail[index]
                              ["Academy_NameEnglish"],
                          "Academy_NameArabic": widget.academyDetail[index]
                              ["Academy_NameArabic"],
                          "descriptionEnglish": widget.academyDetail[index]
                              ["descriptionEnglish"],
                          "descriptionArabic": widget.academyDetail[index]
                              ["descriptionArabic"],
                          "facilitySlug": widget.academyDetail[index]
                              ["facilitySlug"],
                          "gameplaySlug": widget.academyDetail[index]
                              ["gameplaySlug"],
                          "academy_image": widget.academyDetail[index]
                              ["academy_image"],
                          'latitude': widget.academyDetail[index]['latitude'],
                          'longitude': widget.academyDetail[index]['longitude'],
                          'Academy_Location': widget.academyDetail[index]
                              ['Academy_Location']
                        };
                        navigateToGroundDetail(detail);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 16 * fem),
                        child: Container(
                          padding: EdgeInsets.only(bottom: 16 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: mode == ThemeMode.light
                                ? const Color(0xffffffff)
                                : const Color(0xff373737),
                            borderRadius: BorderRadius.circular(15 * fem),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x0f050818),
                                offset: Offset(10 * fem, 40 * fem),
                                blurRadius: 30 * fem,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 12 * fem),
                                width: 327 * fem,
                                height: 145 * fem,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15 * fem),
                                    topRight: Radius.circular(15 * fem),
                                  ),
                                  child: cachedNetworkImage(
                                    cuisineImageUrl: widget
                                            .academyDetail[index]
                                                ["academy_image"]
                                            .isNotEmpty
                                        ? widget.academyDetail[index]
                                            ["academy_image"][0]
                                        : Container(),
                                    height: 150,
                                    width: fem,
                                    imageFit: BoxFit.fitWidth,
                                    errorFit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 4.0 * fem, bottom: 2 * fem),
                                child: Text(
                                  widget.academyDetail[index]
                                      ["Academy_NameEnglish"],
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 20 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.25 * ffem / fem,
                                    letterSpacing: -0.2 * fem,
                                    color: mode == ThemeMode.light
                                        ? const Color(0xff050505)
                                        : const Color(0xffffffff),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: 10 * fem, left: 4 * fem),
                                    width: 24 * fem,
                                    height: 24 * fem,
                                    child: Image.asset(
                                      'assets/images/icon-kVX.png',
                                      width: 24 * fem,
                                      height: 24 * fem,
                                    ),
                                  ),
                                  Text(
                                    "${widget.academyDetail[0]['Academy_Location'].toString().substring(0, 40)} ...",
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 13 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.3846153846 * ffem / fem,
                                      color: AppColors.darkTheme,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
            SizedBox(
              height: 10 * fem,
            )
          ],
        ),
      ),
    );
  }

  void navigateToGroundDetail(Map detail) {
    Navigator.pushNamed(context, RouteNames.groundDetail, arguments: detail);
  }

  void navigateToViewMorePitch(Map detail) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ViewMoreBookPitchScreen(pitchType: detail)));
  }
}
