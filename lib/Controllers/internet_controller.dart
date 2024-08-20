import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class InternetController extends GetxController {
  final _connectionType = MConnectivityResult.none.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _streamSubscription;

  MConnectivityResult get connectionType => _connectionType.value;

  set connectionType(MConnectivityResult value) {
    _connectionType.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    getConnectivityType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> getConnectivityType() async {
    List<ConnectivityResult> connectivityResults;
    try {
      connectivityResults = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      connectivityResults = [ConnectivityResult.none]; // Handle exception by assuming no connection
    }
    _updateState(connectivityResults);
  }

  void _updateState(List<ConnectivityResult> results) {
    // Handle the first result or iterate over the list if necessary
    ConnectivityResult result = results.isNotEmpty ? results.first : ConnectivityResult.none;

    switch (result) {
      case ConnectivityResult.wifi:
        connectionType = MConnectivityResult.wifi;
        break;
      case ConnectivityResult.mobile:
        connectionType = MConnectivityResult.mobile;
        break;
      case ConnectivityResult.none:
        connectionType = MConnectivityResult.none;
        break;
      default:
        print('Failed to get connection type');
        break;
    }
    
  }
    bool get isConnected => connectionType != MConnectivityResult.none;


  @override
  void onClose() {
    _streamSubscription.cancel();
    super.onClose();
  }
}

enum MConnectivityResult { none, wifi, mobile }
