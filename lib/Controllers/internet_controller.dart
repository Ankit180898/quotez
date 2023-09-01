import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class InternetController extends GetxController {
  final RxBool _isConnected = true.obs;

  bool get isConnected => _isConnected.value;

  @override
  void onInit() {
    super.onInit();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    ConnectivityResult connectivityResult;
    try {
      connectivityResult = await Connectivity().checkConnectivity();
    } catch (e) {
      connectivityResult = ConnectivityResult.none;
    }

    updateInternetStatus(connectivityResult);
    Connectivity().onConnectivityChanged.listen(updateInternetStatus);
  }

  void updateInternetStatus(ConnectivityResult connectivityResult) {
    _isConnected.value = connectivityResult != ConnectivityResult.none;
  }
}
