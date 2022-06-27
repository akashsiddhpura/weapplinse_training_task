import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

class InApp extends StatefulWidget {
  @override
  _InAppState createState() => new _InAppState();
}

class _InAppState extends State<InApp> {
  StreamSubscription? _purchaseUpdatedSubscription;
  StreamSubscription? _purchaseErrorSubscription;
  StreamSubscription? _conectionSubscription;
  List<String> _productLists = Platform.isAndroid
      ? [
          'android.test.purchased',
          'point_1000',
          // '5000_point',
          // 'android.test.canceled',
        ]
      : ['com.cooni.point1000', 'com.cooni.point5000'];

  String _platformVersion = 'Unknown';
  List<IAPItem> _items = [];
  List<PurchasedItem> _purchases = [];

  Color cardColor = Colors.grey;

  bool isPaymentSuccess = false;

  @override
  void initState() {
    isPaymentSuccess = false;
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    if (_conectionSubscription != null) {
      _conectionSubscription!.cancel();
      _conectionSubscription = null;
    }
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.

    // prepare
    var result = await FlutterInappPurchase.instance.initialize();
    print('result: $result');

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // setState(() {
    //   _platformVersion = platformVersion;
    // });

    // refresh items for android
    try {
      String msg = await FlutterInappPurchase.instance.consumeAll();
      print('consumeAllItems: $msg');
    } catch (err) {
      print('consumeAllItems error: $err');
    }

    _conectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {
      print('connected: $connected');
    });

    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) {
      _getPurchases();
      print('purchase-updated: $productItem');
    });

    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
      print('purchase-error: $purchaseError');
    });
    _getPurchases();
  }

  void _requestPurchase(IAPItem item) {
    FlutterInappPurchase.instance.requestPurchase(item.productId!);
  }

  Future _getProduct() async {
    List<IAPItem> items =
        await FlutterInappPurchase.instance.getProducts(_productLists);
    for (var item in items) {
      print('${item.toString()}');
      this._items.add(item);
    }

    setState(() {
      this._items = items;
      this._purchases = [];
    });
  }

  Future _getPurchases() async {
    List<PurchasedItem>? items =
        await FlutterInappPurchase.instance.getAvailablePurchases();
    for (var item in items!) {
      print('${item.toString()}');
      this._purchases.add(item);
    }

    // this._items = [];
    this._purchases = items;

    if (_purchases.length > 0) {
      cardColor = Colors.green.shade300;
      isPaymentSuccess = true;
      setState(() {});
    }
  }

  Future _getPurchaseHistory() async {
    List<PurchasedItem>? items =
        await FlutterInappPurchase.instance.getPurchaseHistory();
    for (var item in items!) {
      print('${item.toString()}');
      this._purchases.add(item);
    }

    setState(() {
      this._items = [];
      this._purchases = items;
    });
  }

  List<Widget> _renderInApps() {
    List<Widget> widgets = this
        ._items
        .map((item) => Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Card(
                elevation: 5,
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      print("---------- Buy Item Button Pressed");
                      this._requestPurchase(item);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Id : ${item.productId.toString()}",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Title : ${item.title.toString()}",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          item.description.toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "\u{20B9} ${item.price}",
                          style: TextStyle(
                            fontSize: 48.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ))
        .toList();
    return widgets;
  }

  List<Widget> _renderPurchases() {
    List<Widget> widgets = this
        ._purchases
        .map((item) => Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        item.toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
        .toList();
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width - 20;
    double buttonWidth = (screenWidth / 3) - 20;

    return Scaffold(
      appBar: AppBar(
        title: Text("In App Purchase"),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: <Widget>[
                    //     Container(
                    //       width: buttonWidth,
                    //       height: 60.0,
                    //       margin: EdgeInsets.all(7.0),
                    //       child: FlatButton(
                    //         color: Colors.amber,
                    //         padding: EdgeInsets.all(0.0),
                    //         onPressed: () async {
                    //           print(
                    //               "---------- Connect Billing Button Pressed");
                    //           await FlutterInappPurchase.instance.initialize();
                    //         },
                    //         child: Container(
                    //           padding: EdgeInsets.symmetric(horizontal: 20.0),
                    //           alignment: Alignment(0.0, 0.0),
                    //           child: Text(
                    //             'Connect Billing',
                    //             style: TextStyle(
                    //               fontSize: 16.0,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       width: buttonWidth,
                    //       height: 60.0,
                    //       margin: EdgeInsets.all(7.0),
                    //       child: FlatButton(
                    //         color: Colors.amber,
                    //         padding: EdgeInsets.all(0.0),
                    //         onPressed: () async {
                    //           print("---------- End Connection Button Pressed");
                    //           await FlutterInappPurchase.instance.finalize();
                    //           if (_purchaseUpdatedSubscription != null) {
                    //             _purchaseUpdatedSubscription!.cancel();
                    //             _purchaseUpdatedSubscription = null;
                    //           }
                    //           if (_purchaseErrorSubscription != null) {
                    //             _purchaseErrorSubscription!.cancel();
                    //             _purchaseErrorSubscription = null;
                    //           }
                    //           setState(() {
                    //             this._items = [];
                    //             this._purchases = [];
                    //           });
                    //         },
                    //         child: Container(
                    //           padding: EdgeInsets.symmetric(horizontal: 20.0),
                    //           alignment: Alignment(0.0, 0.0),
                    //           child: Text(
                    //             'End Connection',
                    //             style: TextStyle(
                    //               fontSize: 16.0,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigo,
                          shadowColor: Colors.black54,
                          fixedSize: Size(200, 40)),
                      onPressed: () {
                        print("---------- Get Items Button Pressed");
                        this._getProduct();
                      },
                      child: Text(
                        'Get Items',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: this._renderInApps(),
                ),
                isPaymentSuccess
                    ? Text(
                        "Payment Success full",
                        style: TextStyle(fontSize: 20, color: Colors.green),
                      )
                    : Text(
                        "Get Subscription",
                        style: TextStyle(fontSize: 20),
                      ),
                // Column(
                //   children: this._renderPurchases(),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class InApp extends StatefulWidget {
//   @override
//   _InAppState createState() => new _InAppState();
// }
//
// class _InAppState extends State<InApp> {
//   StreamSubscription? _purchaseUpdatedSubscription;
//   StreamSubscription? _purchaseErrorSubscription;
//   StreamSubscription? _conectionSubscription;
//   final List<String> _productLists = [
//     'android.test.purchased',
//     'point_1000',
//   ];
//
//   List<IAPItem> _items = [];
//   List<PurchasedItem> _purchases = [];
//   Color cardColor = Colors.grey.shade300;
//   bool isPaymentSuccess = false;
//
//   @override
//   void initState() {
//     _getProduct();
//     initPlatformState();
//     isPaymentSuccess = false;
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     if (_conectionSubscription != null) {
//       _conectionSubscription!.cancel();
//       _conectionSubscription = null;
//     }
//     super.dispose();
//   }
//
//   Future<void> initPlatformState() async {
//     String platformVersion;
//     try {
//       platformVersion = (await FlutterInappPurchase.instance.platformVersion)!;
//     } on PlatformException {
//       platformVersion = 'Failed to get platform version.';
//     }
//
//     var result = await FlutterInappPurchase.instance.initConnection;
//     print('result: $result');
//
//     if (!mounted) return;
//
//     // refresh items for android
//     try {
//       String msg = await FlutterInappPurchase.instance.consumeAll();
//       print('consumeAllItems: $msg');
//     } catch (err) {
//       print('consumeAllItems error: $err');
//     }
//
//     _conectionSubscription =
//         FlutterInappPurchase.connectionUpdated.listen((connected) {
//       print('connected: $connected');
//     });
//
//     _purchaseUpdatedSubscription =
//         FlutterInappPurchase.purchaseUpdated.listen((productItem) {
//       _getPurchases();
//       print('purchase-updated: $productItem');
//     });
//
//     _purchaseErrorSubscription =
//         FlutterInappPurchase.purchaseError.listen((purchaseError) {
//       print('purchase-error: $purchaseError');
//     });
//     _getPurchases();
//   }
//
//   void _requestPurchase(IAPItem item) {
//     FlutterInappPurchase.instance.requestPurchase(item.productId!);
//   }
//
//   Future _getProduct() async {
//     List<IAPItem> items =
//         await FlutterInappPurchase.instance.getProducts(_productLists);
//
//     for (var item in items) {
//       print('${item.toString()}');
//       this._items.add(item);
//     }
//
//     this._items = items;
//     // this._purchases = [];
//     setState(() {});
//   }
//
//   Future _getPurchases() async {
//     List<PurchasedItem>? items =
//         await FlutterInappPurchase.instance.getAvailablePurchases();
//     for (var item in items!) {
//       print('${item.toString()}');
//       this._purchases.add(item);
//     }
//
//     // this._items = [];
//     this._purchases = items;
//
//     if (_purchases.length > 0) {
//       cardColor = Colors.green.shade300;
//       isPaymentSuccess = true;
//       setState(() {});
//     }
//   }
//
//   Future _getPurchaseHistory() async {
//     List<PurchasedItem>? items =
//         await FlutterInappPurchase.instance.getPurchaseHistory();
//     for (var item in items!) {
//       print('${item.toString()}');
//       this._purchases.add(item);
//     }
//
//     this._items = [];
//     this._purchases = items;
//     setState(() {});
//   }
//
//   String dec = "hello";
//
//   List<Widget> _renderInApps() {
//     List<Widget> widgets = this
//         ._items
//         .map((item) =>
//         Container(
//               padding: EdgeInsets.all(20),
//               margin: EdgeInsets.symmetric(vertical: 10.0),
//               child: Card(
//                 elevation: 5,
//                 color: cardColor,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: GestureDetector(
//                     onTap: () {
//                       print("---------- Buy Item Button Pressed");
//                       this._requestPurchase(item);
//                     },
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           "Id : ${item.productId.toString()}",
//                           style: TextStyle(
//                             fontSize: 18.0,
//                             color: Colors.black,
//                           ),
//                         ),
//                         Text(
//                           "Title : ${item.title.toString()}",
//                           style: TextStyle(
//                             fontSize: 18.0,
//                             color: Colors.black,
//                           ),
//                         ),
//                         Text(
//                           item.description.toString(),
//                           style: TextStyle(
//                             fontSize: 18.0,
//                             color: Colors.black,
//                           ),
//                         ),
//                         Text(
//                           "\u{20B9} ${item.price}",
//                           style: TextStyle(
//                             fontSize: 48.0,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             )
//             )
//         .toList();
//     return widgets;
//   }
//
//   List<Widget> _renderPurchases() {
//     List<Widget> widgets = this
//         ._purchases
//         .map((item) => Container(
//               margin: EdgeInsets.symmetric(vertical: 10.0),
//               child: Container(
//                 child: Column(
//                   children: <Widget>[
//                     Container(
//                       margin: EdgeInsets.only(bottom: 5.0),
//                       child: Text(
//                         item.toString(),
//                         style: TextStyle(
//                           fontSize: 18.0,
//                           color: Colors.black,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ))
//         .toList();
//     return widgets;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width - 20;
//     double buttonWidth = (screenWidth / 3) - 20;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("In App Purchase"),
//         backgroundColor: Colors.black87,
//       ),
//       body: Container(
//         padding: EdgeInsets.all(10.0),
//         child: ListView(
//           children: <Widget>[
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       primary: Colors.indigo,
//                       shadowColor: Colors.black54,
//                       fixedSize: Size(200, 40)),
//                   onPressed: () {
//                     print("---------- Get Items Button Pressed");
//                     this._getProduct();
//                   },
//                   child: Text(
//                     'Get Items',
//                     style: TextStyle(
//                       fontSize: 16.0,
//                     ),
//                   ),
//                 ),
//                 Column(
//                   children: this._renderInApps(),
//                 ),
//                 isPaymentSuccess
//                     ? Text(
//                         "Payment Success full",
//                         style: TextStyle(fontSize: 20, color: Colors.green),
//                       )
//                     : Text(
//                         "Get Subscription",
//                         style: TextStyle(fontSize: 20),
//                       )
//
//                 // Column(
//                 //   children: this._renderPurchases(),
//                 // ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
