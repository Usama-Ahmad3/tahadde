import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../localizations.dart';
import 'inReview.dart';
import 'varifiedPitch.dart';

class MyPitches extends StatefulWidget {
  int index = 0;
  MyPitches({required this.index});
  @override
  _MyPitchesState createState() =>
      _MyPitchesState(this.index, this.key as TabController);
}

class _MyPitchesState extends State<MyPitches>
    with SingleTickerProviderStateMixin {
  int index;
  _MyPitchesState(this.index, this._tabController);

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2, initialIndex: index);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0XFFFFFFFF),
            ),
          ),
          backgroundColor: const Color(0XFF032040),
          automaticallyImplyLeading: false,
          title: Text(
            AppLocalizations.of(context)!.myPitches,
            style: TextStyle(
                fontSize: appHeaderFont,
                color: const Color(0XFFFFFFFF),
                fontFamily: AppLocalizations.of(context)!.locale == "en"
                    ? "Poppins"
                    : "VIP",
                fontWeight: AppLocalizations.of(context)!.locale == "en"
                    ? FontWeight.bold
                    : FontWeight.normal),
          ),
        ),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(maxHeight: sizeHeight * .08),
                child: Material(
                  child: TabBar(
                    controller: _tabController,
                    labelColor: const Color(0XFF032040),
                    //controller: tabController,
                    unselectedLabelColor: const Color(0XFFADADAD),
                    labelStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins"),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: const EdgeInsets.only(),
                    indicatorColor: const Color(0XFF25A163),
                    indicatorWeight: 4,
                    //indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(
                          child: Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Container(
                          width: sizeWidth * .4,
                          alignment: Alignment.bottomCenter,
                          child: Text(AppLocalizations.of(context)!.verified,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins")),
                        ),
                      )),
                      Tab(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Container(
                            width: sizeWidth * .4,
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              AppLocalizations.of(context)!.inReview,
                              style: const TextStyle(
                                  // color: Color(0XFF032040),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    VarifiedPitch(),
                    ReviewPitch(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
