import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../constant.dart';
import '../../../../../../homeFile/utility.dart';
import '../../../../../../localizations.dart';
import '../../../../../../main.dart';
import '../../../../../../modelClass/my_venue_list_model_class.dart';
import '../../../../utils.dart';

class ViewMoreVenueScreen extends StatelessWidget {
  final List<MyVenueModelClass> venues;
  const ViewMoreVenueScreen({Key? key, required this.venues}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
            preferredSize: Size(sizeWidth, sizeHeight * 0.105),
            child: AppBar(
              title: Text(
                AppLocalizations.of(context)!.pitchBookings,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.black,
              leadingWidth: sizeWidth * 0.18,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: EdgeInsets.all(sizeHeight * 0.008),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.close,
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
            )),
        body: Container(
            color: Colors.black54,
            child: Container(
              height: sizeHeight,
              width: sizeWidth,
              decoration: BoxDecoration(
                  color: MyAppState.mode == ThemeMode.light
                      ? const Color(0XFFD6D6D6)
                      : const Color(0xff686868),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: sizeHeight * 0.01,
                    ),
                    ...List.generate(
                      venues.length,
                      (index) => Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: sizeHeight * 0.01),
                        child: Container(
                          decoration: BoxDecoration(
                            color: MyAppState.mode == ThemeMode.light
                                ? Colors.grey.shade200
                                : const Color(0xff373737),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: sizeWidth * 0.85,
                                height: sizeHeight * 0.196,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  child: cachedNetworkImage(
                                    cuisineImageUrl: venues[index].pitchImage,
                                    imageFit: BoxFit.fill,
                                    errorFit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              Text(
                                venues[index].venueName.toString(),
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: MyAppState.mode == ThemeMode.light
                                      ? const Color(0xff050505)
                                      : const Color(0xffffffff),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
