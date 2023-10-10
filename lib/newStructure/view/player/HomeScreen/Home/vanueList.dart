import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/viewMoreBookPitch/viewMoreBookPitch.dart';

import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../utils/utils.dart';

class VanueList extends StatefulWidget {
  var bookPitchData;
  bool tagForView;
  bool empty;
  bool? searchflag;

  VanueList(
      {super.key,
      this.searchflag = false,
      required this.bookPitchData,
      this.tagForView = true,
      this.empty = false});

  @override
  State<VanueList> createState() => _VanueListState();
}

class _VanueListState extends State<VanueList> {
  @override
  Widget build(BuildContext context) {
    var mode = MyAppState.mode;
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: widget.tagForView
          ? widget.searchflag!
              ? 450 * fem
              : 480 * fem
          : MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 24 * fem),
      padding: EdgeInsets.fromLTRB(24 * fem, 24 * fem, 24 * fem, 0),
      decoration: BoxDecoration(
        color: mode == ThemeMode.light
            ? const Color(0xffffffff)
            : const Color(0xff5A5C60),
        borderRadius: BorderRadius.circular(24 * fem),
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
                            AppLocalizations.of(context)!.academy,
                            style: SafeGoogleFont('Inter',
                                fontSize: 20 * ffem,
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
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 13 * ffem,
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
              widget.empty == false ? widget.bookPitchData.length : 1,
              (index) => widget.empty
                  ? Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        Center(
                          child: Text(
                            AppLocalizations.of(context)!.noAcademy,
                            style: TextStyle(
                              color: MyAppState.mode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  : InkWell(
                      onTap: () {
                        dynamic detail = {
                          "pitchId": widget.bookPitchData[index]["id"] ?? 0,
                          "subPitchId":
                              widget.bookPitchData[index]["pitchType"][0] ?? 0
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
                                            .bookPitchData[index]
                                                ["bookpitchfiles"]["files"]
                                            .isNotEmpty
                                        ? widget.bookPitchData[index]
                                                ["bookpitchfiles"]["files"][0]
                                            ["filePath"]
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
                                  widget.bookPitchData[index]["name"],
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
                                      'assets/light-design/images/icon-bus.png',
                                      width: 24 * fem,
                                      height: 24 * fem,
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .showDirections,
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
