import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';

class BottomSheett {
  static void settingModalBottomSheet(context, sizeHeight) {
    String msg =
        'hello,this is my App:https://tahadde.page.link?link=https://www.google.com/&apn=com.root.tahadde';
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        builder: (BuildContext bc) {
          return Container(
            height: sizeHeight * .35,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  flaxibleGap(
                    1,
                  ),
                  Text(
                    AppLocalizations.of(context)!.contectUs,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  flaxibleGap(
                    1,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final link = WhatsAppUnilink(
                        text: msg,
                      );
                      await launch("$link");
                      //FlutterShareMe().shareToWhatsApp(base64Image: base64Image, msg: msg);
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/whatApp.png',
                          height: 20,
                        ),
                        Container(
                          width: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.whatsapp,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  flaxibleGap(
                    1,
                  ),
                  GestureDetector(
                    onTap: () {
                      launchInBrowser("http://instagram.com/tahadde");
                      //InstagramShare.share('/', 'image');
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/instagram.png',
                          height: 20,
                        ),
                        Container(
                          width: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.instagram,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  flaxibleGap(
                    1,
                  ),
                  GestureDetector(
                    onTap: () {
                      launch("mailto:info@tahadde.com");
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/mailshare.png',
                          height: 20,
                        ),
                        Container(
                          width: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.email,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  flaxibleGap(
                    1,
                  ),
                  GestureDetector(
                    onTap: () {
                      makePhoneCall("tel:");
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/callshare.png',
                          height: 20,
                        ),
                        Container(
                          width: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.callus,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Container(),
                    flex: 1,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
