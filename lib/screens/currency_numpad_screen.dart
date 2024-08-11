import 'package:curcio/components/rounded_button.dart';
import 'package:curcio/constants.dart';
import 'package:curcio/data/currency_data.dart';
import 'package:curcio/models/api_status_indicator.dart';
import 'package:curcio/models/inter_connection_banner.dart';
import 'package:curcio/screens/currency_conversion_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyNumPadScreen extends StatelessWidget {
  const CurrencyNumPadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Curcio Exchange',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: const ApiStatusIndicator(),
          actions: const [
            InternetStatusBanner(),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: CurrencyConversionScreen(),
            ),
            Expanded(
              flex: 3,
              child: Consumer<CurrencyData>(
                builder: (context, currencyData, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RoundButton(
                            symbol: '7',
                            onPress: () {
                              currencyData.addInput('7');
                            },
                          ),
                          RoundButton(
                            symbol: '8',
                            onPress: () {
                              currencyData.addInput('8');
                            },
                          ),
                          RoundButton(
                            symbol: '9',
                            onPress: () {
                              currencyData.addInput('9');
                            },
                          ),
                          RoundButton(
                            symbol: 'CE',
                            onPress: () {
                              currencyData.clearInput();
                            },
                            buttonColor: kOperatorsButtonColor,
                            buttonTextColor: Colors.white,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RoundButton(
                            symbol: '4',
                            onPress: () {
                              currencyData.addInput('4');
                            },
                          ),
                          RoundButton(
                            symbol: '5',
                            onPress: () {
                              currencyData.addInput('5');
                            },
                          ),
                          RoundButton(
                            symbol: '6',
                            onPress: () {
                              currencyData.addInput('6');
                            },
                          ),
                          RoundButton(
                            symbol: 'C',
                            onPress: () {
                              currencyData.removeLastChar();
                            },
                            buttonColor: kOperatorsButtonColor,
                            buttonTextColor: Colors.white,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RoundButton(
                            symbol: '1',
                            onPress: () {
                              currencyData.addInput('1');
                            },
                          ),
                          RoundButton(
                            symbol: '2',
                            onPress: () {
                              currencyData.addInput('2');
                            },
                          ),
                          RoundButton(
                            symbol: '3',
                            onPress: () {
                              currencyData.addInput('3');
                            },
                          ),
                          RoundButton(
                            symbol: '.',
                            onPress: () {
                              currencyData.addInput('.');
                            },
                            buttonColor: kOperatorsButtonColor,
                            buttonTextColor: Colors.white,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RoundButton(
                            symbol: '00',
                            onPress: () {
                              currencyData.addInput('00');
                            },
                            width: kInputButtonWidth * 2,
                            shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          RoundButton(
                            symbol: '0',
                            onPress: () {
                              currencyData.addInput('0');
                            },
                          ),
                          RoundButton(
                            symbol: '=',
                            onPress: () {
                              currencyData.notifyListenersManually();
                            },
                            buttonColor: kOperatorsButtonColor,
                            buttonTextColor: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
