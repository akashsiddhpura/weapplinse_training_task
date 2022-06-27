import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResponsiveUI extends StatefulWidget {
  @override
  State<ResponsiveUI> createState() => _ResponsiveUIState();
}

class _ResponsiveUIState extends State<ResponsiveUI> {

  bool potrait = true;

  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]);
    potrait = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Responsive UI"),
        backgroundColor: Colors.black87,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (potrait) {
            SystemChrome.setPreferredOrientations(
                [DeviceOrientation.landscapeLeft]);
            potrait = false;
            updateui();
          } else {
            SystemChrome.setPreferredOrientations(
                [DeviceOrientation.portraitUp]);
            potrait = true;
            updateui();
          }
          updateui();
        },
        child: Icon(Icons.rotate_90_degrees_ccw),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            color: Colors.white54,
            child: potrait
                ? Column(
                    children: [
                      image(),
                      textData(),

                    ],
                  )
                : Row(
                      children: [
                        image(),
                        textData()
                      ],
                    ),
                ),
      ),);
  }

  Widget image() {
    return Expanded(

      child: Image.asset("assets/images/onboarding-1.png",),
    );
  }

  Widget textData(){
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("1. Mindfulness meditation",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Text(" Mindfulness meditation originates from Buddhist teachings and is the most popular and researched form of meditation in the West.In mindfulness meditation, you pay attention to your thoughts as they pass through your mind. You don’t judge the thoughts or become involved with them. You simply observe and take note of any patterns. This practice combines concentration with awareness. You may find it helpful to focus on an object or your breath while you observe any bodily sensations, thoughts, or feelings.This type of meditation is good for people who don’t have a teacher to guide them, as it can be easily practiced alone.",style: TextStyle(fontSize: 30),),
          ],
        ),
      ),
    );
  }
  int i = 1;
  Widget lists(){
    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    tileColor: Colors.grey.shade300,
                    title: Text("item : ${i++}"),
                  )
                ],
              ),
            );
          }),
    );
  }
  void updateui() {
    if (mounted) {
      setState(() {});
    }
  }
}
