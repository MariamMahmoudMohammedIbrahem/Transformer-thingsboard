import '../commons.dart';

/*class InternetConnectionService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionChangeController =
  StreamController<bool>.broadcast();

  InternetConnectionService() {
    _connectivity.onConnectivityChanged.listen((results) {
      // Pass the first result in the list to _checkConnectionStatus
      if (results.isNotEmpty) {
        _checkConnectionStatus(results.first);
      }
    });
  }

  Stream<bool> get connectionChange => _connectionChangeController.stream;

  void _checkConnectionStatus(ConnectivityResult result) {
    final bool isConnected = result != ConnectivityResult.none;
    _connectionChangeController.add(isConnected);
  }

  void dispose() {
    _connectionChangeController.close();
  }
}*/

class InternetConnectionService extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool _isConnected = true;

  bool get isConnected => _isConnected;

  InternetConnectionService() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      _updateConnectionStatus(result.first);
    });
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    final bool newStatus = result != ConnectivityResult.none;
    if (_isConnected != newStatus) {
      _isConnected = newStatus;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
