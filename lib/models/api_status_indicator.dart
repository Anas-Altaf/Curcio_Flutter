import 'package:curcio/components/toast.dart';
import 'package:curcio/constants.dart';
import 'package:curcio/data/currency_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApiStatusIndicator extends StatelessWidget {
  const ApiStatusIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    ToastUtil.init(context);
    var serviceStatus = Provider.of<CurrencyData>(context).getApiStatus;
    return IconButton(
        icon: const Icon(Icons.webhook),
        color: serviceStatus == 200 ? kStatusIndicatorColor : Colors.redAccent,
        onPressed: () {
          if (serviceStatus == 200) {
            ToastUtil.showErrorToast(
                message: 'Server Status Success', toastColor: Colors.green);
          } else {
            ToastUtil.showErrorToast(
                message: 'Service Unavailable!, Check your '
                    'Connection.',
                toastColor: Colors.redAccent);
          }
        });
  }
}
