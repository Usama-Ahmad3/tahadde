import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../localizations.dart';

class InternetLoss extends StatefulWidget {
  Function onChange;
  InternetLoss({required this.onChange});
  @override
  _InternetLossState createState() => _InternetLossState();
}

class _InternetLossState extends State<InternetLoss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: const Color(0XFF032040),
          )),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 8,
              child: Container(),
            ),
            Lottie.asset('assets/lottiefiles/connection.json',
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width * .7),
            Text(
              AppLocalizations.of(context)!.noInternetConnection,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
            InkWell(
              splashColor: Colors.black,
              onTap: () {
                widget.onChange();
              },
              child: Text(
                AppLocalizations.of(context)!.tryAgain,
                style: const TextStyle(color: Colors.deepPurple, fontSize: 20),
              ),
            ),
            Flexible(
              flex: 8,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
