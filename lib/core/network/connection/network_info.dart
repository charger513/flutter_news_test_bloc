import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../repositories/network_info_contract.dart';

class NetworkInfo implements NetworkInfoContract {
  final InternetConnectionChecker internetConnection;

  NetworkInfo(this.internetConnection);

  @override
  Future<bool> get isConnected => internetConnection.hasConnection;
}
