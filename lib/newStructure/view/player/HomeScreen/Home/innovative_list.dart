import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/modelClass/innovative_hub.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/groundDetail.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/viewMoreBookPitch/view_more_book_academy.dart';
import 'package:flutter_tahaddi/newStructure/view/player/loginSignup/login.dart';

import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../utils/utils.dart';
import 'groundDetail/carousel.dart';

class InnovativeList extends StatefulWidget {
  List<InnovativeHub> innovativeDetail;
  String text;
  bool empty;
  bool tagForView;

  InnovativeList(
      {super.key,
      this.tagForView = true,
      required this.innovativeDetail,
      required this.text,
      required this.empty});

  @override
  State<InnovativeList> createState() => _InnovativeListState();
}

class _InnovativeListState extends State<InnovativeList> {
  onWillPop() {
    return showDialog(
        context: context,
        builder: (BuildContext cntext) {
          return AlertDialog(
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            content: Text(
              AppLocalizations.of(context)!.toReserve,
              style: TextStyle(
                  color: AppColors.black, fontWeight: FontWeight.normal),
            ),
            actions: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel,
                    style: const TextStyle(color: AppColors.appThemeColor)),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.login,
                  style: const TextStyle(color: AppColors.appThemeColor),
                ),
                onPressed: () {
                  navigateToLogin();
                },
              )
            ],
          );
        });
  }

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
      height: widget.innovativeDetail != null
          ? widget.innovativeDetail.length <= 2
              ? 720 * fem
              : null
          : null,
      // margin: EdgeInsets.only(top: 24 * fem),
      padding: EdgeInsets.fromLTRB(24 * fem, 24 * fem, 24 * fem, 15 * fem),
      decoration: BoxDecoration(
        color: mode == ThemeMode.light
            ? const Color(0xffffffff)
            : const Color(0xff373737),
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
                            bool details = false;
                            navigateToViewMoreAcademy(details);
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
                            bool academy = false;
                            navigateToViewMoreAcademy(academy);
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
              widget.empty == false ? widget.innovativeDetail.length : 1,
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
                                AppLocalizations.of(context)!.noEvents,
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
                              widget.innovativeDetail[index].innovativehubId ??
                                  0,
                          "Academy_NameEnglish":
                              widget.innovativeDetail[index].nameEnglish,
                          "Academy_NameArabic":
                              widget.innovativeDetail[index].nameArabic,
                          "descriptionEnglish":
                              widget.innovativeDetail[index].descriptionEnglish,
                          "descriptionArabic":
                              widget.innovativeDetail[index].descriptionArabic,
                          "gameplaySlug":
                              widget.innovativeDetail[index].sportSlug,
                          "academy_image": [
                            widget.innovativeDetail[index].image
                          ],
                          'latitude': widget.innovativeDetail[index].latitude,
                          'longitude': widget.innovativeDetail[index].longitude,
                          'Academy_Location':
                              widget.innovativeDetail[index].location,
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
                                : AppColors.containerColorW12,
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
                                  child: AbsorbPointer(
                                    child: Carousel(
                                      rating: false,
                                      image: [
                                        widget.innovativeDetail[index].image
                                      ],
                                      storyView: false,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0 * fem, bottom: 2 * fem),
                                child: Text(
                                  AppLocalizations.of(context)!.locale == 'en'
                                      ? widget
                                          .innovativeDetail[index].nameEnglish
                                          .toString()
                                      : widget
                                          .innovativeDetail[index].nameArabic
                                          .toString(),
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
                                    "${widget.innovativeDetail[0].location!.length > 30 ? widget.innovativeDetail[0].location.toString().substring(0, 35) : widget.innovativeDetail[0].location} ...",
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 13 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.3846153846 * ffem / fem,
                                      color: MyAppState.mode == ThemeMode.light
                                          ? AppColors.black
                                          : AppColors.white,
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
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GroundDetail(
            detail: detail,
            navigateFromInovative: true,
          ),
        ));
    // Navigator.pushNamed(context, RouteNames.groundDetail, arguments: detail);
  }

  void navigateToViewMoreAcademy(bool detail) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ViewMoreBookAcademyInnovativeScreen(
                  academyInnovative: detail,
                )));
  }

  void navigateToLogin() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => LoginScreen(message: 'message')));
  }
}
