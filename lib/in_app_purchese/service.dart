// PaymentServiceCode().initConnection();
// PaymentServiceCode().showMessageStreamController.stream.listen((value) async {
// var messageValue = value;
// if (messageValue == 1) {
// AppToast.toastMessage("Purchase111 successful.");
// } else {
// AppToast.toastMessage("Purchase111 failed.");
// }
// });

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:get/get.dart';
// import 'package:telly/modules/authentication/controller/authentication_controller/authentication_controller.dart';
// import 'package:telly/modules/subscription/controller/subscription_controller.dart';
// import 'package:telly/res/strings.dart';
//
// import '../../onboarding/controller/onboarding_controller.dart';

class PaymentService {
  static final PaymentService _paymentService = PaymentService._init();

  // static final OnBoardingController onBoardingController = Get.find();
  // static final SubscriptionController _subscribeController = Get.find();

  factory PaymentService() {
    return _paymentService;
  }

  PaymentService._init();

  // AuthenticationController _authenticationController = Get.find();

  StreamController<int> showMessageStreamController = StreamController<int>();

  /// To listen the status of connection between app and the billing server
  // ignore: cancel_subscriptions
  StreamSubscription<ConnectionResult>? _connectionSubscription;

  /// To listen the status of the purchase made inside or outside of the app (App Store / Play Store)
  /// If status is not error then app will be notied by this stream
  // ignore: cancel_subscriptions
  StreamSubscription<PurchasedItem?>? _purchaseUpdatedSubscription;

  /// To listen the errors of the purchase

  // ignore: cancel_subscriptions
  StreamSubscription<PurchaseResult?>? _purchaseErrorSubscription;
  StreamSubscription<String?>? purchasePromotedController;

  /// List of product ids you want to fetch
  final List<String> _productIds = ['year_auto', 'monthly_auto'];

  /// All available products will be store in this list
  List<IAPItem>? _products;

  /// All past purchases will be store in this list
  List<PurchasedItem>? _pastPurchases;

  /// view of the app will subscribe to this to get notified
  /// when premium status of the user changes
  ObserverList<Function> _proStatusChangedListeners = new ObserverList<Function>();

  /// view of the app will subscribe to this to get errors of the purchase
  ObserverList<Function(String)> _errorListeners = new ObserverList<Function(String)>();

  /// logged in user's premium status
  bool _isProUser = false;

  bool get isProUser => _isProUser;
  IAPItem? item;

  /// view can subscribe to _proStatusChangedListeners using this method
  addToProStatusChangedListeners(Function callback) {
    _proStatusChangedListeners.add(callback);
  }

  /// view can cancel to _proStatusChangedListeners using this method
  removeFromProStatusChangedListeners(Function callback) {
    _proStatusChangedListeners.remove(callback);
  }

  /// view can subscribe to _errorListeners using this method
  addToErrorListeners(Function callback) {
    _errorListeners.add(callback());
  }

  /// view can cancel to _errorListeners using this method
  removeFromErrorListeners(Function callback) {
    _errorListeners.remove(callback());
  }

  /// Call this method to notify all the subsctibers of _proStatusChangedListeners
  void _callProStatusChangedListeners() {
    _proStatusChangedListeners.forEach((Function callback) {
      callback();
    });
  }

  /// Call this method to notify all the subsctibers of _errorListeners
  void _callErrorListeners(String error) {
    log("Eroor ---->$error");
    _errorListeners.forEach((Function callback) {
      log("Eroor ---->$error");
      callback(error);
    });
  }

  /// Call this method at the startup of you app to initialize connection
  /// with billing server and get all the necessary data
  void initConnection() async {
    await FlutterInappPurchase.instance.initialize();
    _connectionSubscription = FlutterInappPurchase.connectionUpdated.listen((connected) {});
    _purchaseUpdatedSubscription = FlutterInappPurchase.purchaseUpdated.listen(_handlePurchaseUpdate);
    purchasePromotedController = FlutterInappPurchase.purchasePromoted.listen(handlePromoUpdate);
    _purchaseErrorSubscription = FlutterInappPurchase.purchaseError.listen(_handlePurchaseError);
    List<PurchasedItem>? result = await FlutterInappPurchase.instance.getPendingTransactionsIOS();
    getItems();
    getPastPurchases();
  }

  /// call when user close the app
  void dispose() {
    _connectionSubscription!.cancel();
    _purchaseErrorSubscription!.cancel();
    _purchaseUpdatedSubscription!.cancel();
    purchasePromotedController!.cancel();
    FlutterInappPurchase.instance.finalize();
  }

  void _handlePurchaseError(PurchaseResult? purchaseError) {
    _callErrorListeners(purchaseError!.message!);
    print("_handlePurchaseError : - ${purchaseError.message!}");
    // _subscribeController.isLoader.value = false;
    showMessageStreamController.add(2);
  }

  /// Called when new updates arrives at ``purchaseUpdated`` stream
  void _handlePurchaseUpdate(PurchasedItem? productItem) async {
    print("product iteam--------------->${productItem!.productId}");
    if (Platform.isAndroid) {
      await _handlePurchaseUpdateAndroid(productItem);
    } else {
      await _handlePurchaseUpdateIOS(productItem);
    }
  }

  void handlePromoUpdate(String? promoCode) {
    log('handlePromoUpdate --> $promoCode');
  }

