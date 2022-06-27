import 'package:flutter/material.dart';

class Listviewdemo extends StatelessWidget {
  const Listviewdemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1000,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Center(
                child: Text(
              "List view demo",
              style: TextStyle(fontSize: 30),
            )),
            ListTile(
              title: Text("list 1"),
              leading: Icon(Icons.list),
            ),
            ListTile(
              title: Text("setting"),
              leading: Icon(
                Icons.settings,
                color: Colors.amber,
              ),
            ),
            ListTile(
              title: Text("map"),
              leading: Icon(
                Icons.map,
                color: Colors.deepPurple,
              ),
            ),
            ListTile(
              title: Text("call"),
              leading: Icon(
                Icons.call,
                color: Colors.green,
              ),
            ),
            Container(
              child: Listhori(),
            ),
            Divider(
              thickness: 3,
            ),
            Container(
              child: Gridviewdemo(),
            )
          ],
        ),
      ),
    );
  }
}

class Listhori extends StatelessWidget {
  const Listhori({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 25),
        height: 150,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              width: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/profile.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: [
                  ListTile(
                    leading: Icon(Icons.contact_mail),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              width: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/profile.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: [
                  ListTile(
                    leading: Icon(Icons.contact_mail),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              width: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/profile.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: [
                  ListTile(
                    leading: Icon(Icons.contact_mail),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              width: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/profile.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: [
                  ListTile(
                    leading: Icon(Icons.contact_mail),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              width: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/profile.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: [
                  ListTile(
                    leading: Icon(Icons.contact_mail),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Gridviewdemo extends StatelessWidget {
  const Gridviewdemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 850,
        child: Column(
          children: [
            Text(
              "Grid view demo",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 10,
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/cake.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      ListTile(
                        leading: Icon(Icons.contact_mail),
                      )
                    ],
                  ),
                ),
                // SizedBox(
                //   width: 20,
                // ),
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/pizza.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      ListTile(
                        leading: Icon(Icons.contact_mail),
                      )
                    ],
                  ),
                ),
                // SizedBox(
                //   width: 20,
                // ),
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/pancake.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      ListTile(
                        leading: Icon(Icons.contact_mail),
                      )
                    ],
                  ),
                ),
                // SizedBox(
                //   width: 20,
                // ),
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/egg.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      ListTile(
                        leading: Icon(Icons.contact_mail),
                      )
                    ],
                  ),
                ),
                // SizedBox(
                //   width: 20,
                // ),
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/salad.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      ListTile(
                        leading: Icon(Icons.contact_mail),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/thai.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      ListTile(
                        leading: Icon(Icons.contact_mail),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/dosa.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      ListTile(
                        leading: Icon(Icons.contact_mail),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/peter.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      ListTile(
                        leading: Icon(Icons.contact_mail),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
