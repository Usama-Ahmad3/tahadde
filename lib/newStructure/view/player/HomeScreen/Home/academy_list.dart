import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/viewMoreBookPitch/view_more_book_academy.dart';
import 'package:flutter_tahaddi/newStructure/view/player/loginSignup/login.dart';

import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../utils/utils.dart';
import 'groundDetail/carousel.dart';

class AcademyList extends StatefulWidget {
  var academyDetail;
  bool tagForView;
  bool empty;
  bool? searchflag;
  String text;

  AcademyList(
      {super.key,
      this.searchflag = false,
      required this.text,
      required this.academyDetail,
      this.tagForView = true,
      this.empty = false});

  @override
  State<AcademyList> createState() => _AcademyListState();
}

class _AcademyListState extends State<AcademyList> {
  bool _auth = false;
  checkAuth() async {
    _auth = (await checkAuthorizaton())!;
  }

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
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.login),
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
    checkAuth();
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
                            var details = {"bool": false};
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
                            var details = {"bool": false};
                            navigateToViewMoreAcademy(details);
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
                                'no events available',
                                // AppLocalizations.of(context)!.noAcademy,
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
                        if (_auth) {
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
                            'longitude': widget.academyDetail[index]
                                ['longitude'],
                            'Academy_Location': widget.academyDetail[index]
                                ['Academy_Location'],
                          };
                          navigateToGroundDetail(detail);
                        } else {
                          onWillPop();
                        }
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
                                  child: Carousel(
                                    image: widget.academyDetail[index]
                                        ['academy_image'],
                                    storyView: false,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 4.0 * fem, bottom: 2 * fem),
                                child: Text(
                                  AppLocalizations.of(context)!.locale == 'en'
                                      ? widget.academyDetail[index]
                                          ["Academy_NameEnglish"]
                                      : widget.academyDetail[index]
                                          ["Academy_NameArabic"],
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
                                    "${widget.academyDetail[0]['Academy_Location'].toString().substring(0, 35)} ...",
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
    Navigator.pushNamed(context, RouteNames.groundDetail, arguments: detail);
  }

  void navigateToViewMoreAcademy(Map detail) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ViewMoreBookAcademyScreen(pitchType: detail)));
  }

  void navigateToLogin() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => LoginScreen(message: 'message')));
    // Navigator.pushNamed(context, RouteNames.login);
  }
}
