import 'package:html/parser.dart' as htmlParser;
import 'package:http/http.dart' as http;

Future<String> fetchExchangeRate(String fromCurrency, String toCurrency) async {
  final url = 'https://www.bloomberg.com/quote/$fromCurrency$toCurrency:CUR';

  try {
    // Make an HTTP GET request to the URL
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Parse the HTML content
      final document = htmlParser.parse(response.body);

      // Find the element containing the exchange rate
      final rateElement = document.querySelector(
          'div.currentPrice_currentPriceContainer__nC8vw > div.sized-price');

      if (rateElement != null) {
        // Extract and print the exchange rate
        final rate = rateElement.text.trim();

        print('Exchange Rate ($fromCurrency to $toCurrency): $rate');
        return rate;
      } else {
        print('Failed to find the exchange rate element.');
      }
    } else {
      print('Failed to load the page. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  return 'null';
}

void main() async {
  final fromCurrency = 'USD';
  final toCurrency = 'PKR';

  final rate = await fetchExchangeRate(fromCurrency, toCurrency);
  if (rate != 'null') {
    print('1 $fromCurrency = ${double.tryParse(rate)} $toCurrency');
  } else {
    print('Failed to fetch exchange rate.');
  }
}
