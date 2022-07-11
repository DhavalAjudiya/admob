import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Inapp Plugin by dooboolab'),
          ),
          body: InApp()),
    );
  }
}

class InApp extends StatefulWidget {
  @override
  _InAppState createState() => new _InAppState();
}

class _InAppState extends State<InApp> {
  StreamSubscription? _purchaseUpdatedSubscription;
  StreamSubscription? _purchaseErrorSubscription;
  StreamSubscription? _conectionSubscription;
  final List<String> _productLists = Platform.isAndroid
      ? [
          'android.test.purchased',
          'point_1000',
          '5000_point',
          'android.test.canceled',
        ]
      : ['com.cooni.point1000', 'com.cooni.point5000'];

  String _platformVersion = 'Unknown';
  List<IAPItem> _items = [];
  List<PurchasedItem> _purchases = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    if (_conectionSubscription != null) {
      _conectionSubscription?.cancel();
      _conectionSubscription = null;
    }
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String? platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.

    // prepare
    var result = await FlutterInappPurchase.instance.initialize();
    print('result: $result');

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion!;
    });

    // refresh items for android
    try {
      String msg = await FlutterInappPurchase.instance.consumeAll();
      print('consumeAllItems: $msg');
    } catch (err) {
      print('consumeAllItems error: $err');
    }

    _conectionSubscription = FlutterInappPurchase.connectionUpdated.listen((connected) {
      print('connected: $connected');
    });

    _purchaseUpdatedSubscription = FlutterInappPurchase.purchaseUpdated.listen((productItem) {
      print('purchase-updated: $productItem');
    });

    _purchaseErrorSubscription = FlutterInappPurchase.purchaseError.listen((purchaseError) {
      print('purchase-error: $purchaseError');
    });
  }

  void _requestPurchase(IAPItem item) {
    FlutterInappPurchase.instance.requestPurchase("${item.productId}");
  }

  Future _getProduct() async {
    print("---------- product List ");
    List<IAPItem> items = await FlutterInappPurchase.instance.getProducts(_productLists);
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
    List<PurchasedItem>? items = await FlutterInappPurchase.instance.getAvailablePurchases();
    for (var item in items!) {
      print('${item.toString()}');
      this._purchases.add(item);
    }

    setState(() {
      this._items = [];
      this._purchases = items;
    });
  }

  Future _getPurchaseHistory() async {
    List<PurchasedItem>? items = await FlutterInappPurchase.instance.getPurchaseHistory();
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
    List<Widget> widgets = _items
        .map((item) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        item.toString(),
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    FlatButton(
                      color: Colors.orange,
                      onPressed: () {
                        print("---------- Buy Item Button Pressed");
                        _requestPurchase(item);
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 48.0,
                              alignment: const Alignment(-1.0, 0.0),
                              child: const Text('Buy Item'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .toList();
    return widgets;
  }

  List<Widget> _renderPurchases() {
    List<Widget> widgets = _purchases
        .map((item) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        item.toString(),
                        style: const TextStyle(
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

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  'Running on: $_platformVersion\n',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: buttonWidth,
                        height: 60.0,
                        margin: const EdgeInsets.all(7.0),
                        child: FlatButton(
                          color: Colors.amber,
                          padding: const EdgeInsets.all(0.0),
                          onPressed: () async {
                            print("---------- Connect Billing Button Pressed");
                            await FlutterInappPurchase.instance.initialize();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            alignment: const Alignment(0.0, 0.0),
                            child: const Text(
                              'Connect Billing',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: buttonWidth,
                        height: 60.0,
                        margin: const EdgeInsets.all(7.0),
                        child: FlatButton(
                          color: Colors.amber,
                          padding: const EdgeInsets.all(0.0),
                          onPressed: () async {
                            print("---------- End Connection Button Pressed");
                            await FlutterInappPurchase.instance.finalize();
                            if (_purchaseUpdatedSubscription != null) {
                              _purchaseUpdatedSubscription?.cancel();
                              _purchaseUpdatedSubscription = null;
                            }
                            if (_purchaseErrorSubscription != null) {
                              _purchaseErrorSubscription?.cancel();
                              _purchaseErrorSubscription = null;
                            }
                            setState(() {
                              this._items = [];
                              this._purchases = [];
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            alignment: const Alignment(0.0, 0.0),
                            child: const Text(
                              'End Connection',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                          width: buttonWidth,
                          height: 60.0,
                          margin: const EdgeInsets.all(7.0),
                          child: FlatButton(
                            color: Colors.green,
                            padding: const EdgeInsets.all(0.0),
                            onPressed: () {
                              print("---------- Get Items Button Pressed");
                              _getProduct();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              alignment: const Alignment(0.0, 0.0),
                              child: const Text(
                                'Get Items',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          )),
                      Container(
                          width: buttonWidth,
                          height: 60.0,
                          margin: const EdgeInsets.all(7.0),
                          child: FlatButton(
                            color: Colors.green,
                            padding: const EdgeInsets.all(0.0),
                            onPressed: () {
                              print("---------- Get Purchases Button Pressed");
                              this._getPurchases();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              alignment: const Alignment(0.0, 0.0),
                              child: const Text(
                                'Get Purchases',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          )),
                      Container(
                        width: buttonWidth,
                        height: 60.0,
                        margin: const EdgeInsets.all(7.0),
                        child: FlatButton(
                          color: Colors.green,
                          padding: const EdgeInsets.all(0.0),
                          onPressed: () {
                            print("---------- Get Purchase History Button Pressed");
                            _getPurchaseHistory();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            alignment: const Alignment(0.0, 0.0),
                            child: const Text(
                              'Get Purchase History',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: _renderInApps(),
              ),
              Column(
                children: _renderPurchases(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
