import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:flutter_tahaddi/newStructure/view/player/loginSignup/login.dart';

import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';

class ProfileEmptyScreen extends StatefulWidget {
  const ProfileEmptyScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileEmptyScreenState createState() => _ProfileEmptyScreenState();
}

class _ProfileEmptyScreenState extends State<ProfileEmptyScreen> {
  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return Material(
      child: Scaffold(
        backgroundColor: MyAppState.mode == ThemeMode.light
            ? Colors.white
            : const Color(0xff686868),
        appBar: PreferredSize(
          preferredSize: Size(sizeWidth, sizeHeight * 0.13),
          child: AppBar(
            title: Text(
              AppLocalizations.of(context)!.profile,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
            leadingWidth: sizeWidth * 0.18,
            // leading: Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.pop(context);
            //     },
            //     child: Container(
            //         height: sizeHeight * 0.004,
            //         decoration: BoxDecoration(
            //             border: Border.all(color: Colors.grey),
            //             shape: BoxShape.circle),
            //         child: Icon(
            //           AppLocalizations.of(context)!.locale == 'en'
            //               ? Icons.keyboard_arrow_left_sharp
            //               : Icons.keyboard_arrow_right,
            //           color: Colors.white,
            //         )),
            //   ),
            // ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                height: sizeHeight,
                width: sizeWidth,
                color: MyAppState.mode == ThemeMode.light
                    ? const Color(0XFFD6D6D6)
                    : const Color(0xff686868),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        height: sizeHeight * .5,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12)),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * 0.03),
                              child: ButtonWidget(
                                  onTaped: () {
                                    navigateToDetaillogin(1);
                                  },
                                  title: Center(
                                      child: Text(
                                          AppLocalizations.of(context)!.login)),
                                  isLoading: false),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height * .1,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: GestureDetector(
                                  onTap: () {
                                    navigateToDetaillogin(2);
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

  void navigateToDetaillogin(int click) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => LoginScreen(
                  message: '',
                  clicked: click,
                )));
  }
}
