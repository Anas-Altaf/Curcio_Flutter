import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curcio/components/toast.dart';
import 'package:curcio/constants.dart';
import 'package:flutter/material.dart';

class InternetStatusBanner extends StatefulWidget {
  const InternetStatusBanner({super.key});

  @override
  State<InternetStatusBanner> createState() => _InternetStatusBannerState();
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
    ConnectivityResult.none: Icons.wifi_off,
  };

  @override
  void initState() {
    super.initState();
    ToastUtil.init(context);
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

      if (_connectionStatuses.contains(ConnectivityResult.none) &&
          _connectionStatuses.length > 1) {
        _connectionStatuses.remove(ConnectivityResult.none);
      }
    });
  }

  Icon getIcon() {
    return Icon(
      _connectionStatuses.isNotEmpty
          ? _banners[_connectionStatuses.first]
          : Icons.wifi_off,
      color: _connectionStatuses.isNotEmpty &&
              _connectionStatuses.first == ConnectivityResult.none
          ? Colors.red
          : kStatusIndicatorColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: IconButton(
        // size: 15,
        icon: getIcon(),
        onPressed: () {
          if (_connectionStatuses.isNotEmpty &&
              _connectionStatuses.first == ConnectivityResult.none) {
            ToastUtil.showErrorToast(
                message: 'No internet available!, Check your connection.',
                toastColor: Colors.redAccent);
          } else {
            ToastUtil.showErrorToast(
                message: 'Connected to internet.', toastColor: Colors.green);
          }
        },
      ),
    );
  }
}
