import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/my_venue_list_model_class.dart';

class ViewMoreVenue extends StatelessWidget {
  final List<MyVenueModelClass> venues;
  const ViewMoreVenue({Key? key, required this.venues}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0XFFFFFFFF),
            ),
          ),
          //centerTitle: true,
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
          backgroundColor: const Color(0XFF032040),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sizeWidth * .04,
          ),
          child: SizedBox(
            height: sizeHeight,
            child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: List.generate(venues.length, (index) {
                  return GestureDetector(
                    onTap: () {},
                    child: buildMyVenue(venues[index]),
                  );
                })),
          ),
        ));
  }
}
