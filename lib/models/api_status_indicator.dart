import 'package:curcio/constants.dart';
import 'package:curcio/data/currency_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApiStatusIndicator extends StatelessWidget {
  const ApiStatusIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.webhook,
      color: Provider.of<CurrencyData>(context).getApiStatus == 200
          ? kStatusIndicatorColor
          : Colors.red,
    );
  }
}
