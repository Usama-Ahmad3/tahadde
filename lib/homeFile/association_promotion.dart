

import 'package:flutter/material.dart';

import '../constant.dart';
import '../localizations.dart';
import '../modelClass/pramotion_model_class.dart';
import 'routingConstant.dart';
import 'utility.dart';

class AssociationPromotion extends StatelessWidget {
  PromotionModelClass detail;
   AssociationPromotion({Key? key,required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
          top: true,
          right: false,
          bottom: false,
          left: false,
          child: Column(
            children: [
              Material(
                  elevation: 5,
                  child: Stack(
                    children: [
                      Container(
                        height: 180,
                        width: size.width,
                        color: Colors.white,
                        child: Column(
                          children: [
                            cachedNetworkImage( cuisineImageUrl:detail.image_url??"",
                                height: 150,
                                width: size.width,
                                imageFit: BoxFit.fill,
                                errorFit: BoxFit.fitHeight),
                            Text(detail.name.toString(),style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600,fontFamily: "poppins"),)
                          ],
                        ),
                      ),
                      Positioned(
                        left: 5.0,
                        top: 5.0,
                        child:  Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                              color: Color(0xFF25A163),
                              shape: BoxShape.circle),
                          child: RawMaterialButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            elevation: 2.0,
                            fillColor: const Color(0xFF25A163),
                            padding: const EdgeInsets.all(5.0),
                            shape: const CircleBorder(),
                            child: const Icon(Icons.arrow_back_sharp,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )),
               detail.pitchData.isNotEmpty?
              Expanded(
                child: ListView.separated(
                    itemCount:  detail.pitchData.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    padding: const EdgeInsets.only(top: 20),
                    separatorBuilder: (context, index) {
                      return fixedGap(height: 10.0);
                    },
                    itemBuilder:((context,index){
                      return venuesWidget( size.width,detail.pitchData[index],context);
                    }) ),
              ):const Expanded(child: Center(child: Text("There not any specific venue of this sports type"),)),
            ],
          ),
        )
    );
  }
  Widget venuesWidget(double sizeWidth,var index,BuildContext context){
    return GestureDetector(
      onTap: (){
        Map<String, dynamic> detail = {
          "pitchId": index["id"],
          "subPitchId": index["venue_details"]["pitchType"][0],
        };
         Navigator.pushNamed(context, RouteNames.venueDetailScreen,arguments: detail );
       },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Material(
            elevation: 5,
            child: Container(
              height: 250,
              width: sizeWidth,
              color: Colors.white,
              child: Column(

                children: [
                  cachedNetworkImage(cuisineImageUrl:index["images"]["files"].isNotEmpty?index["images"]["files"][0]["filePath"]:null,
                      height: 150,
                      width: sizeWidth,
                      imageFit: BoxFit.fitWidth,
                      errorFit:BoxFit.fitHeight),
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
                            Text(index["venue_details"]["name"],style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: appThemeColor),),
                            fixedGap(height: 5.0),
                            Text(AppLocalizations.of(context)!.showDirections,style:const TextStyle(
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
                          child: cachedNetworkImage( cuisineImageUrl:index["sports_types"]["sport_image"]["filePath"],
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
}
