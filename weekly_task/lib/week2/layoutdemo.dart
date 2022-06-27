import 'package:flutter/material.dart';

class LayoutMainPage extends StatefulWidget {
  const LayoutMainPage({Key? key}) : super(key: key);

  @override
  State<LayoutMainPage> createState() => _LayoutMainPageState();
}

class _LayoutMainPageState extends State<LayoutMainPage> {
  int _pagesIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Layoutdemo(),
    Page2(),
    Page3(),
    Page4(),
    Page5()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _pagesIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pagesIndex],
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _pagesIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black,
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          showUnselectedLabels: true,
          onTap: _onItemTapped,
          iconSize: 30,
          elevation: 5,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                label: "Order",
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/footprints.png"),
                  size: 25,
                ),
                label: 'Go Out',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 79, 74, 102),
              icon: ImageIcon(
                AssetImage("assets/images/crown.png"),
                size: 25,
              ),
              label: 'Pro',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.health_and_safety_rounded),
                label: 'Nutrition',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/donate.png"),
                size: 25,
              ),
              label: 'Donate',
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Page 2")),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("page 3")),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("page 4")),
    );
  }
}

class Page5 extends StatelessWidget {
  const Page5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("page 5")),
    );
  }
}

class Layoutdemo extends StatefulWidget {
  const Layoutdemo({Key? key}) : super(key: key);

  @override
  State<Layoutdemo> createState() => _LayoutdemoState();
}

class _LayoutdemoState extends State<Layoutdemo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            elevation: 0,
            backgroundColor: Colors.white,
            flexibleSpace: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                          Text(
                            "Golf Course Road",
                            style: TextStyle(
                                shadows: [
                                  Shadow(
                                      color: Colors.grey, offset: Offset(1, -1))
                                ],
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.dashed,
                                fontSize: 20),
                          ),
                          SizedBox(
                            width: 140,
                          ),
                          CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/peter.jpg"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          prefixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.search,
                                size: 29,
                                color: Colors.red,
                              )),
                          hintText: "Restaurant name , cuisine or dish",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 18),
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.tune_outlined,
                                size: 25,
                                color: Colors.red,
                              )),
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ],
            ),
            bottom: TabBar(
                isScrollable: true,
                padding: EdgeInsets.only(left: 15, right: 10),
                unselectedLabelStyle: TextStyle(color: Colors.grey),
                labelColor: Colors.black,
                tabs: [
                  Text(
                    "All",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text("chinese"),
                  Text("Dosa"),
                  Text("Biryani"),
                  Text("Pizza"),
                  Text("Burger"),
                  Text("Panjabi"),
                ]),
          ),
          body: TabBarView(children: [
            Tab(
              child: Orderagain_data(),
            ),
            Tab(
              text: "hello",
            ),
            Tab(
              text: "hello",
            ),
            Tab(
              text: "hello",
            ),
            Tab(
              text: "hello",
            ),
            Tab(
              text: "hello",
            ),
            Tab(
              text: "hello",
            ),
          ]),
        ),
      ),
    );
  }
}

class Orderagain_List {
  final String image;
  final String title;
  final String time;
  final String discount;

  Orderagain_List(
      {required this.image,
      required this.title,
      required this.time,
      required this.discount});
}

class restaurants_List {
  final String img;
  final Icon statusIcon;
  final String statusText;
  final Icon discIcon;
  final String discText;
  // String? proText;
  Widget? proIcon;
  final Icon ratting;
  final String rattingText;
  final String mainTitle;
  final String subTitle;

  restaurants_List(
    this.img,
    this.statusIcon,
    this.statusText,
    this.discIcon,
    this.discText,
    this.ratting,
    this.rattingText,
    this.mainTitle,
    this.subTitle, {
    this.proIcon,
    // this.proText,
  });
}

class Orderagain_data extends StatefulWidget {
  const Orderagain_data({Key? key}) : super(key: key);

  @override
  State<Orderagain_data> createState() => _Orderagain_dataState();
}

