
import 'package:flutter/material.dart';

import '../homeFile/routingConstant.dart';
import '../homeFile/utility.dart';
import '../localizations.dart';

class ChooseAccount extends StatefulWidget {
  const ChooseAccount({super.key});

  @override
  _ChooseAccountState createState() => _ChooseAccountState();
}

class _ChooseAccountState extends State<ChooseAccount> {
  bool pitchOwner = false;
  bool player = false;

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: pitchOwner || player
          ? Material(
              color: const Color(0XFF25A163),
              child: InkWell(
                onTap: () {
                  pitchOwner
                      ? navigateToPitchOwnerSignUp()
                      : navigateToSignUp();
                },
                splashColor: Colors.black,
                child: Container(
                    height: sizeHeight * .09,
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.continueW,
                      style: const TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.white),
                    )),
              ),
            )
          : Container(
              height: sizeHeight * .09,
              color: Colors.grey,
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.continueW,
                style: const TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.white),
              )),
      body: Container(
        height: sizeHeight,
        width: sizeWidth,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            buildAppBar(
                language: AppLocalizations.of(context)!.locale,
                title: AppLocalizations.of(context)!.chooseAccount,
                backButton: true,
                onTap: () {
                  Navigator.of(context).pop();
                },
                height: sizeHeight,
                width: sizeWidth),
            Flexible(
              flex: 4,
              child: Container(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeWidth * .05),
              child: Text(AppLocalizations.of(context)!.selectUserType,
                  style: const TextStyle(
                      color: Color(0XFF646464),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins")),
            ),
            Flexible(
              flex: 3,
              child: Container(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      player = player ? false : true;
                      pitchOwner = false;
                    });
                  },
                  child: Container(
                    height: sizeHeight * .2,
                    width: sizeWidth * .55,
                    child: player
                        ? Image.asset(
                            'assets/images/playerSelected.png',
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            'assets/images/player.png',
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    AppLocalizations.of(context)!.player,
                    style: const TextStyle(
                        color: Color(0XFF032040),
                        fontFamily: "Poppins",
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      pitchOwner = pitchOwner ? false : true;
                      player = false;
                    });
                  },
                  child: Container(
                    height: sizeHeight * .2,
                    width: sizeWidth * .55,
                    child: pitchOwner
                        ? Image.asset(
                            'assets/images/pitchOwnerSelected.png',
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            'assets/images/pitchOwner.png',
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    AppLocalizations.of(context)!.pitchOwnerS,
                    style: const TextStyle(
                        color: Color(0XFF032040),
                        fontFamily: "Poppins",
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToPitchOwnerSignUp() {
    Navigator.pushNamed(context, RouteNames.signUpPitchOwner);
  }

  void navigateToSignUp() {
    Navigator.pushNamed(context, RouteNames.signupPage);
  }
}
