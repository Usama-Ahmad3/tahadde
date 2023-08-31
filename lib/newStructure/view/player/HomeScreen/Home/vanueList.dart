import 'package:flutter/material.dart';

import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../utils.dart';

class VanueList extends StatefulWidget {
  dynamic bookPitchData;

  VanueList({super.key, required this.bookPitchData});

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
      height: 550 * fem,
      margin: EdgeInsets.only(top: 24 * fem),
      padding: EdgeInsets.fromLTRB(24 * fem, 24 * fem, 24 * fem, 0),
      decoration: BoxDecoration(
        color: mode == ThemeMode.light ? Color(0xffffffff) : Color(0xff5A5C60),
        borderRadius: BorderRadius.circular(24 * fem),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 16 * fem),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (mode == ThemeMode.light) {
                        MyAppState.mode = ThemeMode.dark;
                      } else {
                        MyAppState.mode = ThemeMode.light;
                      }
                      setState(() {});
                    },
                    child: Text(
                      AppLocalizations.of(context)!.venues,
                      style: SafeGoogleFont('Inter',
                          fontSize: 20 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.25 * ffem / fem,
                          letterSpacing: -0.2 * fem,
                          color: mode == ThemeMode.light
                              ? Color(0xff050505)
                              : Color(0xffffffff)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigateToViewMorePitch(widget.bookPitchData);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.viewAll,
                      style: SafeGoogleFont(
                        'Inter',
                        fontSize: 13 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.3846153846 * ffem / fem,
                        color: mode == ThemeMode.light
                            ? Color(0xff686868)
                            : Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ...List.generate(
              widget.bookPitchData.length,
              (index) => InkWell(
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
                          ? Color(0xffffffff)
                          : Color(0xff373737),
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
                                      .bookPitchData[index]["bookpitchfiles"]
                                          ["files"]
                                      .isNotEmpty
                                  ? widget.bookPitchData[index]
                                      ["bookpitchfiles"]["files"][0]["filePath"]
                                  : Container(),
                              height: 150,
                              width: fem,
                              imageFit: BoxFit.fitWidth,
                              errorFit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 4.0 * fem, bottom: 2 * fem),
                          child: Text(
                            widget.bookPitchData[index]["name"],
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.25 * ffem / fem,
                              letterSpacing: -0.2 * fem,
                              color: mode == ThemeMode.light
                                  ? Color(0xff050505)
                                  : Color(0xffffffff),
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
                              AppLocalizations.of(context)!.showDirections,
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 13 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3846153846 * ffem / fem,
                                color: const Color(0xff686868),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
    Navigator.pushNamed(context, RouteNames.viewMore, arguments: detail);
  }
}
