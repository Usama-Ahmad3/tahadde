import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';

class SlotBookig extends StatefulWidget {
  const SlotBookig({super.key});

  @override
  State<SlotBookig> createState() => _SlotBookigState();
}

class _SlotBookigState extends State<SlotBookig> {
  final _pageController = PageController(initialPage: 0);
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body:Stack(
          children: [
            Container(
              height: height,
              width: width,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.045,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: NetworkImage('https://s.yimg.com/fz/api/res/1.2/Fksl_THOtQhVkQfI_fa1jg--~C/YXBwaWQ9c3JjaGRkO2ZpPWZpdDtoPTEyMDtxPTgwO3c9MTIw/https://s.yimg.com/zb/imgv1/561beb0c-8bfd-3685-8d89-a258b9b21a11/t_500x300'),
                              radius: 20,
                            ),
                            SizedBox(
                              width: width * 0.04,
                            ),
                            const Text('Hello Lana...!',style: TextStyle(
                                fontSize: 20,fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                        Row(
                          children: [
                            Badge(
                              alignment: Alignment.topLeft,
                              backgroundColor: Colors.red,
                              child: InkWell(
                                  onTap: (){

                                  },
                                  child: const Icon(Icons.notifications_none)),
                            ),
                            IconButton(onPressed: (){
                            }, icon: const Icon(Icons.card_travel,color: Colors.black,))
                          ],
                        )
                      ],
                    ),
                  ),
                  CarouselSlider.builder(
                      itemCount: 3,
                      itemBuilder: (context, index, realIndex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Container(
                            height: height * 0.25,
                            width: double.infinity,
                            child: LayoutBuilder(builder: (context, constraints) {
                              final cheight = constraints.maxHeight;
                              final cwidth = constraints.maxWidth;
                              return Stack(
                                children: [
                                  Positioned(
                                    bottom:0,
                                    child: Container(
                                      width: cwidth,
                                      height: cheight * 0.7,
                                      decoration:  BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(12)),
                                          color: Colors.cyan.shade50
                                      ),
                                      child: DefaultTextStyle(
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 25),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text('Refresh Your Mind'),
                                              const Text('And Exercise.....',),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
                                                child: Container(
                                                  width : cwidth * 0.45,
                                                  height: cheight * 0.15,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.circular(30)
                                                  ),
                                                  child: const Center(child: Text('Join Now',style: TextStyle(color: Colors.white),)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top:0,
                                      right:0,
                                      child: Image.network('https://clipart-library.com/images_k/man-running-silhouette-vector/man-running-silhouette-vector-3.png',width: cwidth * 0.45,height: cheight,fit: BoxFit.fill,)),
                                ],
                              );
                            },),
                          ),
                        );
                      }, options: CarouselOptions(
                    initialPage: 0,
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 3),
                    autoPlayCurve: Curves.easeInCubic,
                    pageSnapping: true,
                    animateToClosest: true,
                  )),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       ...List.generate(3, (index) => AnimatedContainer(
                  //         decoration: BoxDecoration(
                  //           color: index == 0 ? Colors.black:index == 1 ? Colors.red:Colors.amber,
                  //           borderRadius: BorderRadius.circular(20),
                  //         ),
                  //         height: height * 0.01,
                  //         width: width * 0.02, duration: const Duration(seconds: 3),
                  //       ))
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: width,
                height: height * 0.57,
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.only(topLeft:Radius.elliptical(33, 45),topRight: Radius.elliptical(33, 45))
                ),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Align(
                            alignment: Alignment.topLeft,
                            child: Text('Training Calendar',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...List.generate(8, (index) => Padding(
                                padding:  const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  height: height * 0.12,
                                  width: width * 0.16,
                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                      spreadRadius: 1,
                                      offset: const Offset(1, 1),
                                      color:Colors.grey.shade200
                                  )],
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                  ),
                                  child: const DefaultTextStyle(
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.green
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('Sat'),
                                        Text('11',style: TextStyle(color: Colors.grey),),
                                        Icon(Icons.bike_scooter_outlined,size: 40,)
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.0),
                          child: Center(
                            child: Container(
                              width : width * 0.45,
                              height: height * 0.045,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 1,
                                  offset: const Offset(1, 1),
                                  color:Colors.grey.shade200
                              )],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: const Center(child: Text('Join Now',style: TextStyle(color: Colors.black),)),
                            ),
                          ),
                        ),
                        const Align(
                            alignment: Alignment.topLeft,
                            child: Text('Popular Exercise',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ...List.generate(3, (index) => Padding(
                                padding:  const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                                child: Container(
                                  height: height * 0.09,
                                  width: width * 0.2,
                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 1,
                                          offset: const Offset(1, 1),
                                          color:Colors.grey.shade100
                                      )],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const DefaultTextStyle(
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.green
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.directions_run,size: 35,),
                                        Text('Run')
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                        CarouselSlider.builder(
                            itemCount: 3,
                            itemBuilder: (context, index, realIndex) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 18),
                                child: Container(
                                  height: height * 0.4,
                                  width: double.infinity,
                                  child: LayoutBuilder(builder: (context, constraints) {
                                    final cheight = constraints.maxHeight;
                                    final cwidth = constraints.maxWidth;
                                    return Stack(
                                      children: [
                                        Positioned(
                                          bottom:0,
                                          child: Container(
                                            width: cwidth,
                                            height: cheight * 0.8,
                                            decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(12)),
                                                color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 1,
                                                    offset: const Offset(1, 1),
                                                    color:Colors.grey.shade100
                                                )],
                                            ),
                                            child: DefaultTextStyle(
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.black
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 25),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text('Discounts'),
                                                    const Row(
                                                      children: [
                                                        Text('On Sports Wear ',),
                                                        Text('20%',style: TextStyle(color: Colors.redAccent),),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: cheight * 0.09,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        const Icon(Icons.add_shopping_cart,size: 28,),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
                                                          child: Container(
                                                            width : cwidth * 0.4,
                                                            height: cheight * 0.15,
                                                            decoration: BoxDecoration(
                                                                color: Colors.red,
                                                                borderRadius: BorderRadius.circular(30)
                                                            ),
                                                            child: const Center(child: Text('Join Now',style: TextStyle(color: Colors.white),)),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            top:0,
                                            right:0,
                                            child: Image.network('https://clipart-library.com/images_k/man-running-silhouette-vector/man-running-silhouette-vector-3.png',width: cwidth * 0.45,height: cheight,fit: BoxFit.fill,)),
                                      ],
                                    );
                                  },),
                                ),
                              );
                            }, options: CarouselOptions(
                          initialPage: 0,
                          autoPlay: true,
                          autoPlayAnimationDuration: const Duration(seconds: 3),
                          autoPlayCurve: Curves.easeInCubic,
                          pageSnapping: true,
                          animateToClosest: true,
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ) ,
      ),
    );
  }
}