class _Orderagain_dataState extends State<Orderagain_data> {
  List<restaurants_List> Restaurants_data = [
    restaurants_List(
      "assets/images/thai.jpg",
      Icon(
        Icons.star,
        size: 13,
        color: Colors.redAccent,
      ),
      "Top Rated",
      Icon(
        Icons.star_border_rounded,
        size: 15,
        color: Colors.white,
      ),
      "FLATE 15-25% 0FF",

      Icon(
        Icons.star,
        size: 13,
        color: Colors.white,
      ),
      "4.5", "Diet. Thai Sizzler", "Thai , Korean",
      proIcon: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Row(
            children: [
              Icon(
                Icons.star_border_rounded,
                size: 15,
                color: Colors.white,
              ),
              Text(
                "PRO",
                style: TextStyle(color: Colors.white, fontSize: 12),
              )
            ],
          ),
        ),
      ),
      // proText: "PRO",
    ),
    restaurants_List(
      "assets/images/pancake.jpg",
      Icon(
        Icons.favorite,
        size: 13,
        color: Color.fromARGB(255, 250, 156, 203),
      ),
      "most love",
      Icon(
        Icons.star_border_rounded,
        size: 15,
        color: Colors.white,
      ),
      "FLATE 10-20% 0FF",

      Icon(
        Icons.star,
        size: 13,
        color: Colors.white,
      ),
      "4.3",
      "Classic Pancakes",
      "Asian , American",
      proIcon: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Row(
            children: [
              Icon(
                Icons.star_border_rounded,
                size: 15,
                color: Colors.white,
              ),
              Text(
                "PRO",
                style: TextStyle(color: Colors.white, fontSize: 12),
              )
            ],
          ),
        ),
      ),
      // proText: "PRO",
    ),
    restaurants_List(
        "assets/images/meat.jpg",
        Icon(
          Icons.star,
          size: 13,
          color: Colors.redAccent,
        ),
        "Top Rated",
        Icon(
          Icons.star_border_rounded,
          size: 15,
          color: Colors.white,
        ),
        "FLATE 10-20% 0FF",
        Icon(
          Icons.star,
          size: 13,
          color: Colors.white,
        ),
        "4.3",
        "Classic Pancakes",
        "Asian , American",
        proIcon: Container()
        // proText: "PRO",
        ),
    restaurants_List(
      "assets/images/pancake.jpg",
      Icon(
        Icons.star,
        size: 13,
        color: Colors.redAccent,
      ),
      "Top Rated",
      Icon(
        Icons.star_border_rounded,
        size: 15,
        color: Colors.white,
      ),
      "FLATE 5-10% 0FF",
      Icon(
        Icons.star,
        size: 13,
        color: Colors.white,
      ),
      "4.3",
      "Grilled Lamb",
      "American",
      proIcon: Icon(
        Icons.star_border_rounded,
        size: 15,
        color: Colors.white,
      ),
      // proText: "PRO",
    ),
    restaurants_List(
      "assets/images/salad.jpg",
      Icon(
        Icons.star,
        size: 13,
        color: Colors.redAccent,
      ),
      "Top Rated",
      Icon(
        Icons.star_border_rounded,
        size: 15,
        color: Colors.white,
      ),
      "FLATE 5-20% 0FF",

      Icon(
        Icons.star,
        size: 13,
        color: Colors.white,
      ),
      "4.8",
      "Diet Salad",
      "Italiyano",
      proIcon: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Row(
            children: [
              Icon(
                Icons.star_border_rounded,
                size: 15,
                color: Colors.white,
              ),
              Text(
                "PRO",
                style: TextStyle(color: Colors.white, fontSize: 12),
              )
            ],
          ),
        ),
      ),
      // proText: "PRO",
    ),
    restaurants_List(
        "assets/images/egg.jpg",
        Icon(
          Icons.favorite,
          size: 13,
          color: Color.fromARGB(255, 250, 156, 203),
        ),
        "most love",
        Icon(
          Icons.star_border_rounded,
          size: 15,
          color: Colors.white,
        ),
        "FLATE 10-20% 0FF",
        // proIcon: Icon(
        //   Icons.star_border_rounded,
        //   size: 15,
        //   color: Colors.white,
        // ),
        // proText: "PRO",
        Icon(
          Icons.star,
          size: 13,
          color: Colors.white,
        ),
        "4.3",
        "Egg Sandwich",
        "Italiyano, American",
        proIcon: Container()
        // proText: "PRO",
        ),
    restaurants_List(
      "assets/images/pizza.jpg",
      Icon(
        Icons.star,
        size: 13,
        color: Colors.redAccent,
      ),
      "Top Rated",
      Icon(
        Icons.star_border_rounded,
        size: 15,
        color: Colors.white,
      ),
      "FLATE 15-20% 0FF",
      // proIcon: Icon(
      //   Icons.star_border_rounded,
      //   size: 15,
      //   color: Colors.white,
      // ),
      // proText: "PRO",
      Icon(
        Icons.star,
        size: 13,
        color: Colors.white,
      ),
      "4.3",
      "Special Chiken Pizza",
      "Italiyan, American",
      proIcon: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Row(
            children: [
              Icon(
                Icons.star_border_rounded,
                size: 15,
                color: Colors.white,
              ),
              Text(
                "PRO",
                style: TextStyle(color: Colors.white, fontSize: 12),
              )
            ],
          ),
        ),
      ),
      // proText: "",
    ),
  ];
  List<Orderagain_List> Orderagain_data = [
    Orderagain_List(
        title: 'dosa',
        image: 'assets/images/dosa.jpg',
        time: '30 min',
        discount: '10% off'),
    Orderagain_List(
        title: 'Red valvet Cake',
        image: 'assets/images/cake.jpg',
        time: '30 min',
        discount: '10% off'),
    Orderagain_List(
        title: 'margherita pizza',
        image: 'assets/images/pizza.jpg',
        time: '30 min',
        discount: '10% off'),
    Orderagain_List(
        title: 'coffee',
        image: 'assets/images/coffee.jpg',
        time: '30 min',
        discount: '10% off'),
    Orderagain_List(
        title: 'margherita pizza',
        image: 'assets/images/pizza.jpg',
        time: '30 min',
        discount: '10% off'),
    Orderagain_List(
        title: 'coffee',
        image: 'assets/images/coffee.jpg',
        time: '30 min',
        discount: '10% off'),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 15),
              child: Text(
                "Order again",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 220,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: Text(
                "see all",
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Container(
          height: 150,
          // scrollDirection: Axis.horizontal,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 8,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,

            itemCount: Orderagain_data.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 0),
                child: Container(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          image: AssetImage(Orderagain_data[index].image),
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Orderagain_data[index].title,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              Orderagain_data[index].time,
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              Orderagain_data[index].discount,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                              textAlign: TextAlign.start,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color.fromARGB(255, 203, 241, 253),
                    child: Container(
                      width: 30,
                      child: Image(
                        image: AssetImage("assets/images/sAVE.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text("saved \nplaces",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12))
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color.fromARGB(255, 250, 224, 224),
                    child: Container(
                      width: 30,
                      child: Image(
                        image: AssetImage("assets/images/pro.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text("pro\n partners",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12))
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color.fromARGB(255, 212, 222, 253),
                    child: Container(
                      width: 30,
                      child: Image(
                        image: AssetImage("assets/images/discount.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text("Gret \n Offers",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12))
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color.fromARGB(255, 252, 234, 208),
                    child: Container(
                      width: 30,
                      child: Image(
                        image: AssetImage("assets/images/star.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text("Top \n Rated",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12))
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color.fromARGB(255, 212, 240, 233),
                    child: Container(
                      width: 30,
                      child: Image(
                        image: AssetImage("assets/images/diamond.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    "Premium \n  Picks",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 10)),
            Container(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage("assets/images/dosa.jpg"),
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 1),
                  child: Text(
                    "Based on what you like",
                    style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 121, 121, 121)),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 1),
                  child: Text(
                    "Masala Dosa",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 150,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: Text(
                "see all",
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        GridView.builder(
          // primary: false,
          padding: const EdgeInsets.all(7),
          // crossAxisSpacing: 10,
          // mainAxisSpacing: 10,
          // childAspectRatio: 3 / 3.5,
          // maxCrossAxisExtent: 180.0,

          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // crossAxisSpacing: 10
            mainAxisExtent: 202,
            crossAxisSpacing: 10
          ),
          itemCount: Restaurants_data.length,
          // shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(3),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Column(

                      children: [
                        Stack(
                          children: [
                            Image(
                              image: AssetImage(Restaurants_data[index].img),
                              fit: BoxFit.cover,
                              height: 150,
                              width: 230,
                            ),
                            Positioned(
                              top: 10,
                              left: 103,
                              height: 17,
                              width: 65,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Row(
                                      children: [
                                        Restaurants_data[index].statusIcon,
                                        Text(
                                          Restaurants_data[index].statusText,
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 10),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              left: 0,
                              height: 17,
                              width: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                child: Container(
                                  color: Colors.blue,
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Row(
                                      children: [
                                        Restaurants_data[index].discIcon,
                                        Text(
                                          Restaurants_data[index].discText,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 120,
                              left: 0,
                              height: 17,
                              width: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                child: Restaurants_data[index].proIcon!,
                              ),
                            ),
                            Positioned(
                              top: 125,
                              left: 140,
                              height: 17,
                              width: 30,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  color: Colors.green,
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          Restaurants_data[index].rattingText,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                        ),
                                        Restaurants_data[index].ratting,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 2),
                    child: Text(
                      "Diet. Thai Sizzler",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2, left: 3),
                    child: Text(
                      "Thai , Korean",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                  )
                ],
              ),
            );
          },

        ),
      ],
    );
  }
}
