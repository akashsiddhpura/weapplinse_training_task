import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

dynamic  ar = [];

//
// class PhotoViewDemo extends StatefulWidget {
//   @override
//   _PhotoViewDemoState createState() => _PhotoViewDemoState();
// }
//
// class _PhotoViewDemoState extends State<PhotoViewDemo> {
//
//   late double startPositionV;
//   late double startPositionH;
//   late double endPositionV;
//   late double endPositionH;
//   int inx = 0;
//
//   Axis axisDirection = Axis.horizontal;
//
//   bool horizontal = true;
//   bool vertical = false;
//   double visibilityHorizontal = 1.0;
//   double visibilityVertical = 0.0;
//
//   final imageList = [
//     'assets/images/pizza.jpg',
//     'assets/images/dosa.jpg',
//     'assets/images/cake.jpg',
//     'assets/images/meat.jpg',
//     'assets/images/pancake.jpg',
//     'assets/images/egg.jpg',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("PhotoView Demo"),
//       ),
//       body: Center(
//         child: GestureDetector(
//           onVerticalDragUpdate: (val) {
//             setState(() {
//               axisDirection = Axis.vertical;
//               endPositionV = val.globalPosition.dy;
//             });
//           },
//           onVerticalDragStart: (val){
//             setState(() {
//               axisDirection = Axis.vertical;
//               startPositionV = val.globalPosition.dy;
//             });
//           },
//           onVerticalDragEnd: (val){
//             setState(() {
//               axisDirection = Axis.vertical;
//             });
//             if(startPositionV > endPositionV){
//               print("up");
//               if(inx != (imageList.length-1)){
//                 setState(() {
//                   inx= inx +1;
//                 });
//               }
//             }else{
//               print("down");
//               if(inx != 0){
//                 setState(() {
//                   inx= inx - 1;
//                 });
//               }
//             }
//           },
//           onHorizontalDragStart: (val){
//             setState(() {
//               axisDirection = Axis.horizontal;
//               startPositionH = val.globalPosition.dx;
//             });
//           },
//           onHorizontalDragEnd: (val){
//             setState(() {
//               axisDirection = Axis.horizontal;
//             });
//             if(inx != imageList.length){
//               if(startPositionH > endPositionH){
//                 print("right");
//                 if(inx != (imageList.length-1)){
//                   print("s");
//                   setState(() {
//                     inx = inx + 1;
//                   });
//                 }
//               }else{
//                 print("left");
//                 setState(() {
//                   axisDirection = Axis.horizontal;
//                   if(inx != 0){
//                     inx = inx - 1;
//                   }
//                 });
//               }
//             }
//           },
//           onHorizontalDragUpdate: (val){
//             setState(() {
//               endPositionH = val.globalPosition.dx;
//             });
//           },
//           child: horizontal ? Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: Visibility(
//               visible: horizontal,
//               child: PhotoViewGallery.builder(scrollDirection: axisDirection,
//                 itemCount: imageList.length,
//                 builder: (context, index) {
//                   inx = index;
//                   return PhotoViewGalleryPageOptions(
//                     imageProvider: AssetImage(
//                       imageList[inx],
//                     ),
//                     minScale: PhotoViewComputedScale.contained * 0.8,
//                     maxScale: PhotoViewComputedScale.covered * 2,
//                   );
//                 },
//                 backgroundDecoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(20)),
//                   color: Theme.of(context).canvasColor,
//                 ),
//                 enableRotation: true,
//                 loadingBuilder: (context, event) => Center(
//                   child: Container(
//                     width: 30.0,
//                     height: 30.0,
//                     child: CircularProgressIndicator(
//                       backgroundColor: Colors.orange,
//                       value: event == null
//                           ? 0
//                           : event.cumulativeBytesLoaded /
//                           event.expectedTotalBytes!,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ) : Visibility(
//               visible: vertical,
//               child: PhotoView(
//                 imageProvider: AssetImage(imageList[inx]),
//                 minScale: 1.0,
//                 maxScale: 5.0,
//                 enableRotation: true,
//               )
//           ),
//         ),
//       ),
//     );
//   }
// }

class Gesturedemo extends StatefulWidget {
  const Gesturedemo({Key? key}) : super(key: key);

  @override
  State<Gesturedemo> createState() => _GesturedemoState();
}

class _GesturedemoState extends State<Gesturedemo> {
  final imagelist = [
    'assets/images/dosa.jpg',
    'assets/images/cake.jpg',
    'assets/images/meat.jpg',
    'assets/images/pancake.jpg',
    'assets/images/egg.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GalleryWidget(
        imagelist: imagelist,
      )),
    );
  }
}

class GalleryWidget extends StatefulWidget {
  final List<String> imagelist;

  const GalleryWidget({Key? key, required this.imagelist}) : super(key: key);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  double? startPositionV;
  double? startPositionH;
  double? endPositionV;
  double? endPositionH;
  int inx = 0;
  int selectedIndex = 0;

  bool isvertical = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (val) {
          if(mounted) {
            setState(() {
              isvertical = false;
              // endPositionV = val.globalPosition.dy;
            });
          } },
        onVerticalDragEnd: (details) {
          if(mounted) {
            setState(() {
              isvertical = true;
            });
          }
        },
        child: CarouselSlider.builder(
          itemCount: widget.imagelist.length,
          options: CarouselOptions(
            viewportFraction: 1,
            enlargeCenterPage: false,
            scrollDirection: isvertical ? Axis.vertical : Axis.horizontal,
            height: MediaQuery.of(context).size.height,
            autoPlay: false,
            autoPlayInterval: Duration(seconds: 1),
            reverse: false,
            // aspectRatio: 5.0,
          ),
          itemBuilder: (context, i, id) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: PhotoViewGallery.builder(
                  scrollDirection: isvertical ? Axis.vertical : Axis.horizontal,
                  itemCount: widget.imagelist.length,
                  scrollPhysics: NeverScrollableScrollPhysics(),
                  builder: (context, index) {
                    // final imagelist = widget.imagelist[i];

                    return PhotoViewGalleryPageOptions(

                        imageProvider: AssetImage(widget.imagelist[i]),
                        minScale: PhotoViewComputedScale.contained,
                        maxScale: PhotoViewComputedScale.contained * 4);
                  }),
            );
          },
        ),
      ),
    );
  }
}

/* PhotoViewGallery.builder(

scrollDirection: isvertical ? Axis.vertical : Axis.horizontal,
itemCount: widget.imagelist.length,
builder: (context, index) {
final imagelist = widget.imagelist[index];

return PhotoViewGalleryPageOptions(
onTapUp: (context, details, controllerValue) {
print("${details} ${controllerValue.position}");
},
onScaleEnd: (context, details, controllerValue){
print("sdff");
},
imageProvider: AssetImage(widget.imagelist[selectedIndex]),
minScale: PhotoViewComputedScale.contained,
maxScale: PhotoViewComputedScale.contained * 4);
})*/
