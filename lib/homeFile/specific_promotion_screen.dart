import 'package:flutter/material.dart';

import '../constant.dart';
import '../localizations.dart';
import '../network/network_calls.dart';
import 'routingConstant.dart';
import 'utility.dart';

class SpecificPromotionScreen extends StatefulWidget {
  final String? id;
  const SpecificPromotionScreen({Key? key,this.id}) : super(key: key);

  @override
  _SpecificPromotionScreenState createState() => _SpecificPromotionScreenState();
}

class _SpecificPromotionScreenState extends State<SpecificPromotionScreen> {
  final NetworkCalls _networkCalls = NetworkCalls();

  bool _isLoading = true;
  var _bookPitchData;

  loadVenues() async {
    await _networkCalls.getSpecificPromotion(
      id: widget.id.toString(),
      onSuccess: (pitchInfo) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _bookPitchData = pitchInfo;
          });
        }
      },
      onFailure: (msg) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadVenues();
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar (language: AppLocalizations.of(context)!.locale.toString(),  onTap: (){
        Navigator.pop(context);
      },title:"Promotion"  ),
      body: _isLoading?const Center(child: CircularProgressIndicator(color: appThemeColor,),): _bookPitchData.isNotEmpty?ListView.separated(
          itemCount: _bookPitchData.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.only(top: 20),
          separatorBuilder: (context, index) {
            return fixedGap(height: 10.0);
          },
          itemBuilder:((context,index){
            return venuesWidget( size.width,index);
          }) ):const Center(child: Text("There not any specific venue of this sports type"),),
    );
  }
  Widget venuesWidget(double sizeWidth,int index){
    return GestureDetector(
      onTap: (){
        Map<String, dynamic> detail = {
          "pitchId": _bookPitchData[index]["id"],
          "subPitchId": _bookPitchData[index]["pitchType"][0]
        };
        navigateToBookPitchDetail(detail);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Material(
            elevation: 5,
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(20), ),
            child: SizedBox(
              height: 250,
              width: sizeWidth,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius:
                    const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight:Radius.circular(20), ),
                    child: cachedNetworkImage( cuisineImageUrl: _bookPitchData[index]["bookpitchfiles"]["files"].isNotEmpty? _bookPitchData[index]["bookpitchfiles"]["files"][0]["filePath"]:null,
                      height: 150,
                      width: sizeWidth,
                      imageFit: BoxFit.fitWidth,),
                  ),
                  flaxibleGap(2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text( _bookPitchData[index]["name"],style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: appThemeColor),),
                            fixedGap(height: 5.0),
                            const Text("Show Directions",style:TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0XFF25A163))),

                          ],),
                        Container(
                          height: 40,
                          width: 40,
                          color: appThemeColor,
                          padding: const EdgeInsets.all(8.0),
                          child: cachedNetworkImage( cuisineImageUrl: _bookPitchData[index]["sports_types"]!=null?_bookPitchData[index]["sports_types"]["sport_image"]["filePath"]:null,
                            height: 40,
                            width: 40,
                            color: Colors.white,
                            imageFit: BoxFit.fitHeight,),
                        )
                      ],),
                  ),
                  flaxibleGap(2),

                ],
              ),
            )),
      ),
    );
  }
  void navigateToBookPitchDetail(Map detail) {
    Navigator.pushNamed(context, RouteNames.venueDetailScreen,arguments: detail );
  }
}
