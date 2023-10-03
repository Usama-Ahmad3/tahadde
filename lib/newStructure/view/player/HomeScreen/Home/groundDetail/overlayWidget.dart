import 'package:flutter/material.dart';

import '../../../../../../homeFile/routingConstant.dart';
import '../../../../../../localizations.dart';

class OverlayWidget extends StatefulWidget {
  var sportsList;
  var searchController;
  VoidCallback onTap;

  OverlayWidget(
      {required this.onTap,
      super.key,
      required this.searchController,
      required this.sportsList});

  @override
  State<OverlayWidget> createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<OverlayWidget> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Material(
                  child: Text(
                    AppLocalizations.of(context)!.search,
                    style: TextStyle(fontSize: height * 0.025),
                  ),
                ),
                CloseButton(onPressed: widget.onTap),
              ],
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Wrap(
              children: [
                ...List.generate(
                  widget.sportsList.length,
                  (index) => widget.sportsList.isEmpty
                      ? const SizedBox.shrink()
                      : widget.sportsList[index].name
                              .toString()
                              .toLowerCase()
                              .contains(
                                  widget.searchController.text.toLowerCase())
                          ? InkWell(
                              onTap: () {
                                Map detail = {
                                  "slug": widget.sportsList[index].slug,
                                  "bannerImage":
                                      widget.sportsList[index].bannerImage,
                                  "sportName":
                                      AppLocalizations.of(context)!.locale ==
                                              "en"
                                          ? widget.sportsList[index].name
                                          : widget.sportsList[index].nameArabic
                                };
                                Navigator.pushNamed(
                                    context, RouteNames.specificSportsScreen,
                                    arguments: detail);
                                setState(() {
                                  widget.onTap;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.025,
                                    vertical: height * 0.01),
                                child: Chip(
                                    avatar: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.transparent,
                                        child: Image.network(widget
                                            .sportsList[index].image
                                            .toString())),
                                    backgroundColor: Colors.transparent,
                                    elevation: 2,
                                    padding: const EdgeInsets.all(10),
                                    label: Text(
                                      widget.sportsList[index].name!,
                                      style: const TextStyle(color: Colors.black),
                                    )),
                              ),
                            )
                          : Container(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
