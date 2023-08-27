import 'package:flutter/material.dart';

import '../../homeFile/notificationEmpty.dart';
import '../../localizations.dart';
import '../bookingPitchOwner/booking.dart';
import '../profilePitchOwner/account.dart';
import 'pitchOwnerHome.dart';

class HomePitchOwner extends StatefulWidget {
  int index = 0;
  HomePitchOwner({required this.index});
  @override
  _HomePitchOwnerState createState() => _HomePitchOwnerState();
}

class _HomePitchOwnerState extends State<HomePitchOwner>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: 4, initialIndex: widget.index);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {});
  }

  onWillPop() {
    return showDialog(
        context: context,
        builder: (BuildContext cntext) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.areYouSure),
            content: Text(AppLocalizations.of(context)!.youGoingExit),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.no),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.yes),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        return onWillPop();
      },
      child: Material(
          child: DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: AppBar(
                  backgroundColor: const Color(0XFF032040),
                )),
            bottomNavigationBar: SizedBox(
              height: sizeHeight * .13,
              child: Column(
                children: <Widget>[
                  Container(
                    height: sizeHeight * .002,
                    color: const Color(0XFFE0E0E0),
                  ),
                  TabBar(
                    labelStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                    ),
                    controller: _tabController,
                    tabs: [
                      Tab(
                          icon: _tabController.index == 0
                              ? Image.asset(
                                  'assets/images/home.png',
                                  height: sizeHeight * .035,
                                  color: const Color(0XFF25A163),
                                )
                              : Image.asset(
                                  'assets/images/home.png',
                                  height: sizeHeight * .035,
                                  color: Colors.grey,
                                ),
                          text: AppLocalizations.of(context)!.home),
                      Tab(
                          icon: _tabController.index == 1
                              ? Image.asset(
                                  'assets/images/booking.png',
                                  height: sizeHeight * .035,
                                  color: const Color(0XFF25A163),
                                )
                              : Image.asset(
                                  'assets/images/booking.png',
                                  height: sizeHeight * .035,
                                  color: Colors.grey,
                                ),
                          text: AppLocalizations.of(context)!.booking),
                      Tab(
                          icon: _tabController.index == 2
                              ? Image.asset(
                                  'assets/images/notificationP.png',
                                  height: sizeHeight * .035,
                                  color: const Color(0XFF25A163),
                                )
                              : Image.asset(
                                  'assets/images/notificationP.png',
                                  height: sizeHeight * .035,
                                  color: Colors.grey,
                                ),
                          text: AppLocalizations.of(context)!.notification),
                      Tab(
                          icon: _tabController.index == 3
                              ? Image.asset(
                                  'assets/images/account.png',
                                  height: sizeHeight * .035,
                                  color: const Color(0XFF25A163),
                                )
                              : Image.asset(
                                  'assets/images/account.png',
                                  height: sizeHeight * .035,
                                  color: Colors.grey,
                                ),
                          text: AppLocalizations.of(context)!.account),
                    ],
                    labelColor: const Color(0XFF25A163),
                    indicatorWeight: 4,
                    unselectedLabelColor: const Color(0XFF7A7A7A),
                    //indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: const EdgeInsets.only(bottom: 3),
                    indicatorColor: const Color(0XFF25A163),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                PitchOwnerHome(),
                Booking(),
                NotificationEmpty(),
                Account()
              ],
            )),
      )),
    );
  }
}
