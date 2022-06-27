import 'package:flutter/material.dart';

class CustomSwitchState extends StatefulWidget {
  @override
  _CustomSwitchStateState createState() => _CustomSwitchStateState();
}

class _CustomSwitchStateState extends State<CustomSwitchState>
    with SingleTickerProviderStateMixin {
  PageController? _pageController;
  int activePageIndex = 0;

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Custom tabBar"),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 0.0,
                  ),
                  child: _menuBar(context),
                ),
                Expanded(
                  flex: 3,
                  child: PageView(
                    controller: _pageController,
                    physics: const ClampingScrollPhysics(),
                    onPageChanged: (int i) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        activePageIndex = i;
                      });
                    },
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: Center(
                          child: Text("Home"),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints.expand(),
                        child: Center(
                          child: Text("Music"),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: Center(
                          child: Text("Video"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5, left: 10, right: 10),
      width: 400.0,
      height: 50.0,
      decoration: const BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              onTap: _onPlaceBidButtonPress,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                decoration: (activePageIndex == 0)
                    ? const BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      )
                    : null,
                child: Text(
                  "Home",
                  style: (activePageIndex == 0)
                      ? TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)
                      : TextStyle(
                          color: Colors.white54, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              onTap: _onBuyNowButtonPress,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                decoration: (activePageIndex == 1)
                    ? const BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      )
                    : null,
                child: Text(
                  "Music",
                  style: (activePageIndex == 1)
                      ? TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)
                      : TextStyle(
                          color: Colors.white54, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              onTap: _onBuyNowButtonPress2,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                decoration: (activePageIndex == 2)
                    ? const BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      )
                    : null,
                child: Text(
                  "Video",
                  style: (activePageIndex == 2)
                      ? TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)
                      : TextStyle(
                          color: Colors.white54, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPlaceBidButtonPress() {
    _pageController!.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onBuyNowButtonPress() {
    _pageController!.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onBuyNowButtonPress2() {
    _pageController!.animateToPage(2,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
