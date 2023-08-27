import 'dart:ui';
import 'package:flutter/material.dart';
import '../../constant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';

class RegisterTeam extends StatefulWidget {
  List detail;
  RegisterTeam({required this.detail});
  @override
  _RegisterTeamState createState() => _RegisterTeamState();
}

class _RegisterTeamState extends State<RegisterTeam> {
  bool teamDetail = false;
  late int count;
  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalizations.of(context)!.registeredTeam,
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
      body: Stack(
        children: [
          Container(
              height: sizeheight,
              width: sizewidth,
              color: const Color(0XFFF0F0F0),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: AppLocalizations.of(context)!.locale == "en"
                                ? const EdgeInsets.only(right: 10)
                                : const EdgeInsets.only(left: 10),
                            child: const Icon(Icons.person),
                          ),
                          Text(
                              "${AppLocalizations.of(context)!.registeredTeamC} (${widget.detail.length})",
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Color(0XFF424242),
                                  decoration: TextDecoration.none)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: sizeheight * .7,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: widget.detail.length,
                            itemBuilder: (BuildContext context, int blockIdx) {
                              return Padding(
                                padding:
                                    EdgeInsets.only(bottom: sizeheight * .01),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      count = blockIdx;
                                      teamDetail = true;
                                    });
                                  },
                                  child: Container(
                                    color: const Color(0XFF032040),
                                    height: sizeheight * .13,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: sizeheight * .02),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: sizeheight * .1,
                                            width: sizewidth,
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                    height: sizeheight * .08,
                                                    width: sizeheight * .08,
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color(0XFF4F5C6A),
                                                      // image: Image.network(profileDetail.profile_pic),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.0),
                                                      child: widget
                                                                  .detail[
                                                                      blockIdx]
                                                                  .user
                                                                  .profile_pic !=
                                                              null
                                                          ? Image.network(
                                                              widget
                                                                  .detail[
                                                                      blockIdx]
                                                                  .user
                                                                  .profile_pic
                                                                  .filePath,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : Image.asset(
                                                              "images/profile.png",
                                                              fit: BoxFit.cover,
                                                            ),
                                                    )),
                                                flaxibleGap(
                                                  3,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    flaxibleGap(
                                                      4,
                                                    ),
                                                    Text(
                                                      "${widget.detail[blockIdx].user.first_name} ${widget.detail[blockIdx].user.last_name}",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .captain,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Color(
                                                              0XFF25A163)),
                                                    ),
                                                    flaxibleGap(
                                                      2,
                                                    ),
                                                    Text(
                                                      widget.detail[blockIdx]
                                                                  .team ==
                                                              null
                                                          ? ""
                                                          : widget
                                                                  .detail[
                                                                      blockIdx]
                                                                  .team
                                                                  .is_external
                                                              ? AppLocalizations
                                                                      .of(
                                                                          context)!
                                                                  .teamnotTahaddi
                                                              : AppLocalizations
                                                                      .of(context)!
                                                                  .teaminTahaddi,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                    flaxibleGap(
                                                      1,
                                                    ),
                                                  ],
                                                ),
                                                flaxibleGap(
                                                  4,
                                                ),
                                                Container(
                                                    height: sizeheight * .08,
                                                    width: sizeheight * .08,
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color(0XFF4F5C6A),
                                                      // image: Image.network(profileDetail.profile_pic),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      child: widget
                                                                  .detail[
                                                                      blockIdx]
                                                                  .team !=
                                                              null
                                                          ? Image.network(
                                                              widget
                                                                  .detail[
                                                                      blockIdx]
                                                                  .team
                                                                  .teamLogo
                                                                  .filePath,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : Image.asset(
                                                              "images/profile.png",
                                                              fit: BoxFit.cover,
                                                            ),
                                                    )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
//
                  ],
                ),
              )),
          teamDetail
              ? BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),
                )
              : Container(),
          teamDetail
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizewidth * .05),
                    child: Container(
                      height: sizeheight * .4,
                      width: sizewidth,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          flaxibleGap(
                            1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizewidth * .05),
                            child: Row(
                              children: <Widget>[
                                Text(AppLocalizations.of(context)!.teamDetail,
                                    style: const TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Color(0XFFADADAD),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins")),
                                flaxibleGap(
                                  1,
                                ),
                                Container(
                                  height: sizeheight * .03,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      setState(() {
                                        teamDetail = false;
                                      });
                                    },
                                    backgroundColor: const Color(0XFFD8D8D8),
                                    splashColor: Colors.black,
                                    child: Icon(
                                      Icons.clear,
                                      color: const Color(0XFF4A4A4A),
                                      size: sizeheight * .02,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          flaxibleGap(
                            1,
                          ),
                          Container(
                            color: Colors.white,
                            height: sizeheight * .13,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeheight * .02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: sizeheight * .1,
                                    width: sizewidth,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                            height: sizeheight * .08,
                                            width: sizeheight * .08,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0XFF4F5C6A),
                                              // image: Image.network(profileDetail.profile_pic),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                              child: widget.detail[count].user
                                                          .profile_pic !=
                                                      null
                                                  ? Image.network(
                                                      widget.detail[count].user
                                                          .profile_pic.filePath,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.asset(
                                                      "images/profile.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                            )),
                                        flaxibleGap(
                                          3,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            flaxibleGap(
                                              4,
                                            ),
                                            Text(
                                              "${widget.detail[count].user.first_name} ${widget.detail[count].user.last_name}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0XFF032040)),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .captain,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0XFF25A163)),
                                            ),
                                            flaxibleGap(
                                              2,
                                            ),
                                            Text(
                                              widget.detail[count].team == null
                                                  ? ""
                                                  : widget.detail[count].team
                                                          .teamName ??
                                                      "",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0XFF4A4A4A)),
                                            ),
                                            flaxibleGap(
                                              1,
                                            ),
                                          ],
                                        ),
                                        flaxibleGap(
                                          4,
                                        ),
                                        Container(
                                            height: sizeheight * .08,
                                            width: sizeheight * .08,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0XFF4F5C6A),
                                              // image: Image.network(profileDetail.profile_pic),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(10)),
                                              child:
                                                  widget.detail[count].team !=
                                                          null
                                                      ? Image.network(
                                                          widget
                                                              .detail[count]
                                                              .team
                                                              .teamLogo
                                                              .filePath,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
                                                          "images/profile.png",
                                                          fit: BoxFit.cover,
                                                        ),
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          flaxibleGap(
                            1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizeheight * .02),
                            child: Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.call,
                                  color: Color(0XFFADADAD),
                                  size: 14,
                                ),
                                Text(
                                  "${widget.detail[count].user.contact_number ?? ""}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0XFFADADAD),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizeheight * .02),
                            child: Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.mail,
                                  color: Color(0XFFADADAD),
                                  size: 14,
                                ),
                                Text(
                                  "  ${widget.detail[count].user.email}" ?? "",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0XFFADADAD),
                                  ),
                                )
                              ],
                            ),
                          ),
                          flaxibleGap(
                            1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizeheight * .02),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "${AppLocalizations.of(context)!.tranjectionId} : ",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0XFF0320040),
                                  ),
                                ),
                                Text(
                                  "${widget.detail[count].transactionId ?? ""}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0XFF0320040),
                                  ),
                                )
                              ],
                            ),
                          ),
                          flaxibleGap(
                            3,
                          ),
                          Container(
                              color: const Color(0XFFD8D8D8),
                              height: sizeheight * .08,
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  flaxibleGap(
                                    1,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.paidTotal,
                                    style: const TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Color(0XFF25A163),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                  flaxibleGap(
                                    10,
                                  ),
                                  Text(
                                    "${AppLocalizations.of(context)!.currency} ${widget.detail[count].paidTotal.round().toString() ?? ""}",
                                    style: const TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Color(0XFF25A163),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                  flaxibleGap(
                                    1,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
