import 'package:flutter/material.dart';

class Customnav extends StatefulWidget {
  const Customnav({Key? key}) : super(key: key);

  @override
  State<Customnav> createState() => _CustomnavState();
}

class _CustomnavState extends State<Customnav> {
  int _pagesIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Page2(),
    Page3(),
    Page4(),
    Page5(),
    Page6()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom NavBar"),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 700,
              child: _pages[_pagesIndex],
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _pagesIndex = 0;
                          });
                        },
                        icon: _pagesIndex == 0
                            ? const Icon(
                                Icons.home_filled,
                                color: Colors.white,
                                size: 35,
                              )
                            : const Icon(
                                Icons.home_outlined,
                                color: Colors.white,
                                size: 35,
                              ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _pagesIndex = 1;
                          });
                        },
                        icon: _pagesIndex == 1
                            ? const Icon(
                                Icons.access_time_filled,
                                color: Colors.white,
                                size: 35,
                              )
                            : const Icon(
                                Icons.access_time_outlined,
                                color: Colors.white,
                                size: 35,
                              ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _pagesIndex = 2;
                          });
                        },
                        icon: _pagesIndex == 2
                            ? const Icon(
                                Icons.person_add_alt_rounded,
                                color: Colors.white,
                                size: 35,
                              )
                            : const Icon(
                                Icons.person_add_alt_outlined,
                                color: Colors.white,
                                size: 35,
                              ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _pagesIndex = 3;
                          });
                        },
                        icon: _pagesIndex == 3
                            ? const Icon(
                                Icons.garage_rounded,
                                color: Colors.white,
                                size: 35,
                              )
                            : const Icon(
                                Icons.garage_outlined,
                                color: Colors.white,
                                size: 35,
                              ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _pagesIndex = 4;
                          });
                        },
                        icon: _pagesIndex == 4
                            ? const Icon(
                                Icons.keyboard_voice_rounded,
                                color: Colors.white,
                                size: 35,
                              )
                            : const Icon(
                                Icons.keyboard_voice_outlined,
                                color: Colors.white,
                                size: 35,
                              ),
                      ),
                    ],
                  )
                ],
              ),
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
      color: Color.fromARGB(255, 230, 192, 221),
      child: Center(child: Text("Page 1")),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 210, 255, 192),
      child: Center(child: Text("page 2")),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 239, 192),
      child: Center(child: Text("page 3")),
    );
  }
}

class Page5 extends StatelessWidget {
  const Page5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 210, 209, 255),
      child: Center(child: Text("page 4")),
    );
  }
}

class Page6 extends StatelessWidget {
  const Page6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 192, 255, 252),
      child: Center(child: Text("page 5")),
    );
  }
}
