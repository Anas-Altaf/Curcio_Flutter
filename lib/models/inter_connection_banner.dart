import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curcio/constants.dart';
import 'package:flutter/material.dart';

class InternetStatusBanner extends StatefulWidget {
  const InternetStatusBanner({super.key});

  @override
  _InternetStatusBannerState createState() => _InternetStatusBannerState();
}

class _InternetStatusBannerState extends State<InternetStatusBanner> {
  List<ConnectivityResult> _connectionStatuses = [];
  final Connectivity _connectivity = Connectivity();

  final Map<ConnectivityResult, IconData> _banners = {
    ConnectivityResult.wifi: Icons.wifi,
    ConnectivityResult.mobile: Icons.signal_cellular_alt,
    ConnectivityResult.ethernet: Icons.settings_ethernet,
    ConnectivityResult.bluetooth: Icons.bluetooth,
    ConnectivityResult.vpn: Icons.vpn_key_sharp,
    ConnectivityResult.other: Icons.signal_cellular_alt,
    ConnectivityResult.none: Icons.signal_wifi_connected_no_internet_4,
  };

  @override
  void initState() {
    super.initState();
    _initConnectivity();
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      _updateConnectionStatus(results);
    });
  }

  Future<void> _initConnectivity() async {
    List<ConnectivityResult> results;
    try {
      results = await _connectivity.checkConnectivity();
      _updateConnectionStatus(results);
    } on Exception catch (_) {
      results = [ConnectivityResult.none];
    }
    if (!mounted) return;
    setState(() {
      _connectionStatuses = results;
    });
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    if (!mounted) return;
    setState(() {
      _connectionStatuses =
          results.isEmpty ? [ConnectivityResult.none] : results;

      // Remove 'none' if any network is connected
      if (_connectionStatuses.contains(ConnectivityResult.none) &&
          _connectionStatuses.length > 1) {
        _connectionStatuses.remove(ConnectivityResult.none);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Icon(
        // size: 15,
        _connectionStatuses.isNotEmpty
            ? _banners[_connectionStatuses.first]
            : Icons.signal_wifi_off,
        color: _connectionStatuses.isNotEmpty &&
                _connectionStatuses.first == ConnectivityResult.none
            ? Colors.red
            : kStatusIndicatorColor,
      ),
    );
  }
}
