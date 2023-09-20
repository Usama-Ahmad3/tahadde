import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  int isSelected = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tahadde',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          Text(
                            'Good Morning',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white30,
                        child: Badge(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20),
                  child: TextFormField(
                    controller: _searchController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.white,
                      ),
                      enabled: false,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.grey)),
                      hintText: 'Dubai',
                      constraints: BoxConstraints(
                        maxHeight: height * 0.07,
                        minHeight: height * 0.07,
                      ),
                      alignLabelWithHint: true,
                      label: const Text(
                        'Select Your Location',
                        style: TextStyle(color: Colors.white),
                      ),
                      prefixIcon: const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                      fillColor: Colors.white30,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Row(
                      children: [
                        ...List.generate(
                          4,
                          (index) => InkWell(
                            onTap: () {
                              isSelected = index;
                              setState(() {});
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: Chip(
                                  avatar: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: isSelected == index
                                          ? Colors.white
                                          : Colors.grey,
                                      child: Icon(sportIcon[index], size: 19)),
                                  backgroundColor: isSelected == index
                                      ? Colors.blue
                                      : Colors.black,
                                  elevation: 2,
                                  padding: const EdgeInsets.all(10),
                                  label: Text(
                                    sportName[index].toString(),
                                    style: TextStyle(
                                        color: isSelected == index
                                            ? Colors.white
                                            : Colors.grey),
                                  )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              left: 5,
              right: 5,
              child: Container(
                height: height * 0.57,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 11.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Nearby You',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'See All',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        ...List.generate(
                            4,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: height * 0.35,
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20)),
                                          child: SizedBox(
                                            height: height * 0.24,
                                            width: double.infinity,
                                            child: Image.network(
                                                stadiumImage[index],
                                                fit: BoxFit.fitWidth),
                                          ),
                                        ),
                                        const Positioned(
                                          bottom: 55,
                                          left: 8,
                                          child: Text(
                                            'Dubai International Cricket Stadium',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const Positioned(
                                          bottom: 20,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                color: Colors.grey,
                                              ),
                                              Text(
                                                '26W9+MJR Dubai - United Arab Emirates',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                      ],
                    ),
                  ),
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
  List sportName = ['Football', 'Tennis', "Cricket", 'Hockey'];
  List stadiumImage = [
    'https://tse3.mm.bing.net/th?id=OIP.ofMK6hLP8Fl_oQH3lsQbgAHaE9&pid=Api&P=0&h=220',
    'https://wallpapercave.com/wp/IG6YTGZ.jpg',
    'https://www.pcclean.io/wp-content/uploads/2020/4/rUZv6v.jpg',
    'https://tse1.mm.bing.net/th?id=OIP.NEy01UJmU7tBNLRi-ja5fQHaED&pid=Api&P=0&h=220'
  ];
}
