import 'package:flutter/material.dart';

import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';

class ProfileEmpty extends StatefulWidget {
  @override
  _ProfileEmptyState createState() => _ProfileEmptyState();
}

class _ProfileEmptyState extends State<ProfileEmpty> {
  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return Material(
      child: Scaffold(
        backgroundColor: const Color(0XFFD6D6D6),
        body: Column(
          children: <Widget>[
            buildAppBar(
                language: AppLocalizations.of(context)!.locale,
                title: AppLocalizations.of(context)!.profileC,
                height: sizeHeight,
                width: sizeWidth),
            Expanded(
              child: Container(
                height: sizeHeight,
                width: sizeWidth,
                color: const Color(0XFFD6D6D6),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 40,
                    ),
                    // Text(
                    //   AppLocalizations.of(context).profileDec,
                    //   style: TextStyle(
                    //       fontFamily: 'Poppins',
                    //       fontSize: 18,
                    //       color: Color(0XFF032040),
                    //       fontWeight: FontWeight.w700),
                    // ),
                    // flaxibleGap(1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        height: sizeHeight * .5,
                        color: const Color(0XFFFFFFFF),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            flaxibleGap(1),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22,
                              ),
                              child: Center(
                                  child: Text(
                                AppLocalizations.of(context)!.profileDecfirst,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Color(0XFFB7B7B7),
                                    fontFamily: 'Poppins'),
                              )),
                            ),
                            flaxibleGap(1),
                            Image.asset(
                              'assets/images/Group.png',
                              height: 100,
                            ),
                            flaxibleGap(1),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Material(
                                child: Ink(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: const Color(0XFF25A163),
                                    //color: Color(color),
                                  ),
                                  child: InkWell(
                                    splashColor: Colors.black,
                                    child: button(
                                        name: AppLocalizations.of(context)!
                                            .signIn),
                                    onTap: () {
                                      navigateToDetaillogin();
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height * .1,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: GestureDetector(
                                  onTap: () {
                                    navigateToDetail();
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      flaxibleGap(4),
                                      Text(
                                          AppLocalizations.of(context)!
                                              .profileDecsecond,
                                          style: const TextStyle(
                                              color: Color(0XFFB7B7B7))),
                                      Text(
                                        AppLocalizations.of(context)!.signUp,
                                        style: const TextStyle(
                                            color: Colors.green),
                                      ),
                                      flaxibleGap(4),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    flaxibleGap(4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToDetail() {
    // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: SignupPage()));
    Navigator.pushNamed(context, RouteNames.chooseAccount);
  }

  void navigateToDetaillogin() {
    //Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: Loginpage()));
    Navigator.pushNamed(context, RouteNames.login);
  }
}