  Future<void> _handlePurchaseUpdateIOS(PurchasedItem purchasedItem) async {
    switch (purchasedItem.transactionStateIOS) {
      case TransactionState.deferred:
        // Edit: This was a bug that was pointed out here : https://github.com/dooboolab/flutter_inapp_purchase/issues/234
        // FlutterInappPurchase.instance.finishTransaction(purchasedItem);
        break;
      case TransactionState.failed:
        _callErrorListeners("Transaction failed");

        FlutterInappPurchase.instance.finishTransaction(purchasedItem);
        break;
      case TransactionState.purchased:
        await _verifyAndFinishTransaction(purchasedItem);
        break;
      case TransactionState.purchasing:
        break;
      case TransactionState.restored:
        FlutterInappPurchase.instance.finishTransaction(purchasedItem);
        break;
      default:
    }
  }

  /// three purchase state
  /// 0 : UNSPECIFIED_STATE
  /// 1 : PURCHASED
  /// 2 : PENDING
  Future<void> _handlePurchaseUpdateAndroid(PurchasedItem purchasedItem) async {
    switch (purchasedItem.purchaseStateAndroid!.index) {
      case 1:
        if (!purchasedItem.isAcknowledgedAndroid!) {
          await _verifyAndFinishTransaction(purchasedItem);
          print("******************************************************************************************************************************");
        }
        break;
      default:
        _callErrorListeners("something went wrong");
      // if (_authenticationController
      //     .registrationModel.value.subscriptionDetail?.type !=
      //     "FREE") {
      //   //SubscriptionController.membershipUpdate(type: "FREE", strJson: '');
      // }
    }
  }

  Future<bool> _verifyPurchase(PurchasedItem purchasedItem) {
    return Future<bool>.value(true);
  }

  /// Call this method when status of purchase is success
  /// Call API of your back end to verify the reciept
  /// back end has to call billing server's API to verify the purchase token
  _verifyAndFinishTransaction(PurchasedItem purchasedItem) async {
    bool isValid = false;
    try {
      // Call API
      isValid = await _verifyPurchase(purchasedItem);
    } catch (e) {
      _callErrorListeners("No internet");
      return;
    }
    if (isValid) {
      FlutterInappPurchase.instance.finishTransaction(purchasedItem);
      _isProUser = true;
      // save in sharedPreference here

      ///needed
      if (purchasedItem.productId == 'monthly_auto' || purchasedItem.productId == 'year_auto') {
        // StringRes.strTransactionReceipt = "${purchasedItem.transactionReceipt}";

        ///change the type accordingly by user select subscription

        showMessageStreamController.add(1);

        print("${purchasedItem.transactionStateIOS}");

        /// devicetype && purchasedItem.transactionReceipt
        // await SubscriptionController.membershipUpdate(
        //     type: purchasedItem.productId == 'monthly_auto'
        //         ? 'MONTHLY'
        //         : 'YEARLY',
        //     strJson: purchasedItem.transactionReceipt ?? "");
        //
        // await _authenticationController.subScribeDateCheck();
      }
      _callProStatusChangedListeners();
    } else {
      showMessageStreamController.add(0);
      _callErrorListeners("verification failed");
    }
  }

  purchase(pid, transactionDate, purchaseId, expiredDate) {}

  Future<List<IAPItem>?> get products async {
    if (_products == null) {
      await getItems();
    }
    return _products;
  }

  Future<void> getItems() async {
    try {
      List<IAPItem> items = await FlutterInappPurchase.instance.getSubscriptions(_productIds);
      _products = [];
      for (var item in items) {
        this._products!.add(item);
        //print("iteam  1--------->${_products}");
      }
      // SubscriptionController subscribeController = Get.find();
      // subscribeController.monthLocalizedPrice =
      //     _products?.first.localizedPrice ?? "\$2.99";
      // subscribeController.yearLocalizedPrice =
      //     _products?.last.localizedPrice ?? "\$22.99";
    } catch (e) {
      log("getIteam Error----->$e");
    }
  }

  void getPastPurchases() async {
    // remove this if you want to restore past purchases in iOS
    if (Platform.isIOS) {
      return;
    }
    List<PurchasedItem>? purchasedItems = await FlutterInappPurchase.instance.getAvailablePurchases();

    for (var purchasedItem in purchasedItems!) {
      bool isValid = false;

      if (Platform.isAndroid) {
        Map map = json.decode(purchasedItem.transactionReceipt!);
        // if your app missed finishTransaction due to network or crash issue
        // finish transactins
        if (!map['acknowledged']) {
          isValid = await _verifyPurchase(purchasedItem);

          print("isValid :- $isValid");
          if (isValid) {
            FlutterInappPurchase.instance.finishTransaction(purchasedItem);
            _isProUser = true;
            _callProStatusChangedListeners();
          }
        } else {
          _isProUser = true;
          _callProStatusChangedListeners();
        }
      }
    }
    _pastPurchases = [];
    _pastPurchases!.addAll(purchasedItems);
  }

  Future<Null> buyProduct(item) async {
    try {
      await FlutterInappPurchase.instance.requestSubscription(item);
    } catch (error) {
      log("error ----------------->$error");
    } finally {
      // _subscribeController.isLoader.value = false;
    }
  }
}
