import 'package:flutter/material.dart';

import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import 'pitch.dart';

class MyBookings extends StatefulWidget {
  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: appBar(
            title: AppLocalizations.of(context)!.myBooking.toString(),
            language: AppLocalizations.of(context)!.locale,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          // AppBar(
          //   flexibleSpace: Image(
          //     image: AppLocalizations.of(context).locale == "en"
          //         ? AssetImage('images/header.png')
          //         : AssetImage('images/arabicHeader.png'),
          //     fit: BoxFit.fill,
          //   ),
          //   //backgroundColor: Colors.transparent,
          //   leading: IconButton(
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //     icon: Icon(
          //       Icons.arrow_back_ios,
          //       color: Color(0XFFFFFFFF),
          //     ),
          //   ),
          //   backgroundColor: Color(0XFF032040),
          //   automaticallyImplyLeading: false,
          //   bottom: TabBar(
          //     tabs: [
          //       Tab(
          //         child: Padding(
          //           padding: const EdgeInsets.only(bottom: 6.0),
          //           child: Container(
          //             width: sizeWidth * .4,
          //             alignment: Alignment.bottomCenter,
          //             child: Text(
          //               AppLocalizations.of(context).events,
          //             ),
          //           ),
          //         ),
          //       ),
          //       Tab(
          //           child: Padding(
          //         padding: const EdgeInsets.only(bottom: 6.0),
          //         child: Container(
          //           width: sizeWidth * .4,
          //           alignment: Alignment.bottomCenter,
          //           child: Text(
          //             AppLocalizations.of(context).pitch,
          //           ),
          //         ),
          //       )),
          //     ],
          //     labelColor: Color(0XFFFFFFFF),
          //     labelStyle: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.w600,
          //         fontFamily: "Poppins"),
          //     unselectedLabelColor: Color(0XFF7A7A7A),
          //     indicatorPadding: EdgeInsets.only(),
          //     indicatorColor: Color(0XFF25A163),
          //     indicatorWeight: 4,
          //     indicatorSize: TabBarIndicatorSize.label,
          //   ),
          //   title: Text(
          //     AppLocalizations.of(context).myBooking,
          //     style: TextStyle(
          //         fontSize: appHeaderFont,
          //         color: Color(0XFFFFFFFF),
          //         fontFamily: AppLocalizations.of(context).locale == "en"
          //             ? "Poppins"
          //             : "VIP",
          //         fontWeight: AppLocalizations.of(context).locale == "en"
          //             ? FontWeight.bold
          //             : FontWeight.normal),
          //   ),
          // ),
          body: Pitch()

          // TabBarView(
          //   children: [Events(), Pitch()],
          // ),
          ),
    );
  }
}
