import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

class SliverPersistentAppBar extends StatelessWidget {
  const SliverPersistentAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Material(
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: MySliverAppBar(expandedHeight: 200.0),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(
                    height: 120,
                  ),
                  listCardWidget(text1: 'Full Name:', text2: 'Aakash Siddhpura'),
                  listCardWidget(text1: 'Father\'s Name:', text2: 'Kishorbhai Siddhpura'),
                  listCardWidget(text1: 'Gender:', text2: 'Male'),
                  listCardWidget(text1: 'Marital Status:', text2: 'Single'),
                  listCardWidget(text1: 'Email:', text2: 'ak@123.com'),
                  listCardWidget(text1: 'Username:', text2: 'ak123'),
                  listCardWidget(text1: 'Phone:', text2: '987654321'),
                  listCardWidget(text1: 'Country', text2: 'India'),
                  listCardWidget(text1: 'City', text2: 'gujarat'),
                  listCardWidget(text1: 'Pincode:', text2: '395010'),
                  listCardWidget(text1: 'Company:', text2: 'weapplinse'),
                  listCardWidget(text1: 'Website:', text2: 'weapplinse.com'),
                  listCardWidget(text1: 'Position', text2: 'flutter trainee'),
                  listCardWidget(text1: 'LinkedIn Id:', text2: 'aksid123'),
                  listCardWidget(text1: 'Interest:', text2: 'Paininting'),
                ]),
              )
            ],
          ),
        ));
  }

  Widget listCardWidget({required String text1, required text2}) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
                fit: FlexFit.tight,
                child: Text(
                  text1,
                  style: const TextStyle(fontSize: 18),
                )),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Text(
                text2,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(

          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            color: Colors.teal
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [
            //     Color(0xFF0C6356),
            //     Color(0xff0e6c56),
            //   ],
            // ),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),

        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: const Text(
              'My Profile',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 4 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 4,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Column(
              children: [

                 Text(
                  'Check out my Profile',
                  style: TextStyle( color: Colors.white,fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                 SizedBox(
                  height: 10.0,
                ),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: SizedBox(
                    height: expandedHeight,
                    width: MediaQuery.of(context).size.width / 2,
                    child: CircularProfileAvatar(
                      '',
                      child: Image.asset(
                        'assets/images/peter.jpg',
                        fit: BoxFit.cover,
                      ),
                      radius: 100,
                      backgroundColor: Colors.transparent,
                      borderColor: Colors.white,
                      borderWidth: 4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}