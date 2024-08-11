import 'package:curcio/constants.dart';
import 'package:curcio/data/currency_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

final FocusNode _upperFocusNode = FocusNode();
final FocusNode _lowerFocusNode = FocusNode();

VerticalDirection currencyBarPlacement = VerticalDirection.down;

class CurrencyConversionScreen extends StatelessWidget {
  final TextEditingController _upperTextController = TextEditingController();
  final TextEditingController _lowerTextController = TextEditingController();

  CurrencyConversionScreen({super.key});

  void updateCursorToEnd() {
    final text1 = _upperTextController.text;
    _upperTextController.selection = TextSelection.fromPosition(
      TextPosition(offset: text1.length),
    );
    final text2 = _lowerTextController.text;
    _lowerTextController.selection = TextSelection.fromPosition(
      TextPosition(offset: text2.length),
    );
    currencyBarPlacement == VerticalDirection.down
        ? _upperFocusNode.requestFocus()
        : _lowerFocusNode.requestFocus();
  }

  void updateTextFields(CurrencyData currencyData) async {
    double currentInput = 0.0;
    if (currencyBarPlacement == VerticalDirection.down) {
      currentInput = currencyData.getInput;
      _upperTextController.text = currentInput.toStringAsFixed(2);
      double results = await currencyData.getConversionResult(
        fromCurrency: currencyData.getUpperCurrentValue,
        toCurrency: currencyData.getLowerCurrentValue,
      );
      _lowerTextController.text = (results * currentInput).toStringAsFixed(2);
    } else {
      currentInput = currencyData.getInput;
      _lowerTextController.text = currentInput.toStringAsFixed(2);
      double results = await currencyData.getConversionResult(
        fromCurrency: currencyData.getLowerCurrentValue,
        toCurrency: currencyData.getUpperCurrentValue,
      );
      _upperTextController.text = (results * currentInput).toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyData>(
      builder: (context, currencyData, child) {
        _upperTextController.addListener(updateCursorToEnd);
        updateTextFields(currencyData);
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              verticalDirection: currencyData.getCurrencyBarPlacement,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgImageBox(
                          currentCountryValue:
                              currencyData.getUpperCurrentValue),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: CurrencyDropDownButton(
                          currentValue: currencyData.getUpperCurrentValue,
                          currencyMap: currencyData.currencyList,
                          dropDownValueChangeCallBack: (value) {
                            currencyData.setUpperCurrentValue = value!;
                          },
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: CurrencyDisplayText(
                          controller: _upperTextController,
                          onPress: () {},
                          helperText:
                              currencyBarPlacement == VerticalDirection.down
                                  ? 'From'
                                  : 'To',
                          focusNode: _upperFocusNode,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: MiddleIconButton(
                    onPress: () {
                      currencyData.setCurrencyBarPlacement =
                          currencyBarPlacement == VerticalDirection.down
                              ? VerticalDirection.up
                              : VerticalDirection.down;
                      currencyBarPlacement =
                          currencyData.getCurrencyBarPlacement;
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgImageBox(
                          currentCountryValue:
                              currencyData.getLowerCurrentValue),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: CurrencyDropDownButton(
                          currentValue: currencyData.getLowerCurrentValue,
                          currencyMap: currencyData.currencyList,
                          dropDownValueChangeCallBack: (value) {
                            currencyData.setLowerCurrentValue = value!;
                          },
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: CurrencyDisplayText(
                          controller: _lowerTextController,
                          onPress: () {},
                          helperText:
                              currencyBarPlacement == VerticalDirection.down
                                  ? 'To'
                                  : 'From',
                          focusNode: _lowerFocusNode,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MiddleIconButton extends StatelessWidget {
  const MiddleIconButton({super.key, required this.onPress});
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: IconButton(
        constraints: const BoxConstraints(
          minWidth: 60,
          minHeight: 60,
        ),
        style: IconButton.styleFrom(
          backgroundColor: kMainBlueColor,
          shape: const CircleBorder(),
        ),
        onPressed: onPress,
        icon: const Icon(
          Icons.multiple_stop,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

class CurrencyDisplayText extends StatelessWidget {
  const CurrencyDisplayText(
      {super.key,
      required this.onPress,
      this.helperText = '',
      this.controller,
      this.focusNode});
  final VoidCallback onPress;

  final String helperText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      canRequestFocus: true,
      textAlign: TextAlign.right,
      readOnly: true,
      controller: controller,
      // showCursor: true,
      cursorHeight: 25,
      style: kCurrencyRateDisplayTextStyle,
      onTap: onPress,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        helperText: helperText,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: kCurrencyTextFieldBorderColor,
          ),
        ),
        filled: true,
        fillColor: kCurrencyDisplayBackgroundColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}

class SvgImageBox extends StatelessWidget {
  const SvgImageBox({
    super.key,
    required this.currentCountryValue,
    this.size = 50,
  });
  final double size;
  final String? currentCountryValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1000),
        child: SvgPicture.asset(
          'assets/images/$currentCountryValue.svg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

//DropDown Button
// Generate DropdownMenuItems with an image from a Map
List<DropdownMenuItem<String>> getCurrencyListDropDown(
    Map<String, String> currencyMap) {
  return currencyMap.entries.map((entry) {
    final String currencyCode = entry.key.toUpperCase();
    final String currencyName = entry.value;
    return DropdownMenuItem<String>(
      value: currencyCode,
      child: Row(
        children: [
          SvgImageBox(
            currentCountryValue: currencyCode,
            size: 30,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currencyCode,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 20,
                  ),
                ),
                Text(
                  currencyName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: kCurrencyTextFieldBorderColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();
}

class CurrencyDropDownButton extends StatelessWidget {
  const CurrencyDropDownButton({
    super.key,
    required this.currentValue,
    required this.currencyMap,
    required this.dropDownValueChangeCallBack,
  });

  final String currentValue;
  final Map<String, String> currencyMap;
  final ValueChanged<String?> dropDownValueChangeCallBack;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      underline: const Text(''),
      alignment: Alignment.topLeft,
      borderRadius: BorderRadius.circular(10.0),
      style: TextStyle(
        fontSize: 20,
        color: Colors.grey.shade800,
        fontWeight: FontWeight.w500,
      ),
      items: getCurrencyListDropDown(currencyMap),
      value: currentValue,
      hint: const Text('USD'),
      onChanged: dropDownValueChangeCallBack,
      selectedItemBuilder: (BuildContext context) {
        // This defines how the selected item appears (only the code without the image)
        return currencyMap.entries.map<Widget>((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                entry.value,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Text(
                entry.key,
                style: const TextStyle(
                  color: Colors.black87,
                ),
              ),
            ],
          );
        }).toList();
      },
      dropdownColor: Colors.white,
      menuWidth: 200,
      itemHeight: null,
      isExpanded: true,
    );
  }
}
