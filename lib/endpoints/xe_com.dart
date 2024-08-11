import 'package:curcio/data/currency_data.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

const kXeComUrl = 'https://www.xe.com/currencyconverter/convert/';

class FetchExchangeData {
  CurrencyData currencyData = CurrencyData();
  Future<double?> fetchExchangeRate(
      {required String fromCurrency,
      required String toCurrency,
      String amount = '1'}) async {
    final url = Uri.parse('$kXeComUrl?Amount=$amount&From'
        '=$fromCurrency&To=$toCurrency');

    try {
      final response = await http.get(url);

      currencyData.setApiStatus = response.statusCode;
      if (response.statusCode == 200) {
        // Parse the HTML response
        final document = parser.parse(response.body);

        // Use a CSS selector to find the conversion rate element
        final element = document.querySelector('.sc-e08d6cef-1.fwpLse');
        if (element != null) {
          // Extract the rate and convert it to a double
          final rateText = element.text.split(' ')[0].replaceAll(',', '');
          return double.tryParse(rateText);
        } else {
          print('Conversion rate not found.');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }
}

void main() async {
  FetchExchangeData fetchExchangeData = FetchExchangeData();
  final fromCurrency = 'USD';
  final toCurrency = 'PKR';
  final amount = '1000';
  final rate = await fetchExchangeData.fetchExchangeRate(
      fromCurrency: fromCurrency, toCurrency: toCurrency, amount: amount);
  if (rate != null) {
    print('$amount $fromCurrency = $rate $toCurrency');
  } else {
    print('Failed to fetch exchange rate.');
  }
}
//For Flags
///https://www.xe.com/svgs/flags/pkr.static.svg
