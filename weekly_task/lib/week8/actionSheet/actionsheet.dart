import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:popover/popover.dart';

class ActionSheet extends StatefulWidget {
  const ActionSheet({Key? key}) : super(key: key);

  @override
  State<ActionSheet> createState() => _ActionSheetState();
}


class _ActionSheetState extends State<ActionSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Action Sheet"),
        backgroundColor: Colors.black87,
        actions: [
          PopupMenuButton(
              shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
              itemBuilder: (context) => [
                 PopupMenuItem(child: Text('New Group')),
                 PopupMenuItem(child: Text('New Broadcast')),
                 PopupMenuItem(child: Text('Linked Devices')),
                 PopupMenuItem(child: Text('Starred Messages')),
                 PopupMenuItem(child: Text('Settings')),
                  ])
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(),
            ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Wrap(
                        children: [

                          ListTile(
                            leading: new Icon(Icons.photo),
                            title: new Text('Photo'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: new Icon(Icons.music_note),
                            title: new Text('Music'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: new Icon(Icons.videocam),
                            title: new Text('Video'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: new Icon(Icons.share),
                            title: new Text('Share'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text("Android")),
            ElevatedButton(
                onPressed: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return CupertinoActionSheet(
                          title: Text("This is Title field"),
                          message: Text("This is Message field"),
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: (){ Navigator.pop(context);},child: Text("Cancel"),
                          ),
                          actions: [
                            CupertinoActionSheetAction(
                              isDefaultAction: true,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Default Action',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            CupertinoActionSheetAction(
                                onPressed: () {}, child: Icon(Icons.photo)),
                            CupertinoActionSheetAction(
                                onPressed: () {},
                                child: Icon(Icons.music_note)),
                            CupertinoActionSheetAction(
                                onPressed: () {
                                }, child: Icon(Icons.videocam)),
                            CupertinoActionSheetAction(
                                onPressed: () {}, child: Icon(Icons.share)),
                            CupertinoActionSheetAction(
                              isDestructiveAction: true,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Destructive Action'),
                            )
                          ],
                        );
                      },);
                },
                child: Text("IOS"))
          ],
        ),
      ),
    );
  }


}

class MenuList extends StatelessWidget {
  const MenuList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Wrap(
          children: [
            ListTile(
              tileColor: Colors.green.shade50,
              leading: new Icon(Icons.emoji_emotions_rounded),
              title: new Text('Photo'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              tileColor: Colors.green.shade100,
              leading: new Icon(Icons.emoji_events_rounded),
              title: new Text('Music'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              tileColor: Colors.green.shade200,
              leading: new Icon(Icons.emoji_people_rounded),
              title: new Text('Video'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              tileColor: Colors.green.shade300,
              leading: new Icon(Icons.share),
              title: new Text('Share'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
     onPressed: (){
       showPopover(
         context: context,
         transitionDuration: const Duration(milliseconds: 150),
         bodyBuilder: (context) => const MenuList(),
         onPop: () => print('Popover was popped!'),
         direction: PopoverDirection.top,
         width: 200,
         // height: 250,
         arrowHeight: 15,
         arrowWidth: 30,
       );
     },
      child:
         Text('popover')

    );
  }
}
