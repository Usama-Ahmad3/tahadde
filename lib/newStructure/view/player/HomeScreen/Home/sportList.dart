import 'package:flutter/material.dart';

import '../../../../../homeFile/routingConstant.dart';
import '../../../../../localizations.dart';

class SportList extends StatefulWidget {
  dynamic sportsList;
  int isSelected;

  SportList({super.key, required this.sportsList, required this.isSelected});

  @override
  State<SportList> createState() => _SportListState();
}

class _SportListState extends State<SportList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Row(
          children: [
            ...List.generate(
              widget.sportsList.length,
              (index) => InkWell(
                onTap: () {
                  widget.isSelected = index;
                  Map detail = {
                    "slug": widget.sportsList[index].slug,
                    "bannerImage": widget.sportsList[index].bannerImage,
                    "sportName": AppLocalizations.of(context)!.locale == "en"
                        ? widget.sportsList[index].name
                        : widget.sportsList[index].nameArabic
                  };
                  Navigator.pushNamed(context, RouteNames.specificSportsScreen,
                      arguments: detail);
                  setState(() {});
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  child: Chip(
                      avatar: CircleAvatar(
                          radius: 30,
                          backgroundColor: widget.isSelected == index
                              ? Colors.white
                              : Colors.grey,
                          child: Icon(sportIcon[index],
                              size: 19,
                              color: widget.isSelected == index
                                  ? Colors.black
                                  : const Color(0xff686868))),
                      backgroundColor: widget.isSelected == index
                          ? const Color(0xff7b61ff)
                          : Colors.black,
                      elevation: 2,
                      padding: const EdgeInsets.all(10),
                      label: Text(
                        widget.sportsList[index].name!,
                        style: TextStyle(
                            color: widget.isSelected == index
                                ? Colors.white
                                : const Color(0xff686868)),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List sportIcon = [
    Icons.sports_baseball_outlined,
    Icons.sports_tennis,
    Icons.sports_cricket_outlined,
    Icons.sports_hockey
  ];
}
